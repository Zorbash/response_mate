# Responsible for the recorded responses as files
class ResponseMate::Tape
  # Writes the tape as a file
  def write(key, request, response, meta = {}, output_dir = nil) # rubocop:disable Metrics/AbcSize
    output_dir ||= ResponseMate.configuration.output_dir

    output_path = File.join output_dir, "#{key}.yml"

    File.open(output_path, 'w') do |f|
      file_content = {
        request: request.to_hash.select { |_, v| !v.nil? },
        response: {
          status: response.status,
          headers: _utf8_encode(response.headers.to_hash),
          body: _utf8_encode(response.body)
        },
        created_at: Time.now
      }

      file_content.merge!(meta: meta) if meta.present?

      f << file_content.to_yaml
    end
  rescue Errno::ENOENT
    raise ResponseMate::OutputDirError.new(output_dir)
  end

  private

  def _utf8_encode(object)
    if object.respond_to? :force_encoding
      object.force_encoding('UTF-8').
             encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    elsif object.is_a? Hash
      object.reduce({}) do |h, (k, v)|
        key = k.dup unless k.is_a? Symbol

        h[_utf8_encode(key)] = _utf8_encode(v)
        h
      end
    elsif object.respond_to? :each
      object.each { |v| _utf8_encode(v) }
    end
  end

  class << self
    def load(key)
      YAML.load_file(File.join(ResponseMate.configuration.output_dir, "#{key}.yml")).
        symbolize_keys
    end
  end
end

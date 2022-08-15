module Numberish
  class Config

    attr_reader :data

    def self.hedges
      data[@local || :en][:hedges]
    end

    def self.scales
      data[:scales]
    end

    def self.filename=(newfile)
      @data = nil
      @filename = newfile
    end

    def self.locale=(locale)
      @local = local
    end

    def self.data=(newdata)
      @data = newdata
    end

    private

    def self.filename
      @filename ||= File.join(File.dirname(__FILE__),"resources/config.yml")
    end

    def self.data
      return @data if @data
      @data = YAML.load_file(filename).deep_symbolize_keys
    end

  end
end

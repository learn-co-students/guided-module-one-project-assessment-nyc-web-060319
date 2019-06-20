# Imports the Google Cloud client library
require "google/cloud/translate"



class Translator
    # Your Google Cloud Platform project ID
    @@project_id = "api-project-128478077786"
    attr_accessor :translate
    def initialize(translation_enabled, target_language)
        # Instantiates a client
        @translation_enabled = translation_enabled
        @translate = Google::Cloud::Translate.new project:(@@project_id)
        @target_language = target_language
    end

    def translate_text(text_to_translate)
        # binding.pry
        if @translation_enabled
            return (@translate.translate text_to_translate, to: @target_language).text
        else
            return text_to_translate
        end
    end

    def self.get_languages
        temp_translate = Google::Cloud::Translate.new project: @@project_id
        temp_translate.languages
    end
end
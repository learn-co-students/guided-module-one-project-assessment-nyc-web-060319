# Imports the Google Cloud client library
require "google/cloud/translate"



class Translator
    # Your Google Cloud Platform project ID
    @@project_id = "api-project-128478077786"
    attr_accessor :translate
    def initialize(target_language)
        # Instantiates a client
        @translate = Google::Cloud::Translate.new project:(@@project_id)
        @target_language = target_language
    end

    def translate_text(text_to_translate)
        # binding.pry
        translated = (@translate.translate text_to_translate.answer, to: @target_language).text
    end
end
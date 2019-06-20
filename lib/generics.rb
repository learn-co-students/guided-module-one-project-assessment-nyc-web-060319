require_relative "cloud/google_translate_api.rb"

module Interactor
    attr_accessor :translation_enabled
    attr_accessor :translator
    def run
        begin
            puts "Beginning interactive loop mode..."
            puts "control + c to exit."
            run_loop
        rescue Interrupt => _
            puts "ok, done with interactive loop mode."
            return
        end
    end

    def run_loop
        while(true) do
            talk_to_user
        end
    end

    def translate_if_configured(text)
        if @translation_enabled
            return @translator.translate_text(text)
        end
        text
    end
end

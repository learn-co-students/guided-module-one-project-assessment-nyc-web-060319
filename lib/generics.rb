
module Interactor
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
end

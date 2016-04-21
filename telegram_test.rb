require 'eventmachine'
require 'telegram'

EM.run do
  telegram = Telegram::Client.new do |cfg|
    cfg.daemon = '/home/truong/code/tg/bin/telegram-cli'
    cfg.key = '/home/truong/code/tg/tg_server.pub'
    cfg.sock = '/home/truong/code/tg/tele.sock'
  end

  telegram.connect do
    # This block will be executed when initialized.

    # See your telegram profile
    puts telegram.profile

    telegram.contacts.each do |contact|
      puts contact
    end

    telegram.chats.each do |chat|
      puts chat
    end

    # Event listeners
    # When you've received a message:
    telegram.on[Telegram::EventType::RECEIVE_MESSAGE] = Proc.new { |event|
      # `tgmessage` is TelegramMessage instance
      puts event.tgmessage
    }
    # When you've sent a message:
    telegram.on[Telegram::EventType::SEND_MESSAGE]= Proc.new { |event|
      puts event
    }
  end
end
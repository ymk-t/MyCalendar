json.set! :events do
    json.array! @events do |event|
        json.extract! event, :id, :title, :start, :end, :allday
    end
end
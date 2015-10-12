class Events::NewNote < Event
  def self.publish!(note)
    event = create!(kind: 'new_note',
    				eventable: note)

    event
  end

  def group_key
    discussion.group.key
  end

  def note
  	eventable
  end

end
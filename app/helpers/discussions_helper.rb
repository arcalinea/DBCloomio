module DiscussionsHelper
  include Twitter::Extractor
  include Twitter::Autolink
  def discussion_activity_count_for(discussion, user)
    discussion.as_read_by(user).unread_comments_count
  end

  def enabled_icon_class_for(discussion, user)
    if discussion.as_read_by(user).unread_content_exists?
      "enabled-icon"
    else
      "disabled-icon"
    end
  end

  def css_class_unread_discussion_activity_for(page_group, discussion, user)
    css_class = "discussion-preview"
    css_class += " showing-group" if (not discussion.group.parent_id.nil?) && (page_group && (page_group.parent_id.nil?))
    css_class += " unread" if discussion.as_read_by(user).unread_content_exists?
    css_class
  end

  def css_class_for_closing_at(motion)
    css_class = "popover-close-date label"

    if motion.voting?
      hours_left = (((Time.now - motion.closing_at) / 60) / 60) * -1
      css_class += " color-urgent" if hours_left < 30
      css_class += " color-warning" if (hours_left >= 3) && (hours_left <= 24)
      css_class += " color-ok" if hours_left > 24
    end
    css_class
  end

  def add_mention_links(comment)
    auto_link_usernames_or_lists(comment, :username_url_base => "#", :username_include_symbol => true)
  end

  def css_for_markdown_link(target, setting)
    return "icon-ok" if (target.uses_markdown == setting)
  end

  def markdown_img(uses_markdown)
    if uses_markdown
      image_tag("markdown_on.png", class: 'markdown-icon markdown-on')
    else
      image_tag("markdown_off.png", class: 'markdown-icon markdown-off')
    end
  end
end

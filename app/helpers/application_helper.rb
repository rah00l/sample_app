module ApplicationHelper

  # Returns the javascript tags that are included in the html layout head
  def javascript_heads
    tags = javascript_include_tag('jquery-1.11.1-ui-1.11.0-ujs-3.1.1', 'application')
    # unless User.current.pref.warn_on_leaving_unsaved == '0'
    #   tags << "\n".html_safe + javascript_tag("$(window).load(function(){ warnLeavingUnsaved('#{escape_javascript l(:text_warn_on_leaving_unsaved)}'); });")
    # end
    tags
  end

  def principals_check_box_tags(name, principals)
    s = ''
    principals.each do |principal|
      s << "<label>#{ check_box_tag name, principal.name, false, :id => nil } #{h principal.name}</label>\n"
    end
    s.html_safe
  end

  def tags_text_field(object, tags)
    formmated_tag_list = tags.map(&:inspect).join(',') unless tags.blank?
    formatted_tag_values = formmated_tag_list.gsub(/"|'/, '')
    # debugger
    tag_list = text_field_tag 'book[tag_list]', formatted_tag_values #, c, :id => nil 
    tag_list.html_safe
    # tag_list = ''
    # tags.map do |tag|
      # c = checked.nil? ? object.watched_by?(user) : checked
      # book[tag_list]
      #= f.text_field :tag_list
      # tag_list = text_field_tag 'book[tag_list]', tag.id, c, :id => nil
      # content_tag 'label', "#{tag} #{h(user)}".html_safe,
                  # :id => "issue_watcher_user_ids_#{user.id}",
                  # :class => "floating"
    # end.join.html_safe
  def identify_resource(params)
    if params["identifier"] == "product"
      return @product,params["identifier"]
    elsif params["identifier"] == "book"
      return @book,params["identifier"]
    else

    end
  end

end

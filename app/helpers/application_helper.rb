# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  CITY_SECTIONS = {
    'Downtown East' => 1,
    'Downtown West' => 2,
    'Point Douglas North' => 3,
    'Point Douglas South' => 4,
    'St. Boniface West' => 5,
    'St. Boniface East' => 6,
    'River Heights East' => 7,
    'River Heights West' => 8,
    'River East South' => 9,
    'River East West' => 10,
    'River East East' => 11,
    'Transcona' => 12,
    'St. Vital North' => 13,
    'St. Vital South' => 14,
    'Fort Garry North' => 15,
    'Fort Garry South' => 16,
    'Assiniboine South' => 17,
    'St. James-Assiniboia West' => 18,
    'St. James-Assiniboia East' => 19,
    'Inkster West' => 20,
    'Inkster East' => 21,
    'Seven Oaks West' => 22,
    'Seven Oaks East' => 23
  }
  
  # print a row with a label in cell 1, and an underlined value in cell 2 
  # (with extra blank underlined space)
  def delivery_sheet_row(label, value)
    value_size = value.blank? ? 0 : value.size
    value_size = 35 if (35 - value_size) < 0
    src = ''
    src << "<tr>"
    src << "<td align='right' valign='top'> #{label}:&nbsp;</td>"
    src << "<td><u> #{value}#{'&nbsp;'*(35-value_size)}</u></td>"
    src << "</tr>"
  end
  
  def delivery_sheet_item_td(value)
    src = "<td>#{value}</td>"
  end
  
  def underlined_with_spaces(value, number_of_spaces)
    src = "<u> #{value} #{'&nbsp;'*number_of_spaces}</u>"
  end
  
  def underlined_empty_row(number_of_spaces)
    src = "<tr><td>&nbsp;</td><td><u>#{'&nbsp;'*number_of_spaces}</u></td>"
  end
  
  # valid png icons are: edit, view, index, delete, package, deliver
  def link_to_icon(icon, the_path)
    html_options = (icon == :delete) ? {
                    :method   => :delete,
                    :confirm  => "Are you sure? Clicking 'OK' will remove this record permanently!",
                    :title    => "Delete",
                    :alt_text => "Delete"
                    } : {}
    link_to(image_tag("#{icon.to_s}.png", :alt => "#{icon.to_s.upcase}"), the_path, {:title => "#{icon.to_s.upcase}"}.merge(html_options))
  end
  
  
  #--------------------------------------------------------------------------
  # Common display formatting for pagination links and descriptive text.
  # (Meant for use in the thead and tfoot of an index table.)
  # params:
  #       items:          The paginated items to generate links for
  #       item_name:      The singular form of the item name being paginated
  #       columns:        The number of columns in the index table (so the pagination area can be properly formatted)
  #       paginate_opts:  Any addition options to be passed to will_paginate (eg. remote specifier, etc)
  #
  def pagination_display(items, item_name, columns, paginate_opts)
    # show a row before the column header row, which contains a "wordy total" of the displayed results
    #(note: we don't include the %head in this partial, because it needs to be put in the calling file)
    src = ''
    src << "<tr>"
    # try to go half_way (in the case of odd column totals, this will yeild the integer closest to half way)
    half_way = (columns.to_i)/2
    src << "<th colspan = '#{half_way}'>"
    src << (will_paginate(items, paginate_opts) || "")
    src << "</th>"
    src << "<th colspan = '#{half_way + columns.to_i.remainder(2)}', style = 'text-align: right'>"
    src << page_entries_info(items, :entry_name => item_name)
    src << "</th>"
    src << "</tr>"
    src
  end
  #--------------------------------------------------------------------------
  
  #--------------------------------------------------------------------------
  # Common display formatting for an index page with search area at the top (and usually an "Add new ..." button)
  # (if an Add button should not be on the page, set title_for_add_button to blank or nil)
  #
  # params:
  #       page_title:            The title displayed in h2 tags at the top of the page
  #       title_for_add_button:  The text put on the button above the index table, meant for an Add/Create action
  #                                  (if left blank or nil, then no button is shown)
  #       path_for_add_action    The lineage specifier required as input to the Add/Create action permissions checker
  #       search_partial         The name (or path) of the search partial that will be rendered above the index table
  #       index_partial          The name (or path) of the index partial that will be rendered
  #
  def index_display(page_title, title_for_add_button, index_partial)
    src = ''
    src << "<h2> #{page_title}</h2>"
    src << render(:partial => "shared/flashes")
    
    src << '<table>'
    src << '<tr><td>'
    src << render(:partial => index_partial)
    src << "</td></tr>"
    src << '</table>'
    src
    
  end
  #--------------------------------------------------------------------------
  
  #--------------------------------------------------------------------------
  # Common display formatting for an index table view of a collection 
  # (includes table header and footer pagination)
  #
  # params:
  #       column_titles:          An array of column titles for the index table to be displayed
  #       items:                  The paginated items
  #       item_name:              The singular form of the item name being paginated
  #       row_partial:            The name (or path) of the row partial to call with the collection of items
  #       row_partial_local_opts: Any local parameters that need to be passed to the row partial
  #       pagination_opts:        Any addition options to be passed to will_paginate (eg. remote specifier, etc)
  #
  def collection_index_display(column_titles, items, item_name, row_partial, row_partial_local_opts = {}, pagination_opts = {})
    src = ''
    src << "<table id=\"#{item_name.downcase.pluralize}\" class='data'>"
    src << '<thead>'
    #src << pagination_display(items, item_name, column_titles.size, pagination_opts) unless items.nil?
    src << '<tr>'
    for title in column_titles do
      src << "<th>#{title}</th>"
    end
    src << '</tr>'
    src << '</thead>'
    if (!items.blank?) then
      src << '<tbody>'
      src << render(:partial => row_partial, :collection => items, :locals => row_partial_local_opts)
      src << '</tbody>'
      
      src << '<tfoot>'
      #src << pagination_display(items, item_name, column_titles.size, pagination_opts)
      src << '</tfoot>'
    end
    src << '</table>'
    src
  end
  #--------------------------------------------------------------------------
  
  def show_field(field, title)
    src = ''
    src << '<li>'
    src << "<label>#{title}</label>"
    src << "#{field}"
    src << '&nbsp;</li>'
    src
  end
  
  def table_row(value)
    "<td>#{value}</td>"
  end
  
  def table_header(items, column_titles, row_partial, row_partial_local_opts = {})
    src = ''
    src << "<table class='data'>"
    src << '<thead>'
    src << '<tr>'
    for title in column_titles do
      src << "<th>#{title}</th>"
    end
    src << '</tr>'
    src << '</thead>'
    if (!items.blank?) then
      src << '<tbody>'
      src << render(:partial => row_partial, :collection => items, :locals => row_partial_local_opts)
      src << '</tbody>'
    end
    src << '</table>'
    src
  end

end

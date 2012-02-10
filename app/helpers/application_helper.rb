# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


  DOWNTOWN_EAST = 1
  DOWNTOWN_WEST = 2
  POINT_DOUGLAS_NORTH = 3
  POINT_DOUGLAS_SOUTH = 4
  ST_BONIFACE_WEST = 5
  ST_BONIFACE_EAST = 6
  RIVER_HEIGHTS_WEST = 7
  RIVER_HEIGHTS_EAST = 8
  RIVER_EAST_SOUTH = 9
  RIVER_EAST_WEST = 10
  RIVER_EAST_EAST = 11
  TRANSCONA = 12
  ST_VITAL_NORTH = 13
  ST_VITAL_SOUTH = 14
  FORT_GARRY_NORTH = 15
  FORT_GARRY_SOUTH = 16
  ASSINIBOINE_SOUTH = 17
  ST_JAMES_ASSINIBOIA_WEST = 18
  ST_JAMES_ASSINIBOIA_EAST = 19
  INKSTER_WEST = 20
  INKSTER_EAST = 21
  SEVEN_OAKS_WEST = 22
  SEVEN_OAKS_EAST = 23
  
  CITY_SECTIONS = {
    1 => '*OLD* Downtown East (new: A, A-1, D-E, D-C)',
    2 => '*OLD* Downtown West (new: D-W, S-W)',
    3 => '*OLD* Point Douglas North (new: A, A-1, A-2)',
    4 => '*OLD* Point Douglas South (new: A, A-1, A-2, D-C, D-W)',
    5 => '*OLD* St. Boniface West (new: B)',
    6 => '*OLD* St. Boniface East (new: B, S)',
    7 => '*OLD* River Heights West (new: R)',
    8 => '*OLD* River Heights East (new: O)',
    9 => '*OLD* River East South (new: E)',
    10 => '*OLD* River East West (new: K)',
    11 => '*OLD* River East East (new: K)',
    12 => '*OLD* Transcona (new: T)',
    13 => '*OLD* St. Vital North (new: B)',
    14 => '*OLD* St. Vital South (new: V)',
    15 => '*OLD* Fort Garry North (new: R, O, G)',
    16 => '*OLD* Fort Garry South (new: G)',
    17 => '*OLD* Assiniboine South (new: C, W-C)',
    18 => '*OLD* St. James-Assiniboia West (new: W-J)',
    19 => '*OLD* St. James-Assiniboia East (new: J)',
    20 => '*OLD* Inkster West (new: M, S)',
    21 => '*OLD* Inkster East (new: M, S)',
    22 => '*OLD* Seven Oaks West (new: M)',
    23 => '*OLD* Seven Oaks East (new: N)',
    24 => 'Point Douglas (A-1)',
    25 => 'Dufferin to Selkirk (A-2)',
    26 => 'Pritchard to Redwood (A)',
    27 => 'Main to Balmoral (D-E)',
    28 => 'Balmoral to Furby (D-C)',
    29 => 'Sherbrook to Arlington (W)',
    30 => 'Sargent, Wolseley (S-W)',
    31 => 'Weston, Brooklands (S)',
    32 => 'Silver Heights (J)',
    33 => 'Sturgeon Creek (J)',
    34 => 'West Charleswood (W-C)',
    35 => 'Tuxedo, Charleswood (C)',
    36 => 'River Heights (R)',
    37 => 'Fort Garry (G)',
    38 => 'Osborne, Fort Rouge (O)',
    39 => 'St. Vital (V)',
    40 => 'St. Boniface (B)',
    41 => 'Transcona (T)',
    42 => 'Elmwood (E)',
    43 => 'North Kildonan (K)',
    44 => 'West Kildonan (N)',
    45 => 'Maples (M)'
  }
  
  OLD_CITY_SECTIONS = {
    1 => '*OLD* Downtown East (new: A, A-1, D-E, D-C)',
    2 => '*OLD* Downtown West (new: D-W, S-W)',
    3 => '*OLD* Point Douglas North (new: A, A-1, A-2)',
    4 => '*OLD* Point Douglas South (new: A, A-1, A-2, D-C, D-W)',
    5 => '*OLD* St. Boniface West (new: B)',
    6 => '*OLD* St. Boniface East (new: B, S)',
    7 => '*OLD* River Heights West (new: R)',
    8 => '*OLD* River Heights East (new: O)',
    9 => '*OLD* River East South (new: E)',
    10 => '*OLD* River East West (new: K)',
    11 => '*OLD* River East East (new: K)',
    12 => '*OLD* Transcona (new: T)',
    13 => '*OLD* St. Vital North (new: B)',
    14 => '*OLD* St. Vital South (new: V)',
    15 => '*OLD* Fort Garry North (new: R, O, G)',
    16 => '*OLD* Fort Garry South (new: G)',
    17 => '*OLD* Assiniboine South (new: C, W-C)',
    18 => '*OLD* St. James-Assiniboia West (new: W-J)',
    19 => '*OLD* St. James-Assiniboia East (new: J)',
    20 => '*OLD* Inkster West (new: M, S)',
    21 => '*OLD* Inkster East (new: M, S)',
    22 => '*OLD* Seven Oaks West (new: M)',
    23 => '*OLD* Seven Oaks East (new: N)'
  }
  
  NEW_CITY_SECTIONS = {
    24 => 'Point Douglas (A-1)',
    25 => 'Dufferin to Selkirk (A-2)',
    26 => 'Pritchard to Redwood (A)',
    27 => 'Main to Balmoral (D-E)',
    28 => 'Balmoral to Furby (D-C)',
    29 => 'Sherbrook to Arlington (W)',
    30 => 'Sargent, Wolseley (S-W)',
    31 => 'Weston, Brooklands (S)',
    32 => 'Silver Heights (J)',
    33 => 'Sturgeon Creek (J)',
    34 => 'West Charleswood (W-C)',
    35 => 'Tuxedo, Charleswood (C)',
    36 => 'River Heights (R)',
    37 => 'Fort Garry (G)',
    38 => 'Osborne, Fort Rouge (O)',
    39 => 'St. Vital (V)',
    40 => 'St. Boniface (B)',
    41 => 'Transcona (T)',
    42 => 'Elmwood (E)',
    43 => 'North Kildonan (K)',
    44 => 'West Kildonan (N)',
    45 => 'Maples (M)'
  }
  
  #def get_city_section(city_section_id)
  #  return CITY_SECTIONS[city_section_id] if city_section_id < 24
  #  return NEW_CITY_SECTIONS[city_section_id] if city_section_id > 23
  #end
  
  # for use in edit forms
  def city_sections_list(selected_city = nil)
    sections_list = NEW_CITY_SECTIONS.map{|s| [s[1], s[0]]}
    
    # if an old city section is still set, add that to the dropdown list, so it can be shown
    if selected_city and selected_city < 24
      
      sections_list << [CITY_SECTIONS[selected_city], selected_city]
    end
    sections_list
  end
  
  # for use in search dropdowns
  def all_city_sections_list
    #sections_list = []
    sections_list = NEW_CITY_SECTIONS.map{|s| [s[1], s[0]]} | ["---------------------"] | OLD_CITY_SECTIONS.map{|s| [s[1], s[0]]}
    sections_list
  end
  
  def datetime_formatted(the_time)
    the_time.andand.strftime("%a %b %d, %Y - %I:%M %p")  # %Z for timezone
  end
  
  def datetime_formatted_2_line(the_time)
    return "" unless the_time
    time_str = the_time.andand.strftime("%a %b %d, %Y")
    time_str << "<br>"
    time_str << the_time.andand.strftime("%I:%M %p")
    time_str
  end
  
  def date_formatted(the_time)
    the_time.andand.strftime("%a %b %d, %Y")  # %Z for timezone
  end
  
  DS_LINE_MAX = 40 # was 39
  
  # print a row with a label in cell 1, and an underlined value in cell 2 
  # (with extra blank underlined space)
  def delivery_sheet_row(label, value)
    value_size = value.blank? ? 0 : value.size
    value_size = DS_LINE_MAX if (DS_LINE_MAX - value_size) < 0
    src = ''
    src << "<tr>"
    src << "<td width='175px' align='right' valign='top'> #{label}:&nbsp;</td>"
    src << "<td><u> #{value}#{'&nbsp;'*(DS_LINE_MAX-value_size)}</u></td>"
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
  
  def link_to_icon_with_text(icon, text, the_path)
    html_options = (icon == :delete) ? {
                    :method   => :delete,
                    :confirm  => "Are you sure? Clicking 'OK' will remove this record permanently!",
                    :title    => "Delete",
                    :alt_text => "Delete"
                    } : {}
    img = image_tag("#{icon.to_s}.png", :alt => "#{icon.to_s.upcase}")
    img << ' <b>' + text +'</b>'
    link_to(img, the_path, {:title => "#{icon.to_s.upcase}"}.merge(html_options))
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
    #src << '<thead>'
    #src << pagination_display(items, item_name, column_titles.size, pagination_opts) unless items.nil?
    #src << '</thead>'
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
  
  #--------------------------------------------------------------------------
  def show_field(field, title)
    src = ''
    src << '<li>'
    src << "<label>#{title}</label>"
    src << "#{field}"
    src << '&nbsp;</li>'
    src
  end
  #--------------------------------------------------------------------------
  
  #--------------------------------------------------------------------------
  def table_row(value)
    "<td valign=top>#{value}</td>"
  end
  #--------------------------------------------------------------------------
  
  #--------------------------------------------------------------------------
  def index_table(items, column_titles, row_partial, row_partial_local_opts = {})
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
  #--------------------------------------------------------------------------
  
  #--------------------------------------------------------------------------
  def table_header(item_name, items, column_titles, row_partial, row_partial_local_opts = {})
    src = ''
    src << "<table class='data'>"
    src << '<thead>'
    src << pagination_display(items, item_name, column_titles.size, {}) unless items.nil?
    src << '</thead>'
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
      src << pagination_display(items, item_name, column_titles.size, {})
      src << '</tfoot>'
    end
    src << '</table>'
    src
  end
  #--------------------------------------------------------------------------
  
  #--------------------------------------------------------------------------
  def generate_breadcrumbs(request)
    s = ""
    url = request.path.split('?')  #remove extra query string parameters
    levels = url[0].split('/') #break up url into different levels
    levels.each_with_index do |level, index|
      unless level.blank?
        if index == levels.size-1 || 
           (level == levels[levels.size-2] && levels[levels.size-1].to_i > 0)
          s += " / #{level.gsub(/_/, ' ')}" unless level.to_i > 0
        else
            link = "/"
            i = 1
            while i <= index
              link += "#{levels[i]}/"
              i+=1
            end
            s += " / <a href=\"#{link}\">#{level.gsub(/_/, ' ')}</a>"
        end
      end
    end
    s
  end
  #--------------------------------------------------------------------------



end

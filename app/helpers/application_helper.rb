# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

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

end
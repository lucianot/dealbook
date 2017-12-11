module ApplicationHelper

  def application_title
    controller_name = params[:controller]
    action_name = params[:action]

    if action_name == 'show'
      if controller_name == 'companies'
        "#{@company.name} Funding, Investors - Dealbook"
      elsif controller_name == 'deals'
        "#{@deal.company_name} raised funds from #{@deal.buyers_name} #{@deal.full_amount}"
      elsif controller_name == 'investors'
        investments = @investor.deals.count
        companies = @investor.deals.map { |d| d.company_name }.uniq.count
        "#{@investor.name} #{investments} investments in #{companies} companies"
      end
    else
      'Dealbook - The ultimate resource for tech startups and VCs in Brazil'
    end
  end

  def nav_link(text, link, html_options = {})
    recognized = Rails.application.routes.recognize_path(link)
    if recognized[:controller] == params[:controller]
      content_tag(:li, class: "active") do
        link_to(text, link, html_options)
      end
    else
      content_tag(:li) do
        link_to(text, link, html_options)
      end
    end
  end

  # Based on https://gist.github.com/1182136
  class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, rel: rel_value(page)), class: ('active' if page == current_page)
    end

    def gap
      tag :li, link(super, '#'), class: 'disabled'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), class: [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end

  def page_navigation_links(pages)
    will_paginate(pages, class: 'pagination',
                         inner_window: 2,
                         outer_window: 0,
                         renderer: BootstrapLinkRenderer,
                         previous_label: '&larr;'.html_safe,
                         next_label: '&rarr;'.html_safe)
  end
end

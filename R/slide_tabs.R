slide_tabs <- function(slide_df, slide_url) {
  slugify <- function(x) {
    x <- stringr::str_replace_all(x, "[^[:alnum:] ]", "")
    x <- stringr::str_replace_all(x, " ", "-")
    x <- stringr::str_to_lower(x)
    return(x)
  }
  
  nav_li <- function(name, selected = FALSE) {
    select_flag <- ifelse(selected, "true", "false")
    active_flag <- ifelse(selected, " active", "")
    out <- glue::glue('<li class="nav-item">\n',
                      '<a class="nav-link{active_flag}" id="{slugify(name)}-tab" href="#{slugify(name)}" role="tab" ', 
                      'data-toggle="tab" aria-controls="{slugify(name)}" aria-selected="{select_flag}">',
                      '{name}</a>\n',
                      '</li>')
    return(out)
  }
  
  tab_pane <- function(name, slide, active, url, youtube) {
    select_flag <- ifelse(active, " show active", "")
    out <- glue::glue('<div class="tab-pane fade{select_flag}" id="{slugify(name)}" ',
                      'role="tabpanel" aria-labelledby="{slugify(name)}-tab">\n',
                      '<div class="embed-responsive embed-responsive-16by9">\n',
                      '<iframe class="embed-responsive-item" src="{youtube}"',
                      'frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"',
                      'allowfullscreen></iframe>\n</div>\n',
                      '<div class="embed-responsive embed-responsive-16by9" style="float: right;">\n',
                      '<iframe class="embed-responsive-item" src="{url}#{slide}"></iframe>\n',
                      '</div>\n</div>')
    return(out)
  }
  
  sections <- dplyr::mutate(
    slide_df,
    li = purrr::pmap_chr(list(name, active), nav_li),
    pane = purrr::pmap_chr(list(name, slide, active, slide_url, youtube), tab_pane)
  )
  
  tabset <- paste('<ul class="nav nav-tabs" id="slide-tabs" role="tablist">',
                  paste(sections$li, collapse = "\n"),
                  '</ul>',
                  '<div class="tab-content" id="slide-tabs">',
                  paste(sections$pane, collapse = "\n"),
                  '</div>', sep = "\n")
  
  cat(tabset)
}

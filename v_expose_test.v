module vexpose

const (
	URL_STACKOVERFLOW_PT = 'https://pt.stackoverflow.com/'
	URL_STACKOVERFLOW = 'https://stackoverflow.com/'
    URL_GOOGLE = 'https://www.google.com.br/'
    URL_W3SCHOOL = 'https://www.w3schools.com/'
)

fn test_get_links_from_url(){

	mut map_links := get_links_from_url(URL_STACKOVERFLOW_PT)

	assert map_links.len > 0

}

fn test_count_css_from_url(){

	mut amount_css := count_css_from_url(URL_STACKOVERFLOW_PT)

	assert amount_css > 0
}

fn test_count_js_from_url(){

	mut amount_js := count_js_from_url(URL_STACKOVERFLOW_PT)

	assert amount_js > 0
}

fn test_count_html_elements_from_url(){

	mut amount_html := count_html_elements_from_url(URL_STACKOVERFLOW_PT)

	assert amount_html > 0
}

fn test_count_meta_from_url(){

	mut amount_meta := count_meta_from_url(URL_STACKOVERFLOW_PT)

	assert amount_meta > 0
}

fn test_get_jscontent_from_url(){

	mut js_content_list := get_jscontent_from_url(URL_STACKOVERFLOW_PT)

	assert js_content_list.len > 0
}

fn test_get_css_ref_from_url(){

	mut css_ref_list := get_css_ref_from_url(URL_STACKOVERFLOW_PT)

	assert css_ref_list.len > 0

}

fn test_count_js_events_from_url(){

	mut amount_js := count_js_events_from_url(URL_STACKOVERFLOW_PT)

	assert amount_js > 0

}

fn test_get_css_content_from_url(){

	mut css_content_list := get_css_content_from_url(URL_STACKOVERFLOW_PT)

	assert css_content_list.len > 0

}

fn test_count_forms_from_url(){

	mut amount_forms := count_forms_from_url(URL_STACKOVERFLOW_PT)

	assert amount_forms > 0
}

fn test_get_form_info_from_url(){

	mut map_forms_info := get_form_info_from_url(URL_STACKOVERFLOW_PT)

	assert map_forms_info.len > 0

}

fn test_get_onclick_values_from_url(){

	mut onclick_list := get_onclick_values_from_url(URL_STACKOVERFLOW_PT)

	assert onclick_list.len > 0

}

fn test_has_ajax_calls_in_url(){

	mut has_ajax_calls := has_ajax_calls_in_url(URL_STACKOVERFLOW_PT)

	assert has_ajax_calls == false
}

fn test_get_page_size_from_url(){

	mut page_size := get_page_size_from_url(URL_STACKOVERFLOW_PT)

	assert page_size > 0
}

fn test_generate_report(){

	mut report := generate_report(URL_STACKOVERFLOW_PT)

	assert report.len > 0
}
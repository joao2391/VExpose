module main

import net.http
import sync
import time
import json

//Report is a struct that is used in generate_report function
//to make a JSON with all information into it.
pub struct Report {
mut:	
	amount_css int
	amount_js int
	amount_html_elements  int
	amount_meta_elements int
	amount_js_elements int
	amount_forms int
	amount_forms_info int
	amount_js_content int
	amount_onclick_events int
	forms_info map[string]string
	amount_onclick_values []string
	has_ajax_call bool
}

//get_links_from_url retrives all links from URL
pub fn get_links_from_url(url string) map[int]string {

	start := time.ticks()
	data := http.get_text(url)

	mut pos := 0
	mut map_links := map[int]string{}

	for {
		pos = data.index_after('https://', pos + 1)
		if pos == -1 {
			break
		}
		end := data.index_after('"', pos)
		map_links[pos] = data[pos..end]
	}

	finish := time.ticks()
	println('Finish getting time ${finish - start} ms')

	return map_links
}

//count_css_from_url returns an int with the amount of css in the URL
pub fn count_css_from_url(url string) int {

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag('style')
	tags_in_head := doc.get_tag('head')

	mut counter := tags.len

	mut list := []&html.Tag
	
	for i := 0; i < tags.len; i++ {

		list = tags[i].children
	}

	for i := 0; i < tags_in_head.len; i++ {

		list = tags_in_head[i].children		
	}

	for i := 0; i < list.len; i++ {
		
		if list[i].attributes['rel'] == 'stylesheet'{

			counter += 1
		}
		
	}
	
	return counter
}

//count_js_from_url returns an int with the amount of js in the URL
pub fn count_js_from_url(url string) int{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag('script')

	mut counter := tags.len

	return counter

}

//count_html_elements_from_url returns an int with amount of html elements in the URL
pub fn count_html_elements_from_url(url string) int{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tags()

	mut counter := tags.len

	return counter
}

//count_meta_from_url returns an int with amount of meta elements in the URL
pub fn count_meta_from_url(url string) int{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag('meta')

	mut counter := tags.len

	return counter
}

//get_jscontent_from_url returns a []string with all js content
pub fn get_jscontent_from_url(url string) []string{

	data := http.get_text(url)

	mut doc := html.parse(data)	

	tags := doc.get_tag('script')
	tags_in_head := doc.get_tag('head')

	mut counter := tags.len

	mut list := []&html.Tag
	mut string_list := []string
	
	for i := 0; i < tags.len; i++ {

		list = tags[i].children
	}

	for i := 0; i < tags_in_head.len; i++ {

		list = tags_in_head[i].children		
	}

	for i := 0; i < list.len; i++ {
		
		string_list << list[i].content
		
	}

	return string_list
}

//get_css_ref_from_url returns a []string with all css referenced in the URL
pub fn get_css_ref_from_url(url string) []string{

	data := http.get_text(url)

	mut doc := html.parse(data)	

	tags := doc.get_tag('style')
	tags_in_head := doc.get_tag('head')

	mut counter := tags.len

	mut list := []&html.Tag
	mut string_list := []string
	
	for i := 0; i < tags.len; i++ {

		list = tags[i].children
	}

	for i := 0; i < tags_in_head.len; i++ {

		list = tags_in_head[i].children
	}

	for i := 0; i < list.len; i++ {
		
		if list[i].attributes['rel'] == 'stylesheet'{

			string_list << list[i].attributes['href']
		}
		
	}


	return string_list

}

//get_css_ref_from_url returns a []string with all css referenced in the URL
pub fn count_js_events_from_url(url string) int{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag_by_attribute('onclick')

	mut counter := tags.len

	return counter
}

//get_css_content_from_url returns a []string with all css content in the URL
pub fn get_css_content_from_url(url string) []string{

	data := http.get_text(url)

	mut doc := html.parse(data)	

	tags := doc.get_tag('style')
	tags_in_head := doc.get_tag('head')

	mut counter := tags.len

	mut list := []&html.Tag
	mut string_list := []string
	
	for i := 0; i < tags.len; i++ {

		string_list << tags[i].content
	}

	for i := 0; i < tags_in_head.len; i++ {

		string_list << tags_in_head[i].content
	}

	
	return string_list
}

//count_forms_from_url returns an int with amount of forms in the URL
pub fn count_forms_from_url (url string) int{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag('form')

	mut counter := tags.len

	return counter
}

//get_form_info_from_url returns a map[string]string with all forms info in the URL
pub fn get_form_info_from_url(url string) map[string]string{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag('form')

	mut map_act_meth := map[string]string
	
	for i := 0; i < tags.len; i++ {

		mut action := tags[i].attributes['action']

		mut method := tags[i].attributes['method']

		map_act_meth[action] = method
	}

	return map_act_meth
}

//get_onclick_values_from_url returns a []string with all onclick values in the URL
pub fn get_onclick_values_from_url(url string) []string]{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag_by_attribute('onclick')

	mut string_list := []string

	for i := 0; i < tags.len; i++ {

		string_list << tags[i].attributes['onclick']

	}

	return string_list
}

//has_ajax_calls_in_url returns a bool that indicates if URL has ajax calls
pub fn has_ajax_calls_in_url(url string) bool{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag('script')

	mut has_ajax_call := false
	
	for i := 0; i < tags.len; i++ {

		if '$.ajax' in tags[i].content{

			has_ajax_call = true
		}

	}

	return has_ajax_call
}

//get_page_size_from_url returns f32 that indicates the size of page in URL
pub fn get_page_size_from_url(url string) f32{

	data := http.get_text(url)

	mut page_size := data.len / 1024


	return page_size

}

//generate_report returns a JSON with all information from functions in this module
pub fn generate_report(url string) string{

	mut report_json := Report{
		amount_css: count_css_from_url(url)
		amount_forms: count_forms_from_url(url)
		amount_forms_info: get_form_info_from_url(url)
		amount_html_elements: count_html_elements_from_url(url)
		amount_js: count_js_from_url(url)		
		amount_js_elements: count_js_events_from_url(url)
		amount_meta_elements: count_meta_from_url(url)
	}

	return json.encode(report_json)

}
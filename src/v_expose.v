module main

import net.http
import sync
import time

fn get_links_from_url(url string) map[int]string {

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

fn count_css_from_url(url string) int {

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

fn count_js_from_url(url string) int{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag('script')

	mut counter := tags.len

	return counter

}

fn count_html_elements_from_url(url string) int{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tags()

	mut counter := tags.len

	return counter
}

fn count_meta_from_url(url string) int{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag('meta')

	mut counter := tags.len

	return counter
}

fn get_jscontent_from_url(url string) []string{

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

fn get_css_ref_from_url(url string) []string{

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

fn count_js_events_from_url(url string) int{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag_by_attribute('onclick')

	mut counter := tags.len

	return counter
}

fn get_css_content_from_url(url string) []string{

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

fn count_forms_from_url (url string) int{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag('form')

	mut counter := tags.len

	return counter
}

fn get_form_info_from_url(url string) map[string]string{

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

fn get_onclick_values_from_url(url string) []string]{

	data := http.get_text(url)

	mut doc := html.parse(data)	
	
	tags := doc.get_tag_by_attribute('onclick')

	mut string_list := []string

	for i := 0; i < tags.len; i++ {

		string_list << tags[i].attributes['onclick']

	}

	return string_list
}

fn has_ajax_calls_in_url(url string) bool{

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
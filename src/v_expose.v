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

	mut lista := []&html.Tag
	
	for i := 0; i < tags.len; i++ {

		lista = tags[i].children		
	}

	for i := 0; i < lista.len; i++ {
		
		if lista[i].attributes['rel'] == 'stylesheet'{
			
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
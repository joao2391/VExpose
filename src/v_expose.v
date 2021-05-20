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

	mut counter := tags.len
	
	return counter
}
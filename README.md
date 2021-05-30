![Expose logo](Expose.png)

A V package that helps you to scrap web pages. It shows you a lot of information about the page.

# V Programming Language
If you don't know about V please [check this out](https://github.com/vlang)

## Installation

Use the package manager [VPM](https://vpm.vlang.io/) to install VExpose.

```bash
v install joao2391.vexpose
```

## Usage

After install the package:

```v
import joao2391.vexpose
```

Return total of links in the html page
```v
mut map_links := vexpose.get_links_from_url('url')
```

Return total of CSS files referenced in the html page
```v
mut count_css := vexpose.count_css_from_url('url')
```

Return total of JS files referenced in the html page
```v
mut count_js := vexpose.count_js_from_url('url')
```

Return total of Html Elements
```v
mut count_html_elements := vexpose.count_html_elements_from_url('url')
```

Return total of META elements
```v
mut count_meta_tags := vexpose.count_meta_from_url('url')
```

Return all the JS content
```v
mut js_content := vexpose.get_jscontent_from_url('url')
```

Return all the CSS content
```v
mut css_content :=  vexpose.get_css_content_from_url('url')
```

Return all the CSS references
```v
mut css_reference :=  vexpose.get_css_ref_from_url('url')
```

Return the total of onclick events in all elements in the html
```v
mut count_onclick_events := vexpose.count_js_events_from_url('url')
```

Return the total of Forms in html page
```v
mut count_forms := vexpose.count_forms_from_url('url')
```

Return the Action and HttpMethod from Form
```v
mut form_info := vexpose.get_form_info_from_url('url')
```

Return the size in Kb of the page
```v
mut page_size := vexpose.get_page_size_from_url('url')
```

Return the onclick values
```v
mut onclick_values := vexpose.get_onclick_values_from_url('url')
```

Return the JSON with the amount of info found
```v
mut report := vexpose.generate_report('url')
```

Return True/False 
```v
mut has_ajax_calls := vexpose.has_ajax_calls_in_url('url')
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)


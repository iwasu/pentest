# Cross-site scripting via HTML template escaping bypass
In Go, the `html/template` package has a few special types (`HTML`, `HTMLAttr`, `JS`, `JSStr`, `CSS`, `Srcset`, and `URL`) that allow values to be rendered as-is in the template, avoiding the escaping that all the other strings go through.

Using them on user-provided values allows for a cross-site scripting vulnerability.


## Recommendation
Make sure to never use those types on untrusted content.


## Example
In the first example you can see the special types and how they are used in a template:


```go
package main

import (
	"html/template"
	"net/http"
)

func bad(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	username := r.Form.Get("username")
	tmpl, _ := template.New("test").Parse(`<b>Hi {{.}}</b>`)
	tmpl.Execute(w, template.HTML(username))
}

```
To avoid XSS, all user input should be a normal string type.


```go
package main

import (
	"html/template"
	"net/http"
)

func good(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	username := r.Form.Get("username")
	tmpl, _ := template.New("test").Parse(`<b>Hi {{.}}</b>`)
	tmpl.Execute(w, username)
}

```

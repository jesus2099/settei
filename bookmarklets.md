Bookmarklets
============

Tab ⇥
-----

```js
javascript:void(document.activeElement.setRangeText("\t",document.activeElement.selectionStart,document.activeElement.selectionEnd,"end"))
```

“Guillemets” (quotes)
------------

```js
javascript:void(s=document.activeElement.selectionStart);void(e=document.activeElement.selectionEnd);void(document.activeElement.setRangeText("“",s,s));void(document.activeElement.setRangeText("”",e+1,e+1,"end"))
```

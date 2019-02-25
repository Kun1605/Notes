#### 限制inut框数字

```html
<input type="number" id="bank_code" maxlength="255" onkeyup="this.value=this.value.replace(/[^\d]/g,'') " onafterpaste="this.value=this.value.replace(/[^\d]/g,'') ">
```


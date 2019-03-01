> #### 限制inut框数字
>

```html
<input type="number" id="bank_code" maxlength="255" onkeyup="this.value=this.value.replace(/[^\d]/g,'') " onafterpaste="this.value=this.value.replace(/[^\d]/g,'') ">
```

> #### 根据名字多个查询下拉框的东西

```javascript
 $("#producttype").find("option:contains('友客')").attr("selected",true)
```

#### 
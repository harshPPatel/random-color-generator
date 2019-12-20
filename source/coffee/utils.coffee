export default {
  copyText: (text) ->
    el = document.createElement 'textarea'
    document.body.appendChild el
    el.value = text
    el.setAttribute('readonly', '')
    el.style = {
      position: 'absolute',
      left: '-9999px'
    }
    el.select()
    document.execCommand 'copy'
    document.body.removeChild el
}
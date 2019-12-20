import tinycolor from 'tinycolor2'
import rgbToCmyk from 'rgb-cmyk'
import utils from './utils.coffee'

# Getting All Target HTML Elements
hexElement = document.getElementById 'hex-value'
rgbElement = document.getElementById 'rgb-value'
hslElement = document.getElementById 'hsl-value'
cmykElement = document.getElementById 'cmyk-value'
textColorElement = document.getElementById 'text-color'
imageElement = document.getElementById 'color-container'
copyElement = document.getElementById 'copy-popup'

# Color set to generate random color with HEX value
colorsSet = 'ABCDEF0123456789'

# Generates the random Color and returns it
generateColor = () ->
  count = 0
  color = '#'
  while count < 6
    color += colorsSet.charAt(Math.random() * colorsSet.length)
    count++
  color

# Converts and sets colors values to target elements
setColor = (clr) ->
  color = tinycolor(clr)
  # Generating CMYK value
  cmykValue = rgbToCmyk(rgbElement.innerHTML.split(', '))
  cmykValue = cmykValue.map((x) -> (x * 100).toFixed(2))
  # Setting values to HTML Elements
  hexElement.innerHTML = clr
  rgbElement.innerHTML = color.toRgbString().replace(/[rgb\(\)]/g, '')
  hslElement.innerHTML = color.toHslString().replace(/[hsl\(\)]/g, '')
  cmykElement.innerHTML = cmykValue.join(', ')
  textColorElement.innerHTML = if color.isDark() then 'Light' else 'Dark'
  # Updating css variable
  document.body.style.setProperty('--color', clr)

document.body.onkeyup = (e) ->
  setColor(generateColor()) if (e.keyCode == 32)

imageElement.onclick = (e) ->
  e.preventDefault()
  setColor(generateColor())

hexElement.onclick = (e) ->
  utils.copyText(e.target.textContent)
  copyElement.classList.remove 'animated'
  copyElement.classList.add 'animated'
  timeout = setTimeout ->
    copyElement.classList.remove 'animated'
  , 6000

window.onload = setColor(generateColor())
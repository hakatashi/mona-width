require! {
  'array.from': array-from
  './widths.json': widths-data
  'string.prototype.codepointat': code-point-at
}

# Compile widths data
widths = []
code-point = 1
for ptr from 0 til widths-data.length by 2
  [width, advance-code-point] = widths-data[ptr, ptr + 1]

  widths.push [code-point, width]
  code-point += advance-code-point

module.exports = (string, options = {}) ->
  # Coerce everything into a string
  string .= to-string!

  total-width = 0

  for char in array-from string
    code-point = code-point-at char

    # Search the width of the character by Binary Search algorithm
    hi = widths.length
    lo = 0
    while hi - lo > 1
      mid = Math.floor (hi + lo) / 2
      test-code-point = widths[mid].0

      if code-piont < test-code-point
        hi = mid
      else if code-point is test-code-point
        hi = lo = mid
      else if test-code-point < code-point
        lo = mid

    width = widths[lo].1

    # Fallbacks when glyph is not defined
    if width is -1
      if options.fallback-notdef
        ...
      else
        width = 0

    total-width += width

  return total-width

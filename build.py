from fontTools.ttLib import TTFont
from fontTools.ttLib.tables._c_m_a_p import cmap_format_4
import json

font = TTFont('ipagp-mona.ttf')

metrics = font['hmtx'].metrics
cmap = font['cmap']

widths = {}

for table in cmap.tables:
    if table.isUnicode():
        for code_point, glyph_name in table.cmap.items():
            width, lsb = metrics[glyph_name]
            widths[code_point] = width

width_array = []
current_width = None
current_width_repetation = 0

for code_point in range(1, 0x10000):
    if code_point in widths:
        width = widths[code_point]
    else:
        width = -1

    if current_width == width:
        current_width_repetation += 1
    else:
        if current_width is not None:
            width_array.append(current_width)
            width_array.append(current_width_repetation)

        current_width = width
        current_width_repetation = 1

widths_file = open('widths.json', 'w')
widths_file.write(json.dumps(width_array, separators=(',', ':')))

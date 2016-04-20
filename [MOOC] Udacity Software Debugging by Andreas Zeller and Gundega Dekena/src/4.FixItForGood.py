#
# Modify `remove_html_markup` so that it actually works!
#

def remove_html_markup(s):
    tag   = False
    quote = False
    quoteSign = '"'
    out   = ""

    for c in s:
        # print c, tag, quote
        if c == '<' and not quote:
            tag = True
        elif c == '>' and not quote:
            tag = False
        elif (c == '"' or c == "'") and tag:
            if quote == False or (quoteSign == c):
                quote = not quote
                quoteSign = c
        elif not tag:
            out = out + c

    return out


def test():
    assert remove_html_markup('<a href="don' + "'" + 't!">Link</a>') == "Link"
test()

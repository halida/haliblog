#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: rst
"""
import sys
from docutils.core import publish_parts, publish_string

# ----------------------------------------------------------------
# define codeblock
from docutils import nodes
from docutils.parsers.rst import directives
from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import HtmlFormatter

pygments_formatter = HtmlFormatter()

def pygments_directive(name, arguments, options, content, lineno,
                       content_offset, block_text, state, state_machine):
    try:
        lexer = get_lexer_by_name(arguments[0])
    except ValueError:
        # no lexer found - use the text one instead of an exception
        lexer = get_lexer_by_name('text')
    parsed = highlight(u'\n'.join(content), lexer, pygments_formatter)
    return [nodes.raw('', parsed, format='html')]
pygments_directive.arguments = (1, 0, 1)
pygments_directive.content = 1
directives.register_directive('code-block', pygments_directive)
# ----------------------------------------------------------------

def rst2html(value):
    content = publish_string(
        source = value,
        writer_name='html'
        )
    return content

def rst2htmlbody(value):
    content = publish_parts(
        source = value,
        writer_name='html'
        )['html_body'].encode('utf-8')
    return content

def main():
    print rst2htmlbody(open(sys.argv[1]).read())
    
if __name__=="__main__":
    main()

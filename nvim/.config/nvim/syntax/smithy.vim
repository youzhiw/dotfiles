if exists('b:current_syntax') | finish|  endif
syntax sync fromstart
syntax case match
command -nargs=+ Highlight hi def link <args>
syn keyword smithyKeywords namespace service resource structure operation integration list string integer
syn match smithyVersion /^\$version\: /
syn match smithyComment "\/\/.*$"
syn match smithyAnnotation /^\s*@/ nextgroup=smithyAnnotationName
syn match smithyAnnotationName contained /\h[a-zA-Z0-9_.]*/ nextgroup=smithyParenAnnotation
syn match smithyArrow /->/
syntax region  smithyParenAnnotation contained matchgroup=smithyParensAnnotation  start=/(/  end=/)/  contains=@smithyAll extend fold
syn cluster smithyAll contains=smithyComment,smithyAnnotation
Highlight smithyKeywords Keyword
Highlight smithyVersion Keyword
Highlight smithyComment Comment
Highlight smithyAnnotation Special
Highlight smithyArrow Special
Highlight smithyParensAnnotation Noise
Highlight smithyAnnotationName Function
let b:current_syntax = 'smithy'

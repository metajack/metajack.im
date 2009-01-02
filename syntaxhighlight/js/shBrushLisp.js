dp.sh.Brushes.Lisp = function ()
{
  var special =  'nil t';

  this.regexList = [
    {regex: new RegExp(";.*$", 'gm'),
     css: 'comment'},
    {regex: new RegExp('"(?!")(?:\\.|\\\\\\"|[^\\""\\n\\r])*"', 'gm'),
     css: 'string'},
    {regex: new RegExp("\\b\\d+\\.?\\w*", 'g'),
     css: 'number'},
    {regex: new RegExp("\\(|\\)", 'gm'),
     css:'parens'},
    {regex: new RegExp(this.GetKeywords(special), 'gm'),
     css:'special'}];
  this.CssClass = 'dp-lisp';
  this.Style = '.dp-lisp .parens { color: #ff1493; }' +
    '.dp-lisp .number { color: blue; }' +
    '.dp-lisp .string { color: brown; font-style: italic; }';
};

dp.sh.Brushes.Lisp.prototype = new dp.sh.Highlighter();
dp.sh.Brushes.Lisp.Aliases = ['lisp'];

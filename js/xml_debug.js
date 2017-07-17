function prettyPrintStr(xmlStr) {
  var formatted = '';
  var reg = /(>)(<)(\/*)/g;
  xml = xml.replace(reg, '$1\r\n$2$3');
  var pad = 0;
  xml.split('\r\n').forEach(function(node, index) {
    var indent = 0;
    if (node.match(/.+<\/\w[^>]*>$/)) {
      indent = 0;
    } else if (node.match(/^<\/\w/)) {
      if (pad != 0) {
        pad -= 1;
      }
    } else if (node.match(/^<\w([^>]*[^\/])?>.*$/)) {
      indent = 1;
    } else {
      indent = 0;
    }

    var padding = '';
    for (var i = 0; i < pad; i++) {
      padding += '  ';
    }

    formatted += padding + node + '\r\n';
    pad += indent;
  });
  return formatted;
}

var parser = new DOMParser();
var deparser = new XMLSerializer();
function parse(xmlString) {
  var xml = parser.parseFromString(xmlString);
  xml.log = function() {
    console.log(this)
  };
  xml.prettyPrint = function() {
    console.log(prettyPrintObj(this))
  };
  return xml;
}

function prettyPrintObj(xmlObj) {
  return parse(deparser.serializeToString(xmlObj));
}

#!/usr/bin/perl

# ~/.w3m/urimethodmap
# h: file:/cgi-bin/helyesiras_MTA.cgi?%s

$url = "http://www.helyesiras.mta.hu/helyesiras/default/suggest?q=";
$_ = $ENV{"QUERY_STRING"};
s@^h?:@@ && s@^//@@ && s@/$@@;
if ($_) {
	s/\+/ /g;
	s/%([\da-f][\da-f])/pack('C', hex($1))/egi;
	s/[\000-\040\+:#?&%<>"\177-\377]/sprintf('%%%02X', unpack('C', $&))/eg;
	$url .= "$_";
} else {
	$input = "w3m-control: GOTO_LINK";
}
print <<EOF;
w3m-control: GOTO $url
w3m-control: DELETE_PREVBUF
w3m-control: SEARCH \\[
w3m-control: MOVE_RIGHT
${input}

EOF

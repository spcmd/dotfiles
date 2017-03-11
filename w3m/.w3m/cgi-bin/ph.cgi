#!/usr/bin/perl

# ~/.w3m/urimethodmap
# ph: file:/cgi-bin/ph.cgi?%s

$url = "https://logout.hu/temak/keres.php";
$_ = $ENV{"QUERY_STRING"};
s@^ph?:@@ && s@^//@@ && s@/$@@;
if ($_) {
	s/\+/ /g;
	s/%([\da-f][\da-f])/pack('C', hex($1))/egi;
	s/[\000-\040\+:#?&%<>"\177-\377]/sprintf('%%%02X', unpack('C', $&))/eg;
	$url .= "?stext=$_";
} else {
	$input = "w3m-control: GOTO_LINK";
}
print <<EOF;
w3m-control: GOTO $url
w3m-control: DELETE_PREVBUF
w3m-control: SEARCH Fórumtémák
w3m-control: SEARCH_NEXT
w3m-control: MOVE_RIGHT
${input}

EOF

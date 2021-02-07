#!/usr/local/bin/perl
#		Module Title: Pythonline Stage Tour Questionnaire
#		Module Name: stagetour.pl
#		Module Lang: PERL 5.0lm Script
#		Date: April 16 1998
# 		Associated: spamclub/content/pythonpoll/pythonpoll.htm
#
#		Compiled by: MC
#
#		From original code by: William H. Schroder
#
#

# Library Calls
require 'ctime.pl';
# Get input data
&parse_query;

&recipient = 'mcabrera@la.7thlevel.com';

# if($MYDATA{'ok_to_send'} ne "")
# {
	open(MAILTO,"|/usr/lib/sendmail -f $MYDATA{'recipient'}");
	open(MAILTO,"|/usr/lib/sendmail -f $recipient");

	print MAILTO "Subject: Python Stage Tour Questionnaire, \n";
	print MAILTO "\n-------- ",&ctime(time); 		#time stamp

	print MAILTO "Python Stage Tour - Fall 1999 Questionnaire\n\n";

# Mail Option

	print MAILTO "In any Python show I would want to see: \n";

		print MAILTO "$MYDATA{'stageshow'}\n";
		print MAILTO " $MYDATA{'new'}\n";
		print MAILTO " $MYDATA{'new&old'}\n\n";

	print MAILTO "Favorite sketches: \n";

		print MAILTO "$MYDATA{'parrot'}\n";
		print MAILTO "$MYDATA{'nudge'}\n";
		print MAILTO "$MYDATA{'blackmail'}\n";
		print MAILTO "$MYDATA{'inquisition'}\n";
		print MAILTO "$MYDATA{'bruces'}\n\n";

	print MAILTO "Other sketches: \n";

		print MAILTO "$MYDATA('other_sketches')\n\n";

	print MAILTO "Theater size: \n";

		print MAILTO "$MYDATA('1000+')\n\n";

	print MAILTO "Major City: \n";

		print MAILTO "Nearest major city: $MYDATA('city')\n";

	print MAILTO "Merchandise: \n";

		print MAILTO "$MYDATA('shirts')\n";

	print MAILTO "Age: \n";

		print MAILTO "$MYDATA('12-18')\n";

	print MAILTO "Who else would come? $MYDATA('who.else.coming')\n";

	print MAILTO "Would you go to a Python show? $MYDATA('would.go.to.show')\n";

	print MAILTO "Club member? $MYDATA('club.member'})\n";

close(MAILTO);
&write_header;

$TITLE = "Successful submission";

print "<H2>Thank you for your waste of time.</H2>";
print "<P><IMG SRC=\"/spamclub/content/tobedecided/image.gif\" WIDTH=100 HEIGHT=100 BORDER=0>\n";

&write_tail;
exit;
# }


#####################################
sub write_header
{
print "Content-type: text/html\n\n";
print "<HTML><HEAD><TITLE>$TITLE</TITLE></HEAD>\n";
print "<BODY BGCOLOR=\"#FFFFFF\" \n";
}

sub write_tail
{
print "</BODY></HTML>\n\n";
}

sub parse_query
{
if($ENV{'REQUEST_METHOD'} eq "GET")			# Using GET...
{
	$FORM_DATA=$ENV{'QUERY_STRING'};		# Save data to FORM_DATA
}
else {								# Using POST
	$LENGTH=$ENV{'CONTENT_LENGTH'};		# How much data to read?
	If($LENGTH>"32768")
	{
		die "File overload - Extremely big file";
	}

	while($LENGTH--)
	{
		$C=getc(STDIN);				# Get next character
		if($C eq "="||$C eq "&")				# Check for start / end of value
		{
			$START = "0";
		}
		else {
			$START++;
		        }
		if($START <= "8192")				# 8k should be enough for e-mail
		{
			$FORM_DATA .= $C;			# Save data to FORM_DATA
		}
	}
       }
$FORM_DATA=$ENV{'QUERY_STRING'};
}

# Parse data into NAME = VALUE pairs...

foreach(split(/&/, $FORM_DATA))
{
	($NAME, $VALUE) = split(/=/, $_);
	$NAME = ~s/\+/ /g;
	$NAME = ~s/%([0-9|A-F] {2})/pack(C, hex($1))/eg;
	$VALUE = ~s/\+/ /g;
	$VALUE = ~s/%([0-9|A-F] {2})/pack(C, hex($1)/eg;

	#find unique name
	$NUM = "0";
	while($MYDATA{$NAME} ne "")
	{
		$NUM++;
		$NAME = ~s/\.([0-9] + $) | $/\.$NUM/;
	} 

	# Store NAME = VALUE pair
	$MYDATA{$NAME} = $VALUE;
}



#!/bin/bash
set -x
if [ $# != 4 ]
 
then
	echo " usage check_current_status.sh username password pageid accountid "
	exit 3
else
	username=$1
	password=$2
	pageid=$3
	accountid=$4
fi

key=`curl -s https://api.siteconfidence.co.uk/beta0.3/username/$username/password/$password | sed 's/.*ApiKey Lifetime="[0-9]*">\(.*\)<\/ApiKey.*/\1/'`

#resultcode=`curl -s https://api.siteconfidence.co.uk//beta0.3/$cookie/AccountId/$accountid/Id/$pageid/ | awk ' { print $25 } ' |  sed s/\"/:/g | awk 'BEGIN { FS = ":" } ; { print $2 }'`

resultcode=`curl -s https://api.siteconfidence.co.uk//beta0.3/$key/AccountId/$accountid/Id/$pageid/Return/%5BAccount%5BPages%5BPage%5BResultCode%5D%5D%5D%5D/ | sed 's/.*ResultCode="\([0-9]*\)".*/\1/'`



# exit 3 = unknown
# exit 2 = crit
# exit 1 = warn
# exit 0 = ok

case $resultcode in

	'1' )
		echo "Your website is OK."
		exit 0
		;;
	'2' )
		echo "We were unable to connect to your web server to download an image or other information."
		exit 1
		;;
	'3' )
		echo "There were were one or more missing on your web page (e.g. graphics, images or other content)."
		exit 1
		;;
	'11' )
		echo "We could not complete the download of your web page and all its objects within the target time set by the Download Threshold."
		exit 1
		;;
	'12' )
		echo "We were denied access to one or more objects (e.g. images) that make up your web page."
		exit 1
		;;
	'13' )
		echo "A server error occurred with one or more objects (e.g. images) on your web page."
		exit 1
		;;
	'14' )
		echo "One or more objects (e.g. images) returned invalid or incomplete headers."
		exit 1
		;;
	'5' )
		echo "We were unable to download your web page within the target time set by the Download Threshold."
		exit 2
		;;
	'9' )
		echo "A word contained in our library of obscene words has been found on your web page."
		exit 2
		;;
	'10' )
		echo "We were unable to connect to your web server."
		exit 2
		;;
	'4' )
		echo "We were denied access to your web page. If the page is password protected, the login information you provided to us failed."
		exit 2
		;;
	'6' )
		echo "We received an error from your web server and were not able to download your web page."
		exit 2
		;;
	'7' )
		echo "We could not download your web page."
		exit 2
		;;
	'8' )
		echo "The headers from the web server were incomplete or invalid."
		exit 2
		;;
	'15' )
		echo "We were unable to download your web page as the web server returned a 4xx HTTP status code."
		exit 2
		;;
	'16' )
		echo "We could not access the page requested as our attempt to resolve the IP address of the web server from the supplied domain returned an error."
		exit 2
		;;
	'18' )
		echo "The web server prematurely stopped sending data."
		exit 2
		;;
	'19' )
		echo "The web server prematurely stopped sending data for an object in the page."
		exit 1
		;;
	'0' )
		echo "Test in progress."
		exit 0
		;;
	'17' )
		echo "We could not resolve the IP address for the domain used for one or more objects on your web page."
		exit 1
		;;
	'20' )
		echo "We found information on the web page that indicates an application error occurred on your website."
		exit 2
		;;
	'21' )
		echo "We found a error that you have asked us to report using the Site Confidence Error tag. The information contained within the tags is listed below."
		exit 2
		;;
	'22' )
		echo "No HTML was downloaded, so there is no web page to display."
		exit 2
		;;
	'23' )
		echo "The phrase you specified was not present on the page we downloaded."
		exit 2
		;;
	'24' )
		echo "The requested page was downloaded successfully, but the size of the complete page in bytes, including any images, is less than the limit specified."
		exit 2
		;;
	'25' )
		echo "The requested page was downloaded successfully, but the size of the complete page in bytes, including any images, is greater than the limit specified."
		exit 2
		;;
	'101' )
		echo "There was a monitoring issue at this time. No readings recorded will contribute to your reports or analysis."
		exit 3
		;;
	'100' )
		echo "This is not an error with your website. A telecommunications failure occurred at one of our testing locations."
		exit 3
		;;
	'30' )
		echo "We have found a specific problem with your script that you have asked us to identify."
		exit 2
		;;
	'31' )
		echo "The phrase you specified was present on the page we downloaded."
		exit 2
		;;
	'32' )
		echo "Your server is currently displaying a maintenance page."
		exit 2
		;;
	'54' )
		echo "A general fatal error occured."
		exit 2
		;;
	'55' )
		echo "A general fatal error occured."
		exit 2
		;;
	'33' )
		echo "Your web server has returned your default Error Page."
		exit 2
		;;
	'34' )
		echo "Your server has issued a search result time-out page."
		exit 2
		;;
	'102' )
		echo "Requested error status change."
		exit 3
		;;
	'26' )
		echo "We have encountered a sequence of redirects that have resulted in us not being able to download a page successfully."
		exit 2
		;;
	'103' )
		echo "The script which executes the test has failed."
		exit 3
		;;
	'61' )
		echo "We have encountered your server busy page."
		exit 2
		;;
	'35' )
		echo "We have received a login failure page from the server."
		exit 2
		;;
	'27' )
		echo "We have encountered a sequence of redirects that have resulted in us not being able to download a component successfully."
		exit 1
		;;
	'28' )
		echo "We were unable to connect to a web server contributing content to this page."
		exit 1
		;;
	'29' )
		echo "No content was downloaded for a object before the download threshold was reached, so there is nothing to display for this object."
		exit 1
		;;
	'72' )
		echo "The Database server has Failed."
		exit 2
		;;
	'73' )
		echo "Instead of retrieving the bill as expected we were directed to the pay bill page instead."
		exit 2
		;;
	'74' )
		echo "Site is returning a Session time out error page"
		exit 2
		;;
	'36' )
		echo "An ODBC error page has been returned to the user."
		exit 2
		;;
	'80' )
		echo "We were not able to display the image in mpg format."
		exit 2
		;;
	'82' )
		echo "Sorry, an error has occured while trying to process your request."
		exit 2
		;;
	'83' )
		echo "The test order for this transaction has been confirmed and is being processed."
		exit 2
		;;
	'85' )
		echo "A page with following text has been returned. 'There has been an error processing your request'"
		exit 2
		;;
	'86' )
		echo "We received your no availability page."
		exit 2
		;;
	'88' )
		echo "No results were returned by our search."
		exit 2
		;;
	'90' )
		echo "We received your Capping Page."
		exit 2
		;;
	'91' )
		echo "We received you planned Holding Page."
		exit 1
		;;
	'92' )
		echo "We received your Unplanned Holding Page."
		exit 2
		;;
	'93' )
		echo "We received your no availability page on this test and the query string Error=Internal was found."
		exit 2
		;;
	'41' )
		echo "We could not access the page requested as our attempt to resolve the IP address of the web server from the supplied domain timed out."
		exit 2
		;;
	'42' )
		echo "We could not download the object requested as our attempt to resolve the IP address of the web server hosting this component timed out."
		exit 1
		;;
	'94' )
		echo "Your Site Busy Page was found."
		exit 2
		;;
	'96' )
		echo "The website is currently unavailable and the holding page is up."
		exit 2
		;;
	'97' )
		echo "The Address could not be found for the post code entered."
		exit 2
		;;
	'43' )
		echo "Your web server refused to accept a connection."
		exit 2
		;;
	'44' )
		echo "Your web server refused to accept a connection for an object in your web page."
		exit 1
		;;
	'37' )
		echo "Your server has issued a time-out page."
		exit 1
		;;
	'307' )
		echo "We could not access the server requested as our attempt to resolve the IP address of the server from the supplied domain timed out."
		exit 2
		;;
	'308' )
		echo "We could not access the requested server as our attempt to resolve the IP address from the supplied domain returned an error."
		exit 2
		;;
	'309' )
		echo "We were unable to find the phrase specified for this step."
		exit 2
		;;
	'124' )
		echo "When we attempted to download your page we received your holding page instead."
		exit 1
		;;
	'125' )
		echo "The booking system is not available at this time."
		exit 2
		;;
	'126' )
		echo "The session is no longer available for the user."
		exit 2
		;;
	'127' )
		echo "Instead of getting a page where we enter letters from our secret phrase we are seeing a page where we need to resupply a secret."
		exit 2
		;;
	'128' )
		echo "We have found illegal form method in the HTML."
		exit 2
		;;
	'129' )
		echo "We have found the text 'Error' in the response."
		exit 2
		;;
	'131' )
		echo "We were unable to download your web page as the web server returned your 404 page."
		exit 2
		;;
	'132' )
		echo "We received your custom error 500 page from your web server and were not able to download your web page."
		exit 2
		;;
	'133' )
		echo "When we attempted to download your home page we were presented with your Session Expiry page instead."
		exit 2
		;;
	'47' )
		echo "When requesting the main source of the web page, a connection was made to the web server but a HTTP request could not be written."
		exit 2
		;;
	'48' )
		echo "When requesting an object for your web page, a connection was made to the web server but a HTTP request could not be written."
		exit 1
		;;
	'45' )
		echo "A connection was made but a time out occured while waiting for the data."
		exit 2
		;;
	'46' )
		echo "A connection was made but a time out occured while waiting for the data for an object."
		exit 1
		;;
	'147' )
		echo "Step Gives Unexpected Error"
		exit 2
		;;
	'150' )
		echo "The test queried the cached result rather than searching for the result"
		exit 1
		;;
	'151' )
		echo "We are experiencing difficulties page found."
		exit 2
		;;
	'250' )
		echo "A syntax error was detected in your XML."
		exit 2
		;;
	'251' )
		echo "Validation against a specified schema or DTD failed, or schema or DTD does not exist."
		exit 2
		;;
	'252' )
		echo "We could not validate your XML due to an internal error."
		exit 2
		;;
	'152' )
		echo "User password has exired and a new one need to be set"
		exit 2
		;;
	'153' )
		echo "Transaction altered flow and step and landed on the payment stage rather than the usual step"
		exit 1
		;;
	'260' )
		echo "There has been a general certificate error."
		exit 1
		;;
	'261' )
		echo "There has been a general certificate error for an object in your web page."
		exit 1
		;;
	'262' )
		echo "There has been a timing error for your certificate."
		exit 1
		;;
	'263' )
		echo "There has been a timing error for your certificate for an object."
		exit 1
		;;
	'264' )
		echo "There has been an error while trying to verify your certificate."
		exit 1
		;;
	'265' )
		echo "There has been an error while trying to verify your certificate for an object in you web page."
		exit 1
		;;
	'266' )
		echo "There has been an unknown error while trying to validate the SSL session."
		exit 1
		;;
	'267' )
		echo "There has been an unknown error while trying to validate the SSL session for an object in your web page."
		exit 1
		;;
	'160' )
		echo "Site is currently under Maintenance."
		exit 2
		;;
	'270' )
		echo "There has been an error while trying to download an NTLM-secured component."
		exit 2
		;;
	'271' )
		echo "The phrase you specified was present on the page we downloaded."
		exit 2
		;;
	'161' )
		echo "Sometimes depending on the search criteria used in the script we come across no availability. It means our script tries to select the wrong line value."
		exit 2
		;;
	'162' )
		echo "Not a real fault."
		exit 2
		;;
	'49' )
		echo "The number of missing objects on the page has reached the set limit."
		exit 2
		;;
	'177' )
		echo "There was a problem checking your account details"
		exit 2
		;;
	'178' )
		echo "This page has timed out was found on page"
		exit 2
		;;
	'183' )
		echo "Cookie login session has expired."
		exit 2
		;;
	* )
		echo "An unknown error has occured."
		exit 3
		;;	
esac
echo $resultscode


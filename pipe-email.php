#!/usr/bin/php -q
<?php
$email_msg = ''; // the content of the email that is being piped

// open a handle to the email
$fh = fopen("php://stdin", "r");

// read through the email until the end
while (!feof($fh)){
        $email_msg .= fread($fh, 1024);
}
fclose($fh);

// send it to vkuzmov's script


//where are we posting to?
$url = 'http://example.com';

//what post fields?
$fields = array(
   'email_body'=>$email_msg,
);

//build the urlencoded data
$postvars='';
$sep='';
foreach($fields as $key=>$value)
{
   $postvars.= $sep.urlencode($key).'='.urlencode($value);
   $sep='&';
}


//open connection
$ch = curl_init();

//set the url, number of POST vars, POST data
curl_setopt($ch,CURLOPT_URL,$url);
curl_setopt($ch,CURLOPT_POST,count($fields));
curl_setopt($ch,CURLOPT_POSTFIELDS,$postvars);

//execute post
$result = curl_exec($ch);

//close connection
curl_close($ch);
?>

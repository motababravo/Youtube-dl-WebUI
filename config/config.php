<?php

//Default password is "root" with md5 hash 1
//No "/" at the end of outputFolder or logfolder

return array(
	"bin" => "/usr/local/bin/youtube-dl",
	"security" => true,
	"password" => "96672a4795eeba76c4b98ddab5f3092f",
	"outputFolder" => "downloads",
	"extracter" => "ffmpeg",
	"log" => true,
	"outfilename" => "%(title)s-%(id)s.%(ext)s",
	"logFolder" => "logs",
	"max_dl" => 3,
	"session_lifetime" => 86400);

?>

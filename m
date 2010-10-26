From: Karsten de Freese <karsten@maxi-dsl.de>
Date: Tue, 26 Oct 2010 20:09:39 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <4CC73583.7070805@maxi-dsl.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5169035969195038122=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============5169035969195038122==
Content-Type: multipart/alternative;
 boundary="------------030007010803050106010802"

This is a multi-part message in MIME format.
--------------030007010803050106010802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi Jean,


Am 26.10.2010 21:06, schrieb Jean Delvare:
> I think you forgot to check the FAQ and in particular:
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Isetnewlimitsanditdidntwork
>
>    
indeed - I remember having read that before, but just forgot ..

now setting the limits does work for jc42 _min and _max values, however 
not for _max_hyst (although the setting seems to exist)

The latest config file:

/bus "i2c-0" "SMBus PIIX4 adapter at 0b00"

chip "jc42-i2c-0-18"
         label temp1 "DRAM_0"
         set temp1_max 60
         set temp1_crit 70
         set temp1_max_hyst 65

chip "jc42-i2c-0-19"
         label temp1 "DRAM_1"
         set temp1_max 60
         set temp1_crit 70
         set temp1_max_hyst 65
/
and the latest output
/karsten:~/temp$ sudo sensors -s
Error: File /etc/sensors.d/jc42.conf, line 7: Failed to set value
jc42-i2c-0-18: At least one "set" statement failed
Error: File /etc/sensors.d/jc42.conf, line 14: Failed to set value
jc42-i2c-0-19: At least one "set" statement failed/

(actually I get the same error message for the K10temp _min & _max 
settings, but maybe these are hardwired?)
> Honestly, you are a very pleasant user to deal with.
>    
Thanks.. I try my best not to look too stupid, as I'm really a Linux 
beginner..

best regards -

Karsten


--------------030007010803050106010802
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
hi Jean,<br>
<br>
<br>
Am 26.10.2010 21:06, schrieb Jean Delvare:<br>
<blockquote cite="mid:20101026210623.61cbb211@endymion.delvare"
 type="cite">
  <pre wrap="">I think you forgot to check the FAQ and in particular:
<a class="moz-txt-link-freetext" href="http://www.lm-sensors.org/wiki/FAQ/Chapter3#Isetnewlimitsanditdidntwork">http://www.lm-sensors.org/wiki/FAQ/Chapter3#Isetnewlimitsanditdidntwork</a>

  </pre>
</blockquote>
indeed - I remember having read that before, but just forgot ..<br>
<br>
now setting the limits does work for jc42 _min and _max values, however
not for _max_hyst (although the setting seems to exist)<br>
<br>
The latest config file:<br>
<br>
<i>bus "i2c-0" "SMBus PIIX4 adapter at 0b00"<br>
<br>
chip "jc42-i2c-0-18"<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label temp1 "DRAM_0"<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_max 60<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_crit 70<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_max_hyst 65<br>
<br>
chip "jc42-i2c-0-19"<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label temp1 "DRAM_1"<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_max 60<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_crit 70<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_max_hyst 65<br>
</i><br>
and the latest output<br>
<i>karsten:~/temp$ sudo sensors -s<br>
Error: File /etc/sensors.d/jc42.conf, line 7: Failed to set value<br>
jc42-i2c-0-18: At least one "set" statement failed<br>
Error: File /etc/sensors.d/jc42.conf, line 14: Failed to set value<br>
jc42-i2c-0-19: At least one "set" statement failed</i><br>
<br>
(actually I get the same error message for the K10temp _min &amp; _max
settings, but maybe these are hardwired?)<br>
<blockquote cite="mid:20101026210623.61cbb211@endymion.delvare"
 type="cite">
  <pre wrap="">Honestly, you are a very pleasant user to deal with.
  </pre>
</blockquote>
Thanks.. I try my best not to look too stupid, as I'm really a Linux
beginner..<br>
<br>
best regards -<br>
<br>
Karsten<br>
<br>
</body>
</html>

--------------030007010803050106010802--


--===============5169035969195038122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5169035969195038122==--

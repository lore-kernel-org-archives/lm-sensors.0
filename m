From: Lisa Salvadorini <projects@anteasrl.it>
Date: Wed, 20 Jan 2010 10:31:07 +0000
Subject: [lm-sensors] proliant dl120
Message-Id: <4B56DB6B.4070109@anteasrl.it>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0102674659092578164=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============0102674659092578164==
Content-Type: multipart/alternative;
 boundary="------------090903090705090606030902"

This is a multi-part message in MIME format.
--------------090903090705090606030902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a proliant dl120 server, with centos 5.4 and I want to monitoring 
the temperature and fault of the server but the software of hp seems 
don't work.
I have trid to install lm-sensor but the result is:


[root@serverhost bus]# yum install lm_sensors
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
* addons: centos.intergenia.de
* base: centos.xengage.it
* extras: centos.xengage.it
* updates: centos.intergenia.de
Setting up Install Process
Package lm_sensors-2.10.7-4.el5.x86_64 already installed and latest version
Package lm_sensors-2.10.7-4.el5.i386 already installed and latest version
Nothing to do
[root@serverhost bus]# sensors-detect
# sensors-detect revision 5291 (2008-06-23 23:40:46 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH9

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 1c00 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x51
Probing for `Analog Devices ADM1033'... No
Probing for `Analog Devices ADM1034'... No
Probing for `SPD EEPROM'... Yes
(confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'... No
Client found at address 0x53
Probing for `Analog Devices ADM1033'... No
Probing for `Analog Devices ADM1034'... No
Probing for `SPD EEPROM'... Yes
(confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'... No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290... No
Probing for `National Semiconductor LM78-J' at 0x290... No
Probing for `National Semiconductor LM79' at 0x290... No
Probing for `Winbond W83781D' at 0x290... No
Probing for `Winbond W83782D' at 0x290... No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'... No
Trying family `SMSC'... No
Trying family `VIA/Winbond/Fintek'... No
Trying family `ITE'... No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'... No
Trying family `SMSC'... No
Trying family `VIA/Winbond/Fintek'... No
Trying family `ITE'... No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595... No
VIA VT82C686 Integrated Sensors... No
VIA VT8231 Integrated Sensors... No
AMD K8 thermal sensors... No
AMD K10 thermal sensors... No
Intel AMB FB-DIMM thermal sensor... No

Sorry, no sensors were detected.
Either your sensors are not supported, or they are connected to an
I2C or SMBus adapter that is not supported. See doc/FAQ,
doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
(FAQ #4.24.3) for further information.
If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.



What I have to do??

Many thankx
-- 

*Ing. Lisa Salvadorini*

/Antea Projects/

projects@anteasrl.it <mailto:projects@anteasrl.it>


/Toscocom by Antea srl/

/Via Pisana, 336 int.13/

/50018 OLMO -- SCANDICCI (FI)/

/Tel. +39 055 790 600/

/Fax +39 055 790 797/

/ITALY/


*/P Before printing, think about the environment/*


--------------090903090705090606030902
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
I have a proliant dl120 server, with centos 5.4 and I want to
monitoring the temperature and fault of the server but the software of
hp seems don't work.<br>
I have trid to install lm-sensor but the result is:<br>
<br>
<br>
[root@serverhost bus]# yum install lm_sensors<br>
Loaded plugins: fastestmirror<br>
Loading mirror speeds from cached hostfile<br>
* addons: centos.intergenia.de<br>
* base: centos.xengage.it<br>
* extras: centos.xengage.it<br>
* updates: centos.intergenia.de<br>
Setting up Install Process<br>
Package lm_sensors-2.10.7-4.el5.x86_64 already installed and latest
version<br>
Package lm_sensors-2.10.7-4.el5.i386 already installed and latest
version<br>
Nothing to do<br>
[root@serverhost bus]# sensors-detect<br>
# sensors-detect revision 5291 (2008-06-23 23:40:46 -0700)<br>
<br>
This program will help you determine which kernel modules you need<br>
to load to use lm_sensors most effectively. It is generally safe<br>
and recommended to accept the default answers to all questions,<br>
unless you know what you're doing.<br>
<br>
We can start with probing for (PCI) I2C or SMBus adapters.<br>
Do you want to probe now? (YES/no): <br>
Probing for PCI bus adapters...<br>
Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH9<br>
<br>
We will now try to load each adapter module in turn.<br>
Module `i2c-i801' already loaded.<br>
If you have undetectable or unsupported I2C/SMBus adapters, you can have<br>
them scanned by manually loading the modules before running this script.<br>
<br>
We are now going to do the I2C/SMBus adapter probings. Some chips may<br>
be double detected; we choose the one with the highest confidence<br>
value in that case.<br>
If you found that the adapter hung after probing a certain address,<br>
you can specify that address to remain unprobed.<br>
<br>
Next adapter: SMBus I801 adapter at 1c00 (i2c-0)<br>
Do you want to scan it? (YES/no/selectively): <br>
Client found at address 0x51<br>
Probing for `Analog Devices ADM1033'... No<br>
Probing for `Analog Devices ADM1034'... No<br>
Probing for `SPD EEPROM'... Yes<br>
(confidence 8, not a hardware monitoring chip)<br>
Probing for `EDID EEPROM'... No<br>
Client found at address 0x53<br>
Probing for `Analog Devices ADM1033'... No<br>
Probing for `Analog Devices ADM1034'... No<br>
Probing for `SPD EEPROM'... Yes<br>
(confidence 8, not a hardware monitoring chip)<br>
Probing for `EDID EEPROM'... No<br>
<br>
Some chips are also accessible through the ISA I/O ports. We have to<br>
write to arbitrary I/O ports to probe them. This is usually safe though.<br>
Yes, you do have ISA I/O ports even if you do not have any ISA slots!<br>
Do you want to scan the ISA I/O ports? (YES/no): <br>
Probing for `National Semiconductor LM78' at 0x290... No<br>
Probing for `National Semiconductor LM78-J' at 0x290... No<br>
Probing for `National Semiconductor LM79' at 0x290... No<br>
Probing for `Winbond W83781D' at 0x290... No<br>
Probing for `Winbond W83782D' at 0x290... No<br>
<br>
Some Super I/O chips may also contain sensors. We have to write to<br>
standard I/O ports to probe them. This is usually safe.<br>
Do you want to scan for Super I/O sensors? (YES/no): <br>
Probing for Super-I/O at 0x2e/0x2f<br>
Trying family `National Semiconductor'... No<br>
Trying family `SMSC'... No<br>
Trying family `VIA/Winbond/Fintek'... No<br>
Trying family `ITE'... No<br>
Probing for Super-I/O at 0x4e/0x4f<br>
Trying family `National Semiconductor'... No<br>
Trying family `SMSC'... No<br>
Trying family `VIA/Winbond/Fintek'... No<br>
Trying family `ITE'... No<br>
<br>
Some south bridges, CPUs or memory controllers may also contain<br>
embedded sensors. Do you want to scan for them? (YES/no): <br>
Silicon Integrated Systems SIS5595... No<br>
VIA VT82C686 Integrated Sensors... No<br>
VIA VT8231 Integrated Sensors... No<br>
AMD K8 thermal sensors... No<br>
AMD K10 thermal sensors... No<br>
Intel AMB FB-DIMM thermal sensor... No<br>
<br>
Sorry, no sensors were detected.<br>
Either your sensors are not supported, or they are connected to an<br>
I2C or SMBus adapter that is not supported. See doc/FAQ,<br>
doc/lm_sensors-FAQ.html or <a class="moz-txt-link-freetext" href="http://www.lm-sensors.org/wiki/FAQ">http://www.lm-sensors.org/wiki/FAQ</a><br>
(FAQ #4.24.3) for further information.<br>
If you find out what chips are on your board, check<br>
<a class="moz-txt-link-freetext" href="http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org/wiki/Devices</a> for driver status.<br>
<br>
<br>
<br>
What I have to do??<br>
<br>
Many thankx<br>
<div class="moz-signature">-- <br>
<meta http-equiv="CONTENT-TYPE" content="text/html; ">
<title></title>
<meta name="GENERATOR" content="OpenOffice.org 2.4  (Linux)">
<meta name="AUTHOR" content="Lisa">
<meta name="CREATED" content="20091211;12154300">
<meta name="CHANGEDBY" content="Lisa">
<meta name="CHANGED" content="20091211;14055700">
<style type="text/css">
	<!--
		@page { size: 8.5in 11in; margin: 0.79in }
		P { margin-bottom: 0.08in }
	-->
	</style>
<p style="margin-bottom: 0in; font-style: normal;"><font color="#000000"><font
 face="FreeSans, sans-serif"><font style="font-size: 9pt;" size="2"><b>Ing.
Lisa Salvadorini</b></font></font></font></p>
<p style="margin-bottom: 0in;"><font color="#000000"><font
 face="FreeSans, sans-serif"><font style="font-size: 9pt;" size="2"><i>Antea
Projects</i></font></font></font></p>
<p style="margin-bottom: 0in;"><font face="FreeSans, sans-serif"><font
 style="font-size: 9pt;" size="2"><a href="mailto:projects@anteasrl.it"><font
 color="#0000fe"><span style="font-style: normal;">projects@anteasrl.it</span></font></a></font></font></p>
<p style="margin-bottom: 0in;"><br>
</p>
<p style="margin-bottom: 0in;"><font color="#000000"><font
 face="FreeSans, sans-serif"><font style="font-size: 9pt;" size="2"><i>Toscocom
by Antea srl</i></font></font></font></p>
<p style="margin-bottom: 0in;"><font color="#000000"><font
 face="FreeSans, sans-serif"><font style="font-size: 9pt;" size="2"><i>Via
Pisana, 336 int.13</i></font></font></font></p>
<p style="margin-bottom: 0in;"><font color="#000000"><font
 face="FreeSans, sans-serif"><font style="font-size: 9pt;" size="2"><i>50018
OLMO &#8211; SCANDICCI (FI)</i></font></font></font></p>
<p style="margin-bottom: 0in;"><font color="#000000"><font
 face="FreeSans, sans-serif"><font style="font-size: 9pt;" size="2"><i>Tel.
+39 055 790 600</i></font></font></font></p>
<p style="margin-bottom: 0in;"><font color="#000000"><font
 face="FreeSans, sans-serif"><font style="font-size: 9pt;" size="2"><i>Fax
+39 055 790 797</i></font></font></font></p>
<p style="margin-bottom: 0in;"><font color="#000000"><font
 face="FreeSans, sans-serif"><font style="font-size: 9pt;" size="2"><i>ITALY</i></font></font></font></p>
<p style="margin-bottom: 0in;"><br>
</p>
<p style="margin-bottom: 0in;"><font color="#33cc66"><font
 face="FreeSans, sans-serif"><font style="font-size: 9pt;" size="2"><b><i>P
Before printing, think about the environment</i></b></font></font></font></p>
</div>
</body>
</html>

--------------090903090705090606030902--


--===============0102674659092578164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0102674659092578164==--

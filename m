From: b13johnson@comcast.net
Date: Wed, 20 Jan 2010 04:30:11 +0000
Subject: [lm-sensors]  LPC47M192-NC Fans
Message-Id: <284935213.1425811263961811650.JavaMail.root@sz0153a.westchester.pa.mail.comcast.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6832370594040291885=="
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
To: lm-sensors@vger.kernel.org

--===============6832370594040291885==
Content-Type: multipart/alternative; 
	boundary="----=_Part_74329_182988131.1263961811649"

------=_Part_74329_182988131.1263961811649
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Jean, 

I am having what I believe is a similar problem to what Sean had. I have an HP pavilion desktop computer. I couldn't get sensors-detect to work with my smsc47m1 driver to work until I downloaded and built your modified one. Once I installed it, I got the following snippet from sensors-detect: 

---------------------------------------------------------- 
Some Super I/O chips contain embedded sensors. We have to write to 
standard I/O ports to probe them. This is usually safe. 
Do you want to scan for Super I/O sensors? (YES/no): y 
Probing for Super-I/O at 0x2e/0x2f 
Trying family `National Semiconductor'... No 
Trying family `SMSC'... Yes 
Found `SMSC LPC47M15x/192/997 Super IO Fan Sensors' Success! 
(address 0x600, driver `smsc47m1') 
Probing for Super-I/O at 0x4e/0x4f 
Trying family `National Semiconductor'... No 
Trying family `SMSC'... No 
Trying family `VIA/Winbond/Nuvoton/Fintek'... No 
Trying family `ITE'... No 
---------------------------------------------------------- 

However, at the end I get: 

---------------------------------------------------------- 
Now follows a summary of the probes I have just done. 
Just press ENTER to continue: 

Driver `smsc47m1': 
* ISA bus, address 0x600 
Chip `SMSC LPC47M15x/192/997 Super IO Fan Sensors' (confidence: 9) 

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): y 
Starting lm_sensors: loading module smsc47m1 No sensors found! 
Make sure you loaded all the kernel drivers you need. 
Try sensors-detect to find out which these are. 
[FAILED] 
Unloading i2c-dev... OK 
---------------------------------------------------------- 

If I answer no to the last question, and try to run modprobe manually, I get: 

---------------------------------------------------------- 
[root@Backup-P4 smsc47m1_driver]# modprobe smsc47m1 
FATAL: Error inserting smsc47m1 (/lib/modules/2.6.31.9-174.fc12.i686.PAE/kernel/drivers/hwmon/smsc47m1.ko): Device or resource busy 
---------------------------------------------------------- 

The log file "messages" has the following: 

---------------------------------------------------------- 
Jan 18 23:06:51 localhost kernel: i2c /dev entries driver 
Jan 18 23:07:05 localhost kernel: smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997 
Jan 18 23:07:05 localhost kernel: ACPI: I/O resource smsc47m1 [0x604-0x604] conflicts with ACPI region SMC_ [0x600 
-0x65f] 
Jan 18 23:07:05 localhost kernel: ACPI: If an ACPI driver is available for this device, you should use it instead 
of the native driver 
---------------------------------------------------------- 

I'm running Fedora Core kernel 2.6.31.9-174.fc12.i686.PAE 

Do you have any ideas? I really appreciate your help. 

Thanks, 
Bob 


------=_Part_74329_182988131.1263961811649
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Arial; font-size: 12pt; color: #000000'>Hi Jean,<=
br><br>I am having what I believe is a similar problem to what Sean had. I =
have an HP pavilion desktop computer. I couldn't get sensors-detect to work=
 with my smsc47m1 driver to work until I downloaded and built your modified=
 one. Once I installed it, I got the following snippet from sensors-detect:=
<br><br>----------------------------------------------------------<br>Some =
Super I/O chips contain embedded sensors. We have to write to<br>standard I=
/O ports to probe them. This is usually safe.<br>Do you want to scan for Su=
per I/O sensors? (YES/no): y<br>Probing for Super-I/O at 0x2e/0x2f<br>Tryin=
g family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br=
>Trying family `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Yes<br>Found `SMSC LPC47M15x/192/997 Super IO Fan Sensors'&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<br>&nbsp;&nbsp;&nb=
sp; (address 0x600, driver `smsc47m1')<br>Probing for Super-I/O at 0x4e/0x4=
f<br>Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; No<br>Trying family `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `VIA/Winbond/Nuvoton/Fintek'.=
..&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; No<br>Trying family `ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>-------------------------------=
---------------------------<br>
<br>However, at the end I get:<br><br>-------------------------------------=
---------------------<br>Now follows a summary of the probes I have just do=
ne.<br>Just press ENTER to continue: <br><br>Driver `smsc47m1':<br>&nbsp; *=
 ISA bus, address 0x600<br>&nbsp;&nbsp;&nbsp; Chip `SMSC LPC47M15x/192/997 =
Super IO Fan Sensors' (confidence: 9)<br><br>Do you want to overwrite /etc/=
sysconfig/lm_sensors? (YES/no): y<br>Starting lm_sensors: loading module sm=
sc47m1 No sensors found!<br>Make sure you loaded all the kernel drivers you=
 need.<br>Try sensors-detect to find out which these are.<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [FAILED]<br>Unloading i2c-dev... OK<br>-=
---------------------------------------------------------<br>
<br>If I answer no to the last question, and try to run modprobe manually, =
I get:<br><br>----------------------------------------------------------<br=
>
[root@Backup-P4 smsc47m1_driver]# modprobe smsc47m1<br>FATAL: Error inserti=
ng smsc47m1 (/lib/modules/2.6.31.9-174.fc12.i686.PAE/kernel/drivers/hwmon/s=
msc47m1.ko): Device or resource busy<br>-----------------------------------=
-----------------------<br>
<br>The log file "messages" has the following:<br><br>---------------------=
-------------------------------------<br>Jan 18 23:06:51 localhost kernel: =
i2c /dev entries driver<br>Jan 18 23:07:05 localhost kernel: smsc47m1: Foun=
d SMSC LPC47M15x/LPC47M192/LPC47M997<br>Jan 18 23:07:05 localhost kernel: A=
CPI: I/O resource smsc47m1 [0x604-0x604] conflicts with ACPI region SMC_ [0=
x600<br>-0x65f]<br>Jan 18 23:07:05 localhost kernel: ACPI: If an ACPI drive=
r is available for this device, you should use it instead <br>of the native=
 driver<br>----------------------------------------------------------<br>

<br>I'm running Fedora Core kernel 2.6.31.9-174.fc12.i686.PAE<br><br>Do you=
 have any ideas? I really appreciate your help.<br><br>Thanks,<br>Bob<br><b=
r></div></body></html>
------=_Part_74329_182988131.1263961811649--


--===============6832370594040291885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6832370594040291885==--

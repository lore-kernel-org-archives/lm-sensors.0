From: "RYAN M. vAN GINNEKEN" <luck@computerking.ca>
Date: Wed, 22 Aug 2007 06:04:32 +0000
Subject: [lm-sensors] intel 7501wv2 server board
Message-Id: <22272395.631187762672311.JavaMail.root@shoemasters.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6068230223431217898=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6068230223431217898==
Content-Type: multipart/alternative; 
	boundary="----=_Part_17_26429250.1187762672309"

------=_Part_17_26429250.1187762672309
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


Hello i have the intel 7501wv2 serverboard and i am running CentOS 5 like so also i have 533 dual xeons in this board and read some stuff on the wiki about cpu sensors and using xeontemp not to clear on most of what i need to do. 

Linux canmail.org 2.6.18-8.1.8.el5 #1 SMP Tue Jul 10 06:50:22 EDT 2007 i686 i686 i386 GNU/Linux 

Below the output of the lm-sensors detection wizard i downloaded the newest one. I have tried to load the modules recommended at the end of the wizard and i get this. 

[root@canmail /]# /sbin/modprobe ipmi-si 
[root@canmail /]# /sbin/modprobe ipmisensors 
FATAL: Module ipmisensors not found. 

one works one does not to sure about the alias stuff anywho i get this error when i run the sensors command. I read some stuff in this list to check for /devs so i did and the one required seems to be there. 

[root@canmail /]# sensors 
Can't access procfs/sysfs file 
Unable to find i2c bus information; 
For 2.6 kernels, make sure you have mounted sysfs and libsensors 
was compiled with sysfs support! 
For older kernels, make sure you have done 'modprobe i2c-proc'! 
[root@canmail /]# ls -l /dev/i2c-0 
crw------- 1 root root 89, 0 Aug 21 21:54 /dev/i2c-0 
[root@canmail /]# ls -l /dev/i2c* 
crw------- 1 root root 89, 0 Aug 21 21:54 /dev/i2c-0 

[root@canmail c0mputerking]# perl "sensors-detect?format=txt" 
# sensors-detect revision $Revision$ 

This program will help you determine which kernel modules you need 
to load to use lm_sensors most effectively. It is generally safe 
and recommended to accept the default answers to all questions, 
unless you know what you're doing. 

We can start with probing for (PCI) I2C or SMBus adapters. 
Do you want to probe now? (YES/no): YES 
Probing for PCI bus adapters... 
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801CA/CAM ICH3 

We will now try to load each adapter module in turn. 
Module `i2c-i801' already loaded. 
If you have undetectable or unsupported adapters, you can have them 
scanned by manually loading the modules before running this script. 

To continue, we need module `i2c-dev' to be loaded. 
Do you want to load `i2c-dev' now? (YES/no): YES 
Module loaded successfully. 

We are now going to do the I2C/SMBus adapter probings. Some chips may 
be double detected; we choose the one with the highest confidence 
value in that case. 
If you found that the adapter hung after probing a certain address, 
you can specify that address to remain unprobed. 

Next adapter: SMBus I801 adapter at 0580 (i2c-0) 
Do you want to scan it? (YES/no/selectively): YES 
Client found at address 0x44 
Probing for `Maxim MAX6633/MAX6634/MAX6635'... No 
Client found at address 0x52 
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
Probing for `Silicon Integrated Systems SIS5595'... No 
Probing for `VIA VT82C686 Integrated Sensors'... No 
Probing for `VIA VT8231 Integrated Sensors'... No 
Probing for `IPMI BMC KCS' at 0xca0... Success! 
(confidence 4, driver `ipmisensors') 
Probing for `IPMI BMC SMIC' at 0xca8... No 

Some Super I/O chips may also contain sensors. We have to write to 
standard I/O ports to probe them. This is usually safe. 
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f 
Trying family `National Semiconductor'... Yes 
Found `Nat. Semi. PC8741x Super IO' 
(no hardware monitoring capabilities) 
Probing for Super-I/O at 0x4e/0x4f 
Trying family `National Semiconductor'... No 
Trying family `SMSC'... No 
Trying family `VIA/Winbond/Fintek'... No 
Trying family `ITE'... No 

Some CPUs or memory controllers may also contain embedded sensors. 
Do you want to scan for them? (YES/no): 
AMD K8 thermal sensors... No 
Intel Core family thermal sensor... No 
Intel AMB FB-DIMM thermal sensor... No 

Now follows a summary of the probes I have just done. 
Just press ENTER to continue: 

Driver `ipmisensors' (should be inserted): 
Detects correctly: 
* ISA bus, address 0xca0 
Chip `IPMI BMC KCS' (confidence: 4) 

I will now generate the commands needed to load the required modules. 
Just press ENTER to continue: 

To make the sensors modules behave correctly, add these lines to 
/etc/modprobe.conf: 

#----cut here---- 
# I2C module options 
alias char-major-89 i2c-dev 
#----cut here---- 

To load everything that is needed, add this to some /etc/rc* file: 

#----cut here---- 
# You must also install and load the IPMI modules 
modprobe ipmi-si 
# Chip drivers 
# Warning: the required module ipmisensors is not currently installed 
# on your system. For status of 2.6 kernel ports check 
# http://www.lm-sensors.org/wiki/Devices. If driver is built 
# into the kernel, or unavailable, comment out the following line. 
modprobe ipmisensors 
# sleep 2 # optional 
/usr/bin/sensors -s # recommended 
#----cut here---- 

If you have some drivers built into your kernel, the list above will 
contain too many modules. Skip the appropriate ones! You really 
should try these commands right now to make sure everything is 
working properly. Monitoring programs won't work until the needed 
modules are loaded. 

-- 
Computer King & CaN Mail - Sales Service Hosting Backup 

http://www.computerking.ca http://www.canmail.org 

NEW!!! Custom Service Packages 
Secure IMAP Email - Automated Remote Backups - Photo Blogs - Online Accounting Packages 


------=_Part_17_26429250.1187762672309
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div style=3D'font-family:Arial, Helvetica, sans-serif;font-size:12pt;color=
:#000000;'><div style=3D"font-family: Arial,Helvetica,sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">Hello i have the intel 7501wv2 serverboard an=
d i am running CentOS 5 like so also i have 533 dual xeons in this board an=
d read some stuff on the wiki about cpu sensors and using xeontemp not to c=
lear on most of what i need to do.<br><br>Linux canmail.org 2.6.18-8.1.8.el=
5 #1 SMP Tue Jul 10 06:50:22 EDT 2007 i686 i686 i386 GNU/Linux<br><br>Below=
 the output of the lm-sensors detection wizard i downloaded the newest one.=
&nbsp; I have tried to load the modules recommended at the end of the wizar=
d and i get this.&nbsp; <br><br>[root@canmail /]# /sbin/modprobe ipmi-si<br=
>[root@canmail /]# /sbin/modprobe ipmisensors<br>FATAL: Module ipmisensors =
not found.<br><br>one works one does not to sure about the alias stuff anyw=
ho i get this error when i run the sensors command.&nbsp;&nbsp; I read some=
 stuff in this list to check for /devs so i did and the one required seems =
to be there. <br><br>[root@canmail /]# sensors<br>Can't access procfs/sysfs=
 file<br>Unable to find i2c bus information;<br>For 2.6 kernels, make sure =
you have mounted sysfs and libsensors<br>was compiled with sysfs support!<b=
r>For older kernels, make sure you have done 'modprobe i2c-proc'!<br>[root@=
canmail /]# ls -l /dev/i2c-0<br>crw------- 1 root root 89, 0 Aug 21 21:54 /=
dev/i2c-0<br>[root@canmail /]# ls -l /dev/i2c*<br>crw------- 1 root root 89=
, 0 Aug 21 21:54 /dev/i2c-0<br><br>[root@canmail c0mputerking]# perl "senso=
rs-detect?format=3Dtxt"<br># sensors-detect revision $Revision$<br><br>This=
 program will help you determine which kernel modules you need<br>to load t=
o use lm_sensors most effectively. It is generally safe<br>and recommended =
to accept the default answers to all questions,<br>unless you know what you=
're doing.<br><br>We can start with probing for (PCI) I2C or SMBus adapters=
.<br>Do you want to probe now? (YES/no): YES<br>Probing for PCI bus adapter=
s...<br>Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801CA/CAM IC=
H3<br><br>We will now try to load each adapter module in turn.<br>Module `i=
2c-i801' already loaded.<br>If you have undetectable or unsupported adapter=
s, you can have them<br>scanned by manually loading the modules before runn=
ing this script.<br><br>To continue, we need module `i2c-dev' to be loaded.=
<br>Do you want to load `i2c-dev' now? (YES/no): YES<br>Module loaded succe=
ssfully.<br><br>We are now going to do the I2C/SMBus adapter probings. Some=
 chips may<br>be double detected; we choose the one with the highest confid=
ence<br>value in that case.<br>If you found that the adapter hung after pro=
bing a certain address,<br>you can specify that address to remain unprobed.=
<br><br>Next adapter: SMBus I801 adapter at 0580 (i2c-0)<br>Do you want to =
scan it? (YES/no/selectively): YES<br>Client found at address 0x44<br>Probi=
ng for `Maxim MAX6633/MAX6634/MAX6635'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Client found at address =
0x52<br>Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; No<br>Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `SPD EEPROM'...&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>&nbsp;&nbsp;&nbsp; (confidence 8,=
 not a hardware monitoring chip)<br>Probing for `EDID EEPROM'...&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; No<br><br>Some chips are also accessible through =
the ISA I/O ports. We have to<br>write to arbitrary I/O ports to probe them=
. This is usually safe though.<br>Yes, you do have ISA I/O ports even if yo=
u do not have any ISA slots!<br>Do you want to scan the ISA I/O ports? (YES=
/no):<br>Probing for `National Semiconductor LM78' at 0x290...&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `National Semiconductor LM78-J' a=
t 0x290...&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `National Semiconducto=
r LM79' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `=
Winbond W83781D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing=
 for `Winbond W83782D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>P=
robing for `Silicon Integrated Systems SIS5595'...&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `VIA VT82C686 Integrated Sensors'=
...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br=
>Probing for `VIA VT8231 Integrated Sensors'...&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `IPMI =
BMC KCS' at 0xca0...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Suc=
cess!<br>&nbsp;&nbsp;&nbsp; (confidence 4, driver `ipmisensors')<br>Probing=
 for `IPMI BMC SMIC' at 0xca8...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; No<br><br>Some Super I/O chips may also contain sensors. We have to writ=
e to<br>standard I/O ports to probe them. This is usually safe.<br>Do you w=
ant to scan for Super I/O sensors? (YES/no):<br>Probing for Super-I/O at 0x=
2e/0x2f<br>Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; Yes<br>Found `Nat. Semi. PC8741x Super IO'<br>&nbsp;&nbsp;&nbsp;=
 (no hardware monitoring capabilities)<br>Probing for Super-I/O at 0x4e/0x4=
f<br>Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; No<br>Trying family `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `VIA/Winbond/Fintek'...&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `IT=
E'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; No<br><br>Some CPUs or memory controllers may also contain embedded sens=
ors.<br>Do you want to scan for them? (YES/no):<br>AMD K8 thermal sensors..=
.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Intel Core fa=
mily thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; No<br>Intel AMB FB-DIMM thermal sensor...&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br><br>Now follows =
a summary of the probes I have just done.<br>Just press ENTER to continue:<=
br><br>Driver `ipmisensors' (should be inserted):<br>&nbsp; Detects correct=
ly:<br>&nbsp; * ISA bus, address 0xca0<br>&nbsp;&nbsp;&nbsp; Chip `IPMI BMC=
 KCS' (confidence: 4)<br><br>I will now generate the commands needed to loa=
d the required modules.<br>Just press ENTER to continue:<br><br>To make the=
 sensors modules behave correctly, add these lines to<br>/etc/modprobe.conf=
:<br><br>#----cut here----<br># I2C module options<br>alias char-major-89 i=
2c-dev<br>#----cut here----<br><br>To load everything that is needed, add t=
his to some /etc/rc* file:<br><br>#----cut here----<br># You must also inst=
all and load the IPMI modules<br>modprobe ipmi-si<br># Chip drivers<br># Wa=
rning: the required module ipmisensors is not currently installed<br># on y=
our system. For status of 2.6 kernel ports check<br># http://www.lm-sensors=
.org/wiki/Devices. If driver is built<br># into the kernel, or unavailable,=
 comment out the following line.<br>modprobe ipmisensors<br># sleep 2 # opt=
ional<br>/usr/bin/sensors -s # recommended<br>#----cut here----<br><br>If y=
ou have some drivers built into your kernel, the list above will<br>contain=
 too many modules. Skip the appropriate ones! You really<br>should try thes=
e commands right now to make sure everything is<br>working properly. Monito=
ring programs won't work until the needed<br>modules are loaded.<br><br>-- =
<br>Computer&nbsp;King&nbsp;&amp;&nbsp;CaN&nbsp;Mail&nbsp;&nbsp;-&nbsp;&nbs=
p;Sales&nbsp;Service&nbsp;Hosting&nbsp;Backup<br><br>http://www.computerkin=
g.ca&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;http://www.canmail.org<br><br>NEW!!!&nbsp=
;Custom&nbsp;Service&nbsp;Packages<br>Secure&nbsp;IMAP&nbsp;Email&nbsp;-&nb=
sp;Automated&nbsp;Remote&nbsp;Backups&nbsp;-&nbsp;Photo&nbsp;Blogs&nbsp;-&n=
bsp;Online&nbsp;Accounting&nbsp;Packages&nbsp;<br><br></div>
------=_Part_17_26429250.1187762672309--



--===============6068230223431217898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6068230223431217898==--


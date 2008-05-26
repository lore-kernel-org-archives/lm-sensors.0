From: =?us-ascii?Q?Jaroslav=20Vacha?= <vacha@email.cz>
Date: Mon, 26 May 2008 19:08:31 +0000
Subject: [lm-sensors] dme1737 under CentOS 2.6.18 kernel
Message-Id: <9557.11526-6111-934845850-1211828908@email.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1957311345198180055=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============1957311345198180055==
Content-Type: multipart/alternative;
	boundary="MessagePart:405967981.0-6111-1054020789-1211828908"


--MessagePart:405967981.0-6111-1054020789-1211828908
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="us-ascii"

Hi, 
 I'm trying to compile dme1737 driver under CentOS 5.1 with 2.6.18-
53.1.21.el5 kernel to support VIA EPIA-SN 18000G motherboard 
sensors.
 Followed Juerg's instruction from post http://lists.lm-sensors.org/
pipermail/lm-sensors/2007-December/022166.html

 Code compiled with warnings:

#make all
make -C /lib/modules/`uname -r`/build M=/install/lm_sensors/driver 
modules
make[1]: Entering directory `/usr/src/kernels/2.6.18-53.1.21.el5-i
686'
 CC [M] /install/lm_sensors/driver/dme1737.o
/install/lm_sensors/driver/dme1737.c:55: warning: initialization 
discards qualifiers from pointer target type
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_i2c_
detect':
/install/lm_sensors/driver/dme1737.c:2139: warning: assignment from 
incompatible pointer type
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_i2c_
detach_client':
/install/lm_sensors/driver/dme1737.c:2172: warning: passing argument
1 of 'hwmon_device_unregister' from incompatible pointer type
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_isa_
probe':
/install/lm_sensors/driver/dme1737.c:2324: warning: assignment from 
incompatible pointer type
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_isa_
remove':
/install/lm_sensors/driver/dme1737.c:2348: warning: passing argument
1 of 'hwmon_device_unregister' from incompatible pointer type
 Building modules, stage 2.
 MODPOST
 CC     /install/lm_sensors/driver/dme1737.mod.o
 LD [M] /install/lm_sensors/driver/dme1737.ko
make[1]: Leaving directory `/usr/src/kernels/2.6.18-53.1.21.el5-i
686'
[root@server driver]#

 dme1737.ko module is created and copied in /lib/modules/2.6.18-
53.1.21.el5/kernel/drivers/hwmon path. But when I tried to insert 
this module into kernel, module is not loaded with following error 
message:

#insmod dme1737.ko
insmod: error inserting 'dme1737.ko': -1 Unknown symbol in module

Do you have any idea where is a mistake? Thanks for your reply
Jaroslav


 

--MessagePart:405967981.0-6111-1054020789-1211828908
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset="us-ascii"

Hi, <br>
&nbsp; I'm trying to compile dme1737 driver under&nbsp; CentOS 5.1 with
2.6.18-53.1.21.el5 kernel to support VIA EPIA-SN 18000G motherboard
sensors.<br>
&nbsp; Followed Juerg's instruction from post http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December/022166.html<br>
<br>
&nbsp; Code compiled with warnings:<br>
<br>
#make all<br>
make -C /lib/modules/`uname -r`/build M=/install/lm_sensors/driver modules<br>
make[1]: Entering directory `/usr/src/kernels/2.6.18-53.1.21.el5-i686'<br>
&nbsp; CC [M]&nbsp; /install/lm_sensors/driver/dme1737.o<br>
/install/lm_sensors/driver/dme1737.c:55: warning: initialization discards qualifiers from pointer target type<br>
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_i2c_detect':<br>
/install/lm_sensors/driver/dme1737.c:2139: warning: assignment from incompatible pointer type<br>
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_i2c_detach_client':<br>
/install/lm_sensors/driver/dme1737.c:2172: warning: passing argument 1
of 'hwmon_device_unregister' from incompatible pointer type<br>
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_isa_probe':<br>
/install/lm_sensors/driver/dme1737.c:2324: warning: assignment from incompatible pointer type<br>
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_isa_remove':<br>
/install/lm_sensors/driver/dme1737.c:2348: warning: passing argument 1
of 'hwmon_device_unregister' from incompatible pointer type<br>
&nbsp; Building modules, stage 2.<br>
&nbsp; MODPOST<br>
&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /install/lm_sensors/driver/dme1737.mod.o<br>
&nbsp; LD [M]&nbsp; /install/lm_sensors/driver/dme1737.ko<br>
make[1]: Leaving directory `/usr/src/kernels/2.6.18-53.1.21.el5-i686'<br>
[root@server driver]#<br>
<br>
&nbsp; dme1737.ko module is created and copied in
/lib/modules/2.6.18-53.1.21.el5/kernel/drivers/hwmon path. But when I
tried to insert this module into kernel, module is not loaded with
following error message:<br>
<br>
#insmod dme1737.ko<br>
insmod: error inserting 'dme1737.ko': -1 Unknown symbol in module<br>
<br>
Do you have any idea where is a mistake? Thanks for your reply<br>
Jaroslav<br>
<br>
<p>&nbsp;</p>
--MessagePart:405967981.0-6111-1054020789-1211828908--


--===============1957311345198180055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1957311345198180055==--

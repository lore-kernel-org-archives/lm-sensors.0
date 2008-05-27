From: =?us-ascii?Q?Jaroslav=20Vacha?= <vacha@email.cz>
Date: Tue, 27 May 2008 07:09:14 +0000
Subject: Re: [lm-sensors] dme1737 under CentOS 2.6.18 kernel
Message-Id: <9557.11471-7860-227731522-1211872154@email.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9054164066708532238=="
List-Id: <lm-sensors.vger.kernel.org>
References: <9557.11526-6111-934845850-1211828908@email.cz>
In-Reply-To: <9557.11526-6111-934845850-1211828908@email.cz>
To: lm-sensors@vger.kernel.org


--===============9054164066708532238==
Content-Type: multipart/alternative;
	boundary="MessagePart:108928047.0-7590-443905041-1211871808"


--MessagePart:108928047.0-7590-443905041-1211871808
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset="iso-8859-2"

Hi Juerg,<br>&nbsp; thanks for your hints! After 'depmod -a' and patch =
driver is&nbsp; loaded now and lm_sensors are working:<br><br># sensors=
<br>sch311x-isa-0a70<br>Adapter: ISA adapter<br>in0:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.00 V&nbsp; (min =3D&nbsp; +0.00 V, max=
 =3D&nbsp; +6.64 V)&nbsp;&nbsp; ALARM<br>in1:&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; +1.76 V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nb=
sp; +2.99 V)<br>in2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3=
.25 V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +4.38 V)<br>in3:&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.99 V&nbsp; (min =3D&nbsp=
; +0.00 V, max =3D&nbsp; +6.64 V)<br>in4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; +12.31 V&nbsp; (min =3D&nbsp; +0.00 V, max =3D +15.94 V)<b=
r>in5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.27 V&nbsp; (m=
in =3D&nbsp; +0.00 V, max =3D&nbsp; +4.38 V)<br>in6:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.17 V&nbsp; (min =3D&nbsp; +0.00 V, max=
 =3D&nbsp; +4.38 V)<br>fan1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; 0 RPM)<br>fan2:&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1747 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbs=
p; 0 RPM)<br>fan3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; 0 RPM)<br>temp1:&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; +47.6=B0C&nbsp; (low&nbsp; =3D -127.0=B0C, high =
=3D +127.0=B0C)<br>temp2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +42.8=B0C=
&nbsp; (low&nbsp; =3D -127.0=B0C, high =3D +127.0=B0C)<br>temp3:&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +41.1=B0C&nbsp; (low&nbsp; =3D -127.0=B0C=
, high =3D +127.0=B0C)<br>cpu0_vid:&nbsp;&nbsp; +0.000 V<br><br>I have =
only small error in messages log regarding hwmon-vid module, but I can =
live with it..:<br><br>May 27 10:33:34 obelix kernel: dme1737 dme1737.2=
672: Found a SCH311x chip at 0x0a70<br>May 27 10:33:34 obelix kernel: d=
me1737 dme1737.2672: Optional features: pwm3=3Dyes, pwm5=3Dno, pwm6=3Dn=
o, fan3=3Dyes, fan4=3Dno, fan5=3Dno, fan6=3Dno.<br>May 27 10:33:34 obel=
ix kernel: hwmon-vid: Unknown VRM version of your x86 CPU<br><br>Thanks=
 again for your kind help!<br>Jaroslav<br><br><br><br>
<br>
------------ P=F9vodn=ED zpr=E1va ------------<br>
<b>Od:</b> Juerg Haefliger &lt;juergh@gmail.com&gt;<br>
<b>P=F8edm=ECt:</b> Re: [lm-sensors] dme1737 under CentOS 2.6.18 kernel=
<br>
<b>Datum:</b> 27.5.2008 01:37:05<br>
---------------------------------------------<br>
Hi Jaroslav,<br><br><br><div class=3D"gmail_quote">On Mon, May 26, 2008=
 at 12:08 PM, Jaroslav Vacha &lt;<a href=3D"mailto:vacha@email.cz">vach=
a@email.cz</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
Hi, <br>
&nbsp; I'm trying to compile dme1737 driver under&nbsp; CentOS 5.1 with=

2.6.18-53.1.21.el5 kernel to support VIA EPIA-SN 18000G motherboard
sensors.<br>
&nbsp; Followed Juerg's instruction from post <a href=3D"http://lists.l=
m-sensors.org/pipermail/lm-sensors/2007-December/022166.html" target=3D=
"_blank">http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December=
/022166.html</a><br>

<br>
&nbsp; Code compiled with warnings:<br>
<br>
#make all<br>
make -C /lib/modules/`uname -r`/build M=3D/install/lm_sensors/driver mo=
dules<br>
make[1]: Entering directory `/usr/src/kernels/2.6.18-53.1.21.el5-i686'<=
br>
&nbsp; CC [M]&nbsp; /install/lm_sensors/driver/dme1737.o<br>
/install/lm_sensors/driver/dme1737.c:55: warning: initialization discar=
ds qualifiers from pointer target type<br>
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_i2c_detect':=
<br>
/install/lm_sensors/driver/dme1737.c:2139: warning: assignment from inc=
ompatible pointer type<br>
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_i2c_detach_c=
lient':<br>
/install/lm_sensors/driver/dme1737.c:2172: warning: passing argument 1
of 'hwmon_device_unregister' from incompatible pointer type<br>
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_isa_probe':<=
br>
/install/lm_sensors/driver/dme1737.c:2324: warning: assignment from inc=
ompatible pointer type<br>
/install/lm_sensors/driver/dme1737.c: In function 'dme1737_isa_remove':=
<br>
/install/lm_sensors/driver/dme1737.c:2348: warning: passing argument 1
of 'hwmon_device_unregister' from incompatible pointer type<br>
&nbsp; Building modules, stage 2.<br>
&nbsp; MODPOST<br>
&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /install/lm_sensors/driver/dme1=
737.mod.o<br>
&nbsp; LD [M]&nbsp; /install/lm_sensors/driver/dme1737.ko<br>
make[1]: Leaving directory `/usr/src/kernels/2.6.18-53.1.21.el5-i686'<b=
r>
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
Do you have any idea where is a mistake? Thanks for your reply<br><font=
 color=3D"#888888"></font></blockquote><div><br>The dme1737 driver depe=
nds on i2c-core and hwmon-vid. My guess is one or both of those aren't =
loaded. Do 'depmod -a' and then 'modprobe dme1737 probe_all_addr=3D1' t=
o load the driver an all the modules it depends upon.<br>
Note that for the driver to correctly work on a SN18000 board, you need=
 to have the following patch applied (hence the probe_all_addr option):=
<br><a href=3D"http://lists.lm-sensors.org/pipermail/lm-sensors/2008-Ap=
ril/022802.html">http://lists.lm-sensors.org/pipermail/lm-sensors/2008-=
April/022802.html</a><br>
<br>...juerg<br><br>&nbsp;</div><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;"><font color=3D"#888888">
Jaroslav<br>
<br>
<p>&nbsp;</p></font><br>_______________________________________________=
<br>
lm-sensors mailing list<br>
<a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org<=
/a><br>
<a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" tar=
get=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors<=
/a><br></blockquote></div><br>


--MessagePart:108928047.0-7590-443905041-1211871808
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset="iso-8859-2"

Hi Juerg,
 thanks for your hints! After 'depmod -a' and patch driver is loaded
now and lm_sensors are working:

# sensors
sch311x-isa-0a70
Adapter: ISA adapter
in0:        +0.00 V (min =3D +0.00 V, max =3D +6.64 V)  ALARM
in1:        +1.76 V (min =3D +0.00 V, max =3D +2.99 V)
in2:        +3.25 V (min =3D +0.00 V, max =3D +4.38 V)
in3:        +4.99 V (min =3D +0.00 V, max =3D +6.64 V)
in4:       +12.31 V (min =3D +0.00 V, max =3D +15.94 V)
in5:        +3.27 V (min =3D +0.00 V, max =3D +4.38 V)
in6:        +3.17 V (min =3D +0.00 V, max =3D +4.38 V)
fan1:         0 RPM (min =3D   0 RPM)
fan2:      1747 RPM (min =3D   0 RPM)
fan3:         0 RPM (min =3D   0 RPM)
temp1:      +47.6=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
temp2:      +42.8=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
temp3:      +41.1=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
cpu0_vid:  +0.000 V

I have only small error in messages log regarding hwmon-vid module, 
but I can live with it..:

May 27 10:33:34 obelix kernel: dme1737 dme1737.2672: Found a SCH311x
chip at 0x0a70
May 27 10:33:34 obelix kernel: dme1737 dme1737.2672: Optional 
features: pwm3=3Dyes, pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dno, fan5=
=3Dno, 
fan6=3Dno.
May 27 10:33:34 obelix kernel: hwmon-vid: Unknown VRM version of 
your x86 CPU

Thanks again for your kind help!
Jaroslav




------------ P=F9vodn=ED zpr=E1va ------------
Od: Juerg Haefliger <juergh@gmail.com>
P=F8edm=ECt: Re: [lm-sensors] dme1737 under CentOS 2.6.18 kernel
Datum: 27.5.2008 01:37:05
---------------------------------------------
Hi Jaroslav,



On Mon, May 26, 2008 at 12:08 PM, Jaroslav Vacha <vacha@email.cz
(mailto:vacha@email.cz)> wrote:
" Hi, 
 I'm trying to compile dme1737 driver under CentOS 5.1 with 2.6.18-
53.1.21.el5 kernel to support VIA EPIA-SN 18000G motherboard 
sensors.
 Followed Juerg's instruction from post http://lists.lm-sensors.org/
pipermail/lm-sensors/2007-December/022166.html
(http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December/022166.=
html)

 Code compiled with warnings:

#make all
make -C /lib/modules/`uname -r`/build M=3D/install/lm_sensors/driver 
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
"

The dme1737 driver depends on i2c-core and hwmon-vid. My guess is 
one or both of those aren't loaded. Do 'depmod -a' and then 
'modprobe dme1737 probe_all_addr=3D1' to load the driver an all the 
modules it depends upon.
Note that for the driver to correctly work on a SN18000 board, you 
need to have the following patch applied (hence the probe_all_addr 
option):
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022802.
html
(http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022802.htm=
l)

...juerg

 
" Jaroslav


 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org(mailto:lm-sensors@lm-sensors.org)
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
(http://lists.lm-sensors.org/mailman/listinfo/lm-sensors)
"


--MessagePart:108928047.0-7590-443905041-1211871808--


--===============9054164066708532238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9054164066708532238==--

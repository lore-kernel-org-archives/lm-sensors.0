From: "Ubelhart, Ray" <rubelhar@harris.com>
Date: Fri, 25 Feb 2011 18:31:42 +0000
Subject: [lm-sensors] FW: w83795G Supermicro H8DGU-F
Message-Id: <77E104072DACA94993E7A23504E0C29F0559E9@ROCMXUS22.cs.myharris.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_000_77E104072DACA94993E7A23504E0C29F0559E9ROCMXUS22csmyharr_"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2889281146625041524==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_77E104072DACA94993E7A23504E0C29F0559E9ROCMXUS22csmyharr_"

--_000_77E104072DACA94993E7A23504E0C29F0559E9ROCMXUS22csmyharr_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



_____________________________________________
From: Ubelhart, Ray
Sent: Friday, February 25, 2011 9:43 AM
To: 'khali@linux-fr.org'
Subject: w83795G Supermicro H8DGU-F


Hello Jean,

I am using your driver on a new Supermicro motherboard and it populates the=
 hwmon sysfs attributes following load.  However for some reason even thoug=
h I am using your information for the w83795 device in sensors.conf,  I can=
not get the sensor data to appear when I execute "sensors", see information=
 included below.   Do you have any idea what I need?  I am using CentOS 5.5=
 x86_64 and the lm_sensors version which is part of this distribution.

Thank you
Ray Ubelhart
Harris Corporation
ray.ubelhart@harris.com<mailto:ray.ubelhart@harris.com>


[root@localhost device]# pwd
/sys/class/hwmon/hwmon0/device
[root@localhost device]# ls
beep_enable  fan7_min      in13_min    in5_min           temp1_input       =
temp5_max_hyst
bus          fan8_alarm    in14_alarm  in6_alarm         temp1_max         =
temp5_source_sel
driver       fan8_beep     in14_beep   in6_beep          temp1_max_hyst    =
temp5_type
fan1_alarm   fan8_input    in14_input  in6_input         temp1_source_sel  =
temp6_alarm
fan1_beep    fan8_min      in14_max    in6_max           temp1_type        =
temp6_beep
fan1_input   hwmon:hwmon0  in14_min    in6_min           temp2_alarm       =
temp6_crit
fan1_min     in0_alarm     in1_alarm   in7_alarm         temp2_beep        =
temp6_crit_hyst
fan2_alarm   in0_beep      in1_beep    in7_beep          temp2_crit        =
temp6_input
fan2_beep    in0_input     in1_input   in7_input         temp2_crit_hyst   =
temp6_max
fan2_input   in0_max       in1_max     in7_max           temp2_input       =
temp6_max_hyst
fan2_min     in0_min       in1_min     in7_min           temp2_max         =
temp6_source_sel
fan3_alarm   in10_alarm    in2_alarm   in8_alarm         temp2_max_hyst    =
temp6_type
fan3_beep    in10_beep     in2_beep    in8_beep          temp2_source_sel  =
temp7_alarm
fan3_input   in10_input    in2_input   in8_input         temp2_type        =
temp7_beep
fan3_min     in10_max      in2_max     in8_max           temp3_alarm       =
temp7_crit
fan4_alarm   in10_min      in2_min     in8_min           temp3_beep        =
temp7_crit_hyst
fan4_beep    in11_alarm    in3_alarm   in9_alarm         temp3_crit        =
temp7_input
fan4_input   in11_beep     in3_beep    in9_beep          temp3_crit_hyst   =
temp7_max
fan4_min     in11_input    in3_input   in9_input         temp3_input       =
temp7_max_hyst
fan5_alarm   in11_max      in3_max     in9_max           temp3_max         =
temp7_type
fan5_beep    in11_min      in3_min     in9_min           temp3_max_hyst    =
temp8_alarm
fan5_input   in12_alarm    in4_alarm   intrusion0_alarm  temp3_source_sel  =
temp8_beep
fan5_min     in12_beep     in4_beep    intrusion0_beep   temp3_type        =
temp8_crit
fan6_alarm   in12_input    in4_input   name              temp4_source_sel  =
temp8_crit_hyst
fan6_beep    in12_max      in4_max     power             temp5_alarm       =
temp8_input
fan6_input   in12_min      in4_min     subsystem         temp5_beep        =
temp8_max
fan6_min     in13_alarm    in5_alarm   temp1_alarm       temp5_crit        =
temp8_max_hyst
fan7_alarm   in13_beep     in5_beep    temp1_beep        temp5_crit_hyst   =
temp8_type
fan7_beep    in13_input    in5_input   temp1_crit        temp5_input       =
uevent
fan7_input   in13_max      in5_max     temp1_crit_hyst   temp5_max
[root@localhost device]# sensors
w83795g-i2c-0-2f
Adapter: SMBus PIIX4 adapter at 0b00

[root@localhost device]# uname -r
2.6.18-194.el5
[root@localhost device]# uname -a
Linux localhost.localdomain 2.6.18-194.el5 #1 SMP Fri Apr 2 14:58:14 EDT 20=
10 x86_64 x86_64 x86_64 GNU/Linux
[root@localhost device]# cat fan1_input
7758
[root@localhost device]# cat in0_input
988
[root@localhost device]# cat temp1_input
34500
[root@localhost device]# rpm -q lm_sensors
lm_sensors-2.10.7-9.el5


--_000_77E104072DACA94993E7A23504E0C29F0559E9ROCMXUS22csmyharr_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<div><font color=3D"#1F497D">&nbsp;</font></div>
<div><font color=3D"#1F497D">&nbsp;</font></div>
<div><font face=3D"Tahoma" size=3D"2"><span style=3D"font-size:10pt;">_____=
________________________________________<br>

<b>From:</b> Ubelhart, Ray <br>

<b>Sent:</b> Friday, February 25, 2011 9:43 AM<br>

<b>To:</b> 'khali@linux-fr.org'<br>

<b>Subject:</b> w83795G Supermicro H8DGU-F</span></font></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Hello Jean,</div>
<div>&nbsp;</div>
<div>I am using your driver on a new Supermicro motherboard and it populate=
s the hwmon sysfs attributes following load.&nbsp; However for some reason =
even though I am using your information for the w83795 device in sensors.co=
nf,&nbsp; I cannot get the sensor data to
appear when I execute &#8220;sensors&#8221;, see information included below=
.&nbsp;&nbsp; Do you have any idea what I need?&nbsp; I am using CentOS 5.5=
 x86_64 and the lm_sensors version which is part of this distribution.</div=
>
<div>&nbsp;</div>
<div>Thank you</div>
<div>Ray Ubelhart</div>
<div>Harris Corporation</div>
<div><a href=3D"mailto:ray.ubelhart@harris.com"><font color=3D"blue"><u>ray=
.ubelhart@harris.com</u></font></a></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>[root@localhost device]# pwd</div>
<div>/sys/class/hwmon/hwmon0/device</div>
<div>[root@localhost device]# ls</div>
<div>beep_enable&nbsp; fan7_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in13_min&nbsp=
;&nbsp;&nbsp; in5_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; temp1_input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp5_max_hyst</div>
<div>bus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fan8_alarm&n=
bsp;&nbsp;&nbsp; in14_alarm&nbsp; in6_alarm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; temp1_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
temp5_source_sel</div>
<div>driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fan8_beep&nbsp;&nbsp;&nbsp;=
&nbsp; in14_beep&nbsp;&nbsp; in6_beep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; temp1_max_hyst&nbsp;&nbsp;&nbsp; temp5_type</div>
<div>fan1_alarm&nbsp;&nbsp; fan8_input&nbsp;&nbsp;&nbsp; in14_input&nbsp; i=
n6_input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp1_source_sel&n=
bsp; temp6_alarm</div>
<div>fan1_beep&nbsp;&nbsp;&nbsp; fan8_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in1=
4_max&nbsp;&nbsp;&nbsp; in6_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; temp1_type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp6=
_beep</div>
<div>fan1_input&nbsp;&nbsp; hwmon:hwmon0&nbsp; in14_min&nbsp;&nbsp;&nbsp; i=
n6_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp2_al=
arm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp6_crit</div>
<div>fan1_min&nbsp;&nbsp;&nbsp;&nbsp; in0_alarm&nbsp;&nbsp;&nbsp;&nbsp; in1=
_alarm&nbsp;&nbsp; in7_alarm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; temp2_beep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp6_crit_hyst</div=
>
<div>fan2_alarm&nbsp;&nbsp; in0_beep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in1_beep=
&nbsp;&nbsp;&nbsp; in7_beep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; temp2_crit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp6_input</di=
v>
<div>fan2_beep&nbsp;&nbsp;&nbsp; in0_input&nbsp;&nbsp;&nbsp;&nbsp; in1_inpu=
t&nbsp;&nbsp; in7_input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tem=
p2_crit_hyst&nbsp;&nbsp; temp6_max</div>
<div>fan2_input&nbsp;&nbsp; in0_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in1=
_max&nbsp;&nbsp;&nbsp;&nbsp; in7_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; temp2_input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp6=
_max_hyst</div>
<div>fan2_min&nbsp;&nbsp;&nbsp;&nbsp; in0_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; in1_min&nbsp;&nbsp;&nbsp;&nbsp; in7_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp2_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; temp6_source_sel</div>
<div>fan3_alarm&nbsp;&nbsp; in10_alarm&nbsp;&nbsp;&nbsp; in2_alarm&nbsp;&nb=
sp; in8_alarm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp2_max_hys=
t&nbsp;&nbsp;&nbsp; temp6_type</div>
<div>fan3_beep&nbsp;&nbsp;&nbsp; in10_beep&nbsp;&nbsp;&nbsp;&nbsp; in2_beep=
&nbsp;&nbsp;&nbsp; in8_beep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; temp2_source_sel&nbsp; temp7_alarm</div>
<div>fan3_input&nbsp;&nbsp; in10_input&nbsp;&nbsp;&nbsp; in2_input&nbsp;&nb=
sp; in8_input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp2_type&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp7_beep</div>
<div>fan3_min&nbsp;&nbsp;&nbsp;&nbsp; in10_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; in2_max&nbsp;&nbsp;&nbsp;&nbsp; in8_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; temp3_alarm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
temp7_crit</div>
<div>fan4_alarm&nbsp;&nbsp; in10_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in2_min&=
nbsp;&nbsp;&nbsp;&nbsp; in8_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; temp3_beep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp7=
_crit_hyst</div>
<div>fan4_beep&nbsp;&nbsp;&nbsp; in11_alarm&nbsp;&nbsp;&nbsp; in3_alarm&nbs=
p;&nbsp; in9_alarm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp3_cr=
it&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp7_input</div>
<div>fan4_input&nbsp;&nbsp; in11_beep&nbsp;&nbsp;&nbsp;&nbsp; in3_beep&nbsp=
;&nbsp;&nbsp; in9_beep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; temp3_crit_hyst&nbsp;&nbsp; temp7_max</div>
<div>fan4_min&nbsp;&nbsp;&nbsp;&nbsp; in11_input&nbsp;&nbsp;&nbsp; in3_inpu=
t&nbsp;&nbsp; in9_input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tem=
p3_input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp7_max_hyst</div>
<div>fan5_alarm&nbsp;&nbsp; in11_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in3_max&=
nbsp;&nbsp;&nbsp;&nbsp; in9_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; temp3_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
temp7_type</div>
<div>fan5_beep&nbsp;&nbsp;&nbsp; in11_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in3=
_min&nbsp;&nbsp;&nbsp;&nbsp; in9_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; temp3_max_hyst&nbsp;&nbsp;&nbsp; temp8_alarm</div>
<div>fan5_input&nbsp;&nbsp; in12_alarm&nbsp;&nbsp;&nbsp; in4_alarm&nbsp;&nb=
sp; intrusion0_alarm&nbsp; temp3_source_sel&nbsp; temp8_beep</div>
<div>fan5_min&nbsp;&nbsp;&nbsp;&nbsp; in12_beep&nbsp;&nbsp;&nbsp;&nbsp; in4=
_beep&nbsp;&nbsp;&nbsp; intrusion0_beep&nbsp;&nbsp; temp3_type&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp8_crit</div>
<div>fan6_alarm&nbsp;&nbsp; in12_input&nbsp;&nbsp;&nbsp; in4_input&nbsp;&nb=
sp; name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; temp4_source_sel&nbsp; temp8_crit_hyst</div>
<div>fan6_beep&nbsp;&nbsp;&nbsp; in12_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in4=
_max&nbsp;&nbsp;&nbsp;&nbsp; power&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp5_alarm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; temp8_input</div>
<div>fan6_input&nbsp;&nbsp; in12_min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in4_min&=
nbsp;&nbsp;&nbsp;&nbsp; subsystem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; temp5_beep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp8_max</div>
<div>fan6_min&nbsp;&nbsp;&nbsp;&nbsp; in13_alarm&nbsp;&nbsp;&nbsp; in5_alar=
m&nbsp;&nbsp; temp1_alarm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp5_crit&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp8_max_hyst</div>
<div>fan7_alarm&nbsp;&nbsp; in13_beep&nbsp;&nbsp;&nbsp;&nbsp; in5_beep&nbsp=
;&nbsp;&nbsp; temp1_beep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp5_cr=
it_hyst&nbsp;&nbsp; temp8_type</div>
<div>fan7_beep&nbsp;&nbsp;&nbsp; in13_input&nbsp;&nbsp;&nbsp; in5_input&nbs=
p;&nbsp; temp1_crit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp5_input&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uevent</div>
<div>fan7_input&nbsp;&nbsp; in13_max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in5_max&=
nbsp;&nbsp;&nbsp;&nbsp; temp1_crit_hyst&nbsp;&nbsp; temp5_max</div>
<div>[root@localhost device]# sensors</div>
<div>w83795g-i2c-0-2f</div>
<div>Adapter: SMBus PIIX4 adapter at 0b00</div>
<div>&nbsp;</div>
<div>[root@localhost device]# uname -r</div>
<div>2.6.18-194.el5</div>
<div>[root@localhost device]# uname -a</div>
<div>Linux localhost.localdomain 2.6.18-194.el5 #1 SMP Fri Apr 2 14:58:14 E=
DT 2010 x86_64 x86_64 x86_64 GNU/Linux</div>
<div>[root@localhost device]# cat fan1_input</div>
<div>7758</div>
<div>[root@localhost device]# cat in0_input</div>
<div>988</div>
<div>[root@localhost device]# cat temp1_input</div>
<div>34500</div>
<div>[root@localhost device]# rpm -q lm_sensors</div>
<div>lm_sensors-2.10.7-9.el5</div>
<div>&nbsp;</div>
</span></font>
</body>
</html>

--_000_77E104072DACA94993E7A23504E0C29F0559E9ROCMXUS22csmyharr_--


--===============2889281146625041524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2889281146625041524==--

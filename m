From: Gary Rickert <garyrickert@yahoo.com>
Date: Thu, 12 Mar 2009 15:54:26 +0000
Subject: [lm-sensors] What temps are real.
Message-Id: <600557.39269.qm@web65614.mail.ac4.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1339152783909718002=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============1339152783909718002==
Content-Type: multipart/alternative; boundary="0-883229192-1236873266=:39269"


--0-883229192-1236873266=:39269
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I have spent many long hours getting ln-sensors set up, and it appears to w=
orking OK, lower fan noise and lower temps except I am concerned about what=
 is real. Take a look at the following and I think you will see what I mean=
, Also, none of this agrees with what I see in the bios.
# cat rc.local
#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.

#From sensors-detect
#To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom

modprobe w83627hf init=3D0 #Added to test if updates are turned off by lm_s=
ensors

# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----
echo 58:30:38:28:27 > /proc/acpi/thermal_zone/THRM/trip_points
cat /proc/acpi/thermal_zone/THRM/trip_points >> /var/log/messages
touch /var/lock/subsys/local
/usr/sbin/fancontrol &> /var/log/fancontrol.log &
[root@p-f-a rc.d]# cat /proc/acpi/thermal_zone/THRM/trip_points
critical (S5):=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 58 C
passive:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 38 C: tc1=3D4 tc2=
=3D3 tsp=3D60 devices=3D0xdbc89338=20
active[0]:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 28 C: devices=3D0xdbc8=
9dec=20
[root@p-f-a rc.d]# sensors
w83697hf-isa-0290
Adapter: ISA adapter
VCore:=A0=A0=A0=A0 +1.66 V=A0 (min =3D=A0 +1.58 V, max =3D=A0 +1.74 V)=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
+3.3V:=A0=A0=A0=A0 +3.31 V=A0 (min =3D=A0 +3.15 V, max =3D=A0 +3.47 V)=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
+5V:=A0=A0=A0=A0=A0=A0 +4.95 V=A0 (min =3D=A0 +4.68 V, max =3D=A0 +5.16 V)=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
+12V:=A0=A0=A0=A0 +11.00 V=A0 (min =3D=A0 +9.91 V, max =3D +12.10 V)=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
-12V:=A0=A0=A0=A0 -11.71 V=A0 (min =3D -13.12 V, max =3D -10.69 V)=A0=A0=A0=
=A0=A0=A0 ALARM=A0=20
-5V:=A0=A0=A0=A0=A0=A0 -5.10 V=A0 (min =3D=A0 -5.35 V, max =3D=A0 -5.10 V)=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
V5SB:=A0=A0=A0=A0=A0 +5.40 V=A0 (min =3D=A0 +5.13 V, max =3D=A0 +5.67 V)=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
VBat:=A0=A0=A0=A0=A0 +3.23 V=A0 (min =3D=A0 +2.61 V, max =3D=A0 +3.90 V)=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Case Fan: 2480 RPM=A0 (min =3D 1328 RPM, div =3D 8)=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
CPU Fan:=A0 2860 RPM=A0 (min =3D 2596 RPM, div =3D 8)=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
Case Temp:=A0=A0 +25=B0C=A0 (high =3D=A0=A0 +40=B0C, hyst =3D=A0=A0 +37=B0C=
)=A0=A0 sensor =3D thermistor=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
CPU Temp:=A0 +30.5=B0C=A0 (high =3D=A0=A0 +65=B0C, hyst =3D=A0=A0 +32=B0C)=
=A0=A0 sensor =3D diode=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
alarms:=A0=A0=20
beep_enable:
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Sound alarm enabled

[root@p-f-a rc.d]# gedit rc.local
[root@p-f-a rc.d]# cat /var/log/fancontrol.log
Loading configuration from /etc/fancontrol ...

Common settings:
=A0 INTERVAL=3D15

Settings for 9191-0290/pwm2:
=A0 Depends on 9191-0290/temp2_input
=A0 Controls 9191-0290/fan2_input
=A0 MINTEMP=3D15
=A0 MAXTEMP=3D55
=A0 MINSTART=3D90
=A0 MINSTOP=3D85
=A0 MINPWM=3D0
=A0 MAXPWM=3D255

Settings for 9191-0290/pwm1:
=A0 Depends on 9191-0290/temp1_input
=A0 Controls 9191-0290/fan1_input
=A0 MINTEMP=3D0
=A0 MAXTEMP=3D60
=A0 MINSTART=3D80
=A0 MINSTOP=3D75
=A0 MINPWM=3D0
=A0 MAXPWM=3D255

Enabling PWM on fans...
Starting automatic fan control...

=0A=0A=0A      
--0-883229192-1236873266=:39269
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">I have spent many long hours getting ln-senso=
rs set up, and it appears to working OK, lower fan noise and lower temps ex=
cept I am concerned about what is real. Take a look at the following and I =
think you will see what I mean, Also, none of this agrees with what I see i=
n the bios.<br># cat rc.local<br>#!/bin/sh<br>#<br># This script will be ex=
ecuted *after* all the other init scripts.<br># You can put your own initia=
lization stuff in here if you don't<br># want to do the full Sys V style in=
it stuff.<br><br>#From sensors-detect<br>#To load everything that is needed=
, add this to some /etc/rc* file:<br><br>#----cut here----<br># I2C adapter=
 drivers<br>modprobe i2c-viapro<br>modprobe i2c-isa<br># I2C chip drivers<b=
r>modprobe eeprom<br><br>modprobe w83627hf init=3D0 #Added to test if updat=
es are turned off by lm_sensors<br><br># sleep 2 # optional<br>/usr/bin/sen=
sors
 -s # recommended<br>#----cut here----<br>echo 58:30:38:28:27 &gt; /proc/ac=
pi/thermal_zone/THRM/trip_points<br>cat /proc/acpi/thermal_zone/THRM/trip_p=
oints &gt;&gt; /var/log/messages<br>touch /var/lock/subsys/local<br>/usr/sb=
in/fancontrol &amp;&gt; /var/log/fancontrol.log &amp;<br>[root@p-f-a rc.d]#=
 cat /proc/acpi/thermal_zone/THRM/trip_points<br>critical (S5):&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 58 C<br>passive:&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 38 C: tc1=3D4 tc2=3D3 tsp=3D60 devices=3D0xdbc89338 <br>active[=
0]:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 28 C: devices=3D0xdbc89dec <br>[root@p-f-a rc.d]# sensors<br>w=
83697hf-isa-0290<br>Adapter: ISA adapter<br>VCore:&nbsp;&nbsp;&nbsp;&nbsp; =
+1.66 V&nbsp; (min =3D&nbsp; +1.58 V, max =3D&nbsp; +1.74 V)&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <br>+3.3V:&nbsp;&nbsp;&nbsp;&nbsp; +3.31 V&nbsp; (min =3D&nbsp; +3.15 V, m=
ax =3D&nbsp; +3.47 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; <br>+5V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.95=
 V&nbsp; (min =3D&nbsp; +4.68 V, max =3D&nbsp; +5.16 V)&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>+12V:&nbsp;&=
nbsp;&nbsp;&nbsp; +11.00 V&nbsp; (min =3D&nbsp; +9.91 V, max =3D +12.10 V)&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; <br>-12V:&nbsp;&nbsp;&nbsp;&nbsp; -11.71 V&nbsp; (min =3D -13.12 V, max =
=3D -10.69 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALARM&nbsp; <br>-5V:&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -5.10 V&nbsp; (min =3D&nbsp; -5.35 V, max =
=3D&nbsp; -5.10 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; <br>V5SB:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +5.40 V&nbsp;=
 (min =3D&nbsp; +5.13 V, max =3D&nbsp; +5.67
 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <br>VBat:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.23 V&nbsp; (min =3D&nbsp;=
 +2.61 V, max =3D&nbsp; +3.90 V)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>Case Fan: 2480 RPM&nbsp; (min =3D 1=
328 RPM, div =3D 8)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>CPU Fa=
n:&nbsp; 2860 RPM&nbsp; (min =3D 2596 RPM, div =3D 8)&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; <br>Case Temp:&nbsp;&nbsp; +25=B0C&nbsp; (high =3D&=
nbsp;&nbsp; +40=B0C, hyst =3D&nbsp;&nbsp; +37=B0C)&nbsp;&nbsp; sensor =3D t=
hermistor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>C=
PU Temp:&nbsp; +30.5=B0C&nbsp; (high =3D&nbsp;&nbsp; +65=B0C, hyst =3D&nbsp=
;&nbsp; +32=B0C)&nbsp;&nbsp; sensor =3D
 diode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>alar=
ms:&nbsp;&nbsp; <br>beep_enable:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Sound alarm enabled<br><br>[root@p-f-a rc.d]# gedit rc.loca=
l<br>[root@p-f-a rc.d]# cat /var/log/fancontrol.log<br>Loading configuratio=
n from /etc/fancontrol ...<br><br>Common settings:<br>&nbsp; INTERVAL=3D15<=
br><br>Settings for 9191-0290/pwm2:<br>&nbsp; Depends on 9191-0290/temp2_in=
put<br>&nbsp; Controls 9191-0290/fan2_input<br>&nbsp; MINTEMP=3D15<br>&nbsp=
; MAXTEMP=3D55<br>&nbsp; MINSTART=3D90<br>&nbsp; MINSTOP=3D85<br>&nbsp; MIN=
PWM=3D0<br>&nbsp; MAXPWM=3D255<br><br>Settings for 9191-0290/pwm1:<br>&nbsp=
; Depends on 9191-0290/temp1_input<br>&nbsp; Controls 9191-0290/fan1_input<=
br>&nbsp; MINTEMP=3D0<br>&nbsp; MAXTEMP=3D60<br>&nbsp; MINSTART=3D80<br>&nb=
sp; MINSTOP=3D75<br>&nbsp; MINPWM=3D0<br>&nbsp; MAXPWM=3D255<br><br>Enablin=
g PWM on fans...<br>Starting automatic fan control...<br><br></td></tr></ta=
ble><br>=0A=0A      
--0-883229192-1236873266=:39269--


--===============1339152783909718002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1339152783909718002==--

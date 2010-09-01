From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Wed, 01 Sep 2010 14:58:47 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <597875.71733.qm@web50003.mail.re2.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8600986647103373856=="
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============8600986647103373856==
Content-Type: multipart/alternative; boundary="0-1344184909-1283353127=:71733"

--0-1344184909-1283353127=:71733
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>The current text is quite absolute ("Copy prog/init/lm_sensors.init to =0A=
>/etc/init.d/lm_sensors")=0A>and really invites users to overwrite the dist=
ribution specific scripts.=0A=A0=0AI really did that. See:=0Amahmood@localh=
ost:~$cat /etc/init.d/lm-sensors=0A#!/bin/sh=0A#=0A# chkconfig: - 26 74=0A#=
 description: sensors is used for monitoring motherboard sensor values.=0A#=
 config: /etc/sysconfig/lm_sensors=0A#=0A#=A0=A0=A0 This program is free so=
ftware; you can redistribute it and/or modify=0A#=A0=A0=A0 it under the ter=
ms of the GNU General Public License as published by=0A#=A0=A0=A0 the Free =
Software Foundation; either version 2 of the License, or=0A#=A0=A0=A0 (at y=
our option) any later version.=0A#=0A#=A0=A0=A0 This program is distributed=
 in the hope that it will be useful,=0A#=A0=A0=A0 but WITHOUT ANY WARRANTY;=
 without even the implied warranty of=0A#=A0=A0=A0 MERCHANTABILITY or FITNE=
SS FOR A PARTICULAR PURPOSE.=A0 See the=0A#=A0=A0=A0 GNU General Public Lic=
ense for more details.=0A#=0A#=A0=A0=A0 You should have received a copy of =
the GNU General Public License=0A#=A0=A0=A0 along with this program; if not=
, write to the Free Software=0A#=A0=A0=A0 Foundation, Inc., 51 Franklin Str=
eet, Fifth Floor, Boston,=0A#=A0=A0=A0 MA 02110-1301 USA.=0A# See also the =
lm_sensors homepage at:=0A#=A0=A0=A0=A0 http://www.lm-sensors.org=0A# It us=
es a config file /etc/sysconfig/lm_sensors that contains the modules=0A# to=
 be loaded/unloaded. That file is sourced into this one.=0A# The format of =
this file is a shell script that simply defines variables:=0A# HWMON_MODULE=
S for hardware monitoring driver modules, and optionally=0A# BUS_MODULES fo=
r any required bus driver module (for example for I2C or SPI).=0APSENSORS=
=3D/usr/local/bin/sensors=0Aif [ ! -x $PSENSORS ]; then=0A=A0=A0=A0=A0=A0=
=A0=A0 PSENSORS=3D/usr/bin/sensors=0Afi=0A# Source function library.=0A. /e=
tc/init.d/functions=0ARETVAL=3D0=0Aprog=3D"lm_sensors"=0A# This functions c=
hecks if sensor support is compiled into the kernel, if=0A# sensors are con=
figured, and loads the config file=0Acheck_sensors() {=0A=A0=A0=A0=A0=A0=A0=
=A0 CONFIG=3D/etc/sysconfig/lm_sensors=0A=A0=A0=A0=A0=A0=A0=A0 if ! [ -r "$=
CONFIG" ] || ! grep '^HWMON_MODULES' $CONFIG >/dev/null =0A2>&1; then=0A=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo -n "$1 $prog: not configure=
d, run sensors-detect"=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo=
_warning=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo=0A=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit 6=0A=A0=A0=A0=A0=A0=A0=A0 fi=0A=
=A0=A0=A0=A0=A0=A0=A0 # Load config file=0A=A0=A0=A0=A0=A0=A0=A0 . "$CONFIG=
"=0A}=0Astart() {=0A=A0=A0=A0=A0=A0=A0=A0 check_sensors "Starting"=0A=A0=A0=
=A0=A0=A0=A0=A0 echo -n "Starting $prog: loading module "=0A=A0=A0=A0=A0=A0=
=A0=A0 for module in $BUS_MODULES $HWMON_MODULES ; do=0A=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo -n "${module} "=0A=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 /sbin/modprobe $module >/dev/null 2>&1=0A=A0=A0=A0=A0=
=A0=A0=A0 done=0A=A0=A0=A0=A0=A0=A0=A0 $PSENSORS -s=0A=A0=A0=A0=A0=A0=A0=A0=
 RETVAL=3D$?=0A=A0=A0=A0=A0=A0=A0=A0 if [ $RETVAL -eq 0 ] && touch /var/loc=
k/subsys/lm_sensors ; then=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
echo_success=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo=0A=A0=A0=
=A0=A0=A0=A0=A0 else=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo_f=
ailure=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo=0A=A0=A0=A0=A0=
=A0=A0=A0 fi=0A}=0Astop() {=0A=A0=A0=A0=A0=A0=A0=A0 check_sensors "Stopping=
"=0A=A0=A0=A0=A0=A0=A0=A0 echo -n "Stopping $prog: "=0A=A0=A0=A0=A0=A0=A0=
=A0 for module in $HWMON_MODULES $BUS_MODULES ; do=0A=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 /sbin/modprobe -r $module >/dev/null 2>&1=0A=A0=A0=
=A0=A0=A0=A0=A0 done=0A=A0=A0=A0=A0=A0=A0=A0 RETVAL=3D$?=0A=A0=A0=A0=A0=A0=
=A0=A0 if [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/lm_sensors ; then=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo_success=0A=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo=0A=A0=A0=A0=A0=A0=A0=A0 else=0A=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo_failure=0A=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo=0A=A0=A0=A0=A0=A0=A0=A0 fi=0A}=0Adostat=
us() {=0A=A0=A0=A0=A0=A0=A0=A0 $PSENSORS=0A=A0=A0=A0=A0=A0=A0=A0 RETVAL=3D$=
?=0A=A0=A0=A0=A0=A0=A0=A0 if [ $RETVAL -ne 0 ]; then=0A=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 RETVAL=3D3=0A=A0=A0=A0=A0=A0=A0=A0 fi=0A}=0Ares=
tart() {=0A=A0=A0=A0=A0=A0=A0=A0 stop=0A=A0=A0=A0=A0=A0=A0=A0 start=0A}=0Ac=
ondrestart() {=0A=A0=A0=A0=A0=A0=A0=A0 [ -e /var/lock/subsys/lm_sensors ] &=
& restart || :=0A}=0A# See how we were called.=0Acase "$1" in=0A=A0 start)=
=0A=A0=A0=A0=A0=A0=A0=A0 start=0A=A0=A0=A0=A0=A0=A0=A0 ;;=0A=A0 stop)=0A=A0=
=A0=A0=A0=A0=A0=A0 stop=0A=A0=A0=A0=A0=A0=A0=A0 ;;=0A=A0 status)=0A=A0=A0=
=A0=A0=A0=A0=A0 dostatus=0A=A0=A0=A0=A0=A0=A0=A0 ;;=0A=A0 restart|reload)=
=0A=A0=A0=A0=A0=A0=A0=A0 restart=0A=A0=A0=A0=A0=A0=A0=A0 ;;=0A=A0 condresta=
rt)=0A=A0=A0=A0=A0=A0=A0=A0 condrestart=0A=A0=A0=A0=A0=A0=A0=A0 ;;=0A=A0 *)=
=0A=A0=A0=A0=A0=A0=A0=A0 echo "Usage: $0 {start|stop|status|restart|reload|=
condrestart}"=0A=A0=A0=A0=A0=A0=A0=A0 exit 3=0Aesac=0Aexit $RETVAL=0A=0ADo =
you confirm that? What should I do in order to remove lm-sensor and reinsta=
ll =0Ait again?=0A=A0=0A// Naderan *Mahmood;=0A=0A=0A=0A=0A________________=
________________=0AFrom: Guenter Roeck <guenter.roeck@ericsson.com>=0ATo: J=
ean Delvare <khali@linux-fr.org>=0ACc: Mahmood Naderan <nt_mahmood@yahoo.co=
m>; lm-sensors =0A<lm-sensors@lm-sensors.org>=0ASent: Wed, September 1, 201=
0 7:02:25 PM=0ASubject: Re: [lm-sensors] lmsensors doesn't detect core-i7 s=
ensors=0A=0AOn Wed, Sep 01, 2010 at 09:56:01AM -0400, Jean Delvare wrote:=
=0A> On Wed, 1 Sep 2010 06:26:34 -0700, Guenter Roeck wrote:=0A> > On Wed, =
Sep 01, 2010 at 04:16:41AM -0400, Mahmood Naderan wrote:=0A> > > >sudo /etc=
/init.d/lm_sensors restart=0A> > > =0A> > > mahmood@localhost:~$<mailto:mah=
mood@localhost:~$> sudo =0A>/etc/init.d/lm-sensors restart=0A> > > .: 39: C=
an't open /etc/init.d/functions=0A> > > =0A> > > Note there is no lm_sensor=
s. I have lm-sensors=0A> > > =0A> > =0A> > I tried /etc/init.d/lm-sensors o=
n a lucid (10.04) system and it works for me. =0A>It looks like=0A> > you o=
verwrote the original version of /etc/init.d/lm-sensors with =0A>prog/init.=
d/lm_sensors.=0A> > That won't work - prog/init.d/lm_sensors does not work =
with lucid. You'll =0A>need to reinstall=0A> > the original version of /etc=
/init.d/lm-sensors and try again.=0A> =0A> I proposed once to delete these =
initialization scripts from our=0A> repository as they are quite distributi=
on specific, but the few votes=0A> were not in my favor.=0A> =0AHow about s=
ome kind of warning, or at least use different wording in =0Asensors-detect=
 ?=0A=0AThe current text is quite absolute ("Copy prog/init/lm_sensors.init=
 to =0A/etc/init.d/lm_sensors")=0Aand really invites users to overwrite the=
 distribution specific scripts.=0A=0AGuenter=0A=0A=0A=0A      
--0-1344184909-1283353127=:71733
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:tahoma, new york, times, serif;font-size=
:12pt"><P>&gt;The current text is quite absolute ("Copy prog/init/lm_sensor=
s.init to /etc/init.d/lm_sensors")<BR>&gt;and really invites users to overw=
rite the distribution specific scripts.</P>=0A<P>&nbsp;</P>=0A<P>I really d=
id that. See:</P>=0A<P><A href=3D"mailto:mahmood@localhost:~$"><FONT size=
=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">mahmood@l=
ocalhost:~$</FONT></A><FONT size=3D2 face=3D"Courier New, courier, monaco, =
monospace, sans-serif"> cat /etc/init.d/lm-sensors<BR>#!/bin/sh<BR>#<BR># c=
hkconfig: - 26 74<BR># description: sensors is used for monitoring motherbo=
ard sensor values.<BR># config: /etc/sysconfig/lm_sensors<BR>#<BR>#&nbsp;&n=
bsp;&nbsp; This program is free software; you can redistribute it and/or mo=
dify<BR>#&nbsp;&nbsp;&nbsp; it under the terms of the GNU General Public Li=
cense as published by<BR>#&nbsp;&nbsp;&nbsp; the Free Software Foundation; =
either version 2 of the License, or<BR>#&nbsp;&nbsp;&nbsp; (at your option)=
 any later version.<BR>#<BR>#&nbsp;&nbsp;&nbsp; This program is distributed=
 in the hope that it will be useful,<BR>#&nbsp;&nbsp;&nbsp; but WITHOUT ANY=
 WARRANTY; without even the implied warranty of<BR>#&nbsp;&nbsp;&nbsp; MERC=
HANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE.&nbsp; See the<BR>#&nbsp;&nbsp;&nbsp; GNU General=
 Public License for more details.<BR>#<BR>#&nbsp;&nbsp;&nbsp; You should ha=
ve received a copy of the GNU General Public License<BR>#&nbsp;&nbsp;&nbsp;=
 along with this program; if not, write to the Free Software<BR>#&nbsp;&nbs=
p;&nbsp; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,<BR>#&nb=
sp;&nbsp;&nbsp; MA 02110-1301 USA.</FONT></P>=0A<P><FONT size=3D2 face=3D"C=
ourier New, courier, monaco, monospace, sans-serif"># See also the lm_senso=
rs homepage at:<BR>#&nbsp;&nbsp;&nbsp;&nbsp; </FONT><A href=3D"http://www.l=
m-sensors.org"><FONT size=3D2 face=3D"Courier New, courier, monaco, monospa=
ce, sans-serif">http://www.lm-sensors.org</FONT></A></P>=0A<P><FONT size=3D=
2 face=3D"Courier New, courier, monaco, monospace, sans-serif"># It uses a =
config file /etc/sysconfig/lm_sensors that contains the modules<BR># to be =
loaded/unloaded. That file is sourced into this one.</FONT></P>=0A<P><FONT =
size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif"># The=
 format of this file is a shell script that simply defines variables:<BR># =
HWMON_MODULES for hardware monitoring driver modules, and optionally<BR># B=
US_MODULES for any required bus driver module (for example for I2C or SPI).=
</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco, monos=
pace, sans-serif">PSENSORS=3D/usr/local/bin/sensors</FONT></P>=0A<P><FONT s=
ize=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">if [ !=
 -x $PSENSORS ]; then<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSENSOR=
S=3D/usr/bin/sensors<BR>fi</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier N=
ew, courier, monaco, monospace, sans-serif"># Source function library.<BR>.=
 /etc/init.d/functions</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, =
courier, monaco, monospace, sans-serif">RETVAL=3D0<BR>prog=3D"lm_sensors"</=
FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco, monospa=
ce, sans-serif"># This functions checks if sensor support is compiled into =
the kernel, if<BR># sensors are configured, and loads the config file<BR>ch=
eck_sensors() {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONFIG=3D/etc=
/sysconfig/lm_sensors<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ! [ =
-r "$CONFIG" ] || ! grep '^HWMON_MODULES' $CONFIG &gt;/dev/null 2&gt;&amp;1=
; then<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; echo -n "$1 $prog: not configured, run sensors-de=
tect"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; echo_warning<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo<BR>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; exit 6<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi</FONT></P>=0A=
<P><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-ser=
if">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Load config file<BR>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; . "$CONFIG"<BR>}</FONT></P>=0A<P><FONT=
 size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">star=
t() {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check_sensors "Starting=
"</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco, mono=
space, sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo -n "Star=
ting $prog: loading module "</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier=
 New, courier, monaco, monospace, sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; for module in $BUS_MODULES $HWMON_MODULES ; do<BR>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; echo -n "${module} "<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/modprobe $module &gt;/de=
v/null 2&gt;&amp;1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; done<BR>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $PSENSORS -s</FONT></P>=0A<P><FONT=
 size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETVAL=3D$?<BR>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if [ $RETVAL -eq 0 ] &amp;&amp; touch /var/lock/subsy=
s/lm_sensors ; then<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo_success<BR>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo=
_failure<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; echo<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fi<BR>}</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, mo=
naco, monospace, sans-serif">stop() {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; check_sensors "Stopping"</FONT></P>=0A<P><FONT size=3D2 face=3D"Co=
urier New, courier, monaco, monospace, sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; echo -n "Stopping $prog: "</FONT></P>=0A<P><FONT size=3D=
2 face=3D"Courier New, courier, monaco, monospace, sans-serif">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for module in $HWMON_MODULES $BUS_MODULES ; =
do<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /sbin/modprobe -r $module &gt;/dev/null 2&gt;&amp;1<B=
R>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; done</FONT></P>=0A<P><FONT siz=
e=3D2 face=3D"Courier New, courier, monaco, monospace, sans-serif">&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETVAL=3D$?<BR>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if [ $RETVAL -eq 0 ] &amp;&amp; rm -f /var/lock/subsys/lm=
_sensors ; then<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo_success<BR>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo<BR>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo_fai=
lure<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; echo<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fi<BR>}</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco=
, monospace, sans-serif">dostatus() {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; $PSENSORS<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETVAL=3D$=
?<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ $RETVAL -ne 0 ]; then<=
BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; RETVAL=3D3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 fi<BR>}</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monac=
o, monospace, sans-serif">restart() {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; stop<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start<BR>}</FON=
T></P>=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace,=
 sans-serif">condrestart() {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
[ -e /var/lock/subsys/lm_sensors ] &amp;&amp; restart || :<BR>}</FONT></P>=
=0A<P><FONT size=3D2 face=3D"Courier New, courier, monaco, monospace, sans-=
serif"># See how we were called.<BR>case "$1" in<BR>&nbsp; start)<BR>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ;;<BR>&nbsp; stop)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; stop<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;;<BR>&nbsp; status)=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dostatus<BR>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ;;<BR>&nbsp; restart|reload)<BR>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; restart<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ;;<BR>&nbsp; condrestart)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; condrestart<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;;<BR>&nbsp; *=
)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo "Usage: $0 {start|stop=
|status|restart|reload|condrestart}"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; exit 3<BR>esac</FONT></P>=0A<P><FONT size=3D2 face=3D"Courier New, =
courier, monaco, monospace, sans-serif">exit $RETVAL</FONT><BR></P>=0A<P>Do=
 you confirm that? What should I do in order to remove lm-sensor and reinst=
all it again?<BR>&nbsp;</P>=0A<DIV>=0A<DIV><FONT style=3D"BACKGROUND-COLOR:=
 #ffffff" color=3D#0080ff size=3D2 face=3D"arial, helvetica, sans-serif"><S=
TRONG>// Naderan *Mahmood;</STRONG></FONT></DIV></DIV>=0A<DIV><BR></DIV>=0A=
<DIV style=3D"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZE: 12pt"=
><BR>=0A<DIV style=3D"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZ=
E: 12pt"><FONT size=3D2 face=3DTahoma>=0A<HR SIZE=3D1>=0A<B><SPAN style=3D"=
FONT-WEIGHT: bold">From:</SPAN></B> Guenter Roeck &lt;guenter.roeck@ericsso=
n.com&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">To:</SPAN></B> Jean Delva=
re &lt;khali@linux-fr.org&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Cc:</=
SPAN></B> Mahmood Naderan &lt;nt_mahmood@yahoo.com&gt;; lm-sensors &lt;lm-s=
ensors@lm-sensors.org&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Sent:</SP=
AN></B> Wed, September 1, 2010 7:02:25 PM<BR><B><SPAN style=3D"FONT-WEIGHT:=
 bold">Subject:</SPAN></B> Re: [lm-sensors] lmsensors doesn't detect core-i=
7 sensors<BR></FONT><BR>On Wed, Sep 01, 2010 at 09:56:01AM -0400, Jean Delv=
are wrote:<BR>&gt; On Wed, 1 Sep 2010 06:26:34 -0700, Guenter Roeck wrote:<=
BR>&gt; &gt; On Wed, Sep 01, 2010 at 04:16:41AM -0400, Mahmood Naderan wrot=
e:<BR>&gt; &gt; &gt; &gt;sudo /etc/init.d/lm_sensors restart<BR>&gt; &gt; &=
gt; <BR>&gt; &gt; &gt; mahmood@localhost:~$&lt;mailto:mahmood@localhost:~$&=
gt; sudo /etc/init.d/lm-sensors restart<BR>&gt; &gt; &gt; .:
 39: Can't open /etc/init.d/functions<BR>&gt; &gt; &gt; <BR>&gt; &gt; &gt; =
Note there is no lm_sensors. I have lm-sensors<BR>&gt; &gt; &gt; <BR>&gt; &=
gt; <BR>&gt; &gt; I tried /etc/init.d/lm-sensors on a lucid (10.04) system =
and it works for me. It looks like<BR>&gt; &gt; you overwrote the original =
version of /etc/init.d/lm-sensors with prog/init.d/lm_sensors.<BR>&gt; &gt;=
 That won't work - prog/init.d/lm_sensors does not work with lucid. You'll =
need to reinstall<BR>&gt; &gt; the original version of /etc/init.d/lm-senso=
rs and try again.<BR>&gt; <BR>&gt; I proposed once to delete these initiali=
zation scripts from our<BR>&gt; repository as they are quite distribution s=
pecific, but the few votes<BR>&gt; were not in my favor.<BR>&gt; <BR>How ab=
out some kind of warning, or at least use different wording in sensors-dete=
ct ?<BR><BR>The current text is quite absolute ("Copy prog/init/lm_sensors.=
init to /etc/init.d/lm_sensors")<BR>and really invites users to
 overwrite the distribution specific scripts.<BR><BR>Guenter<BR></DIV></DIV=
></div><br>=0A=0A      </body></html>
--0-1344184909-1283353127=:71733--


--===============8600986647103373856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8600986647103373856==--

From: JAMES SCOTT <skoona@verizon.net>
Date: Fri, 19 Oct 2007 19:00:53 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'
Message-Id: <309762.30995.qm@web84115.mail.mud.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2467102626565446246=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
To: lm-sensors@vger.kernel.org

--===============2467102626565446246==
Content-Type: multipart/alternative; boundary="0-611729638-1192820453=:30995"

--0-611729638-1192820453=:30995
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hans,=0A=0AThat makes sense to me, I will try it tonight.  thanks.=0A=0AJam=
es,=0A=0A----- Original Message ----=0AFrom: Hans de Goede <j.w.r.degoede@h=
hs.nl>=0ATo: James Scott Jr <skoona@verizon.net>=0ACc: lm-sensors@lm-sensor=
s.org=0ASent: Friday, October 19, 2007 2:33:46 PM=0ASubject: Re: [lm-sensor=
s] ABIT IP35 Pro mainboard wrong values from 'sensors'=0A=0AJames Scott Jr =
wrote:=0A>     Folks,=0A> =0A> I have a system with an Intel Q6600 quad cor=
e on a ABit IP35 Pro=0A> mainboard, using Fedora 7 x64, and lm_sensors-2.10=
.4-1.fc7.  The output=0A> from sensors is wrong.  Is there a preformatted c=
onfig file for these=0A> mainboard somewhere that I can find?  Or can you g=
ive me a hit on what I=0A> need to know in order to create/adjust one?=0A> =
=0A=0AAbit usually does not use the sensors of the super io chip (which the=
 w83627dhg =0Ais), instead they use their own solution called uguru. There =
is a driver for =0Athis, but the uguru isn't detected by sensors-detect.=0A=
=0ATry modprobe abituguru3, and then try running sensors again.=0A=0AThe ab=
ituguru3 driver is only available in kernel 2.6.23 and higher, to install =
=0Athis kernel for F-7 do:=0Ayum update --enable-repo=3Dupdates-testing ker=
nel=0A=0AAfter rebooting into the new kernel do=0Amodprobe abituguru3=0Asen=
sors=0A=0A=0ARegards,=0A=0AHans=0A=0A=0A=0A=0A
--0-611729638-1192820453=:30995
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 10pt;">Hans,<br><br>That makes sense to me, I will try it =
tonight.&nbsp; thanks.<br><br>James,<br><br><div style=3D"font-family: time=
s new roman,new york,times,serif; font-size: 12pt;">----- Original Message =
----<br>From: Hans de Goede &lt;j.w.r.degoede@hhs.nl&gt;<br>To: James Scott=
 Jr &lt;skoona@verizon.net&gt;<br>Cc: lm-sensors@lm-sensors.org<br>Sent: Fr=
iday, October 19, 2007 2:33:46 PM<br>Subject: Re: [lm-sensors] ABIT IP35 Pr=
o mainboard wrong values from 'sensors'<br><br><div>James Scott Jr wrote:<b=
r>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Folks,<br>&gt; <br>&gt; I have a system with=
 an Intel Q6600 quad core on a ABit IP35 Pro<br>&gt; mainboard, using Fedor=
a 7 x64, and lm_sensors-2.10.4-1.fc7.&nbsp;&nbsp;The output<br>&gt; from
 sensors is wrong.&nbsp;&nbsp;Is there a preformatted config file for these=
<br>&gt; mainboard somewhere that I can find?&nbsp;&nbsp;Or can you give me=
 a hit on what I<br>&gt; need to know in order to create/adjust one?<br>&gt=
; <br><br>Abit usually does not use the sensors of the super io chip (which=
 the w83627dhg <br>is), instead they use their own solution called uguru. T=
here is a driver for <br>this, but the uguru isn't detected by sensors-dete=
ct.<br><br>Try modprobe abituguru3, and then try running sensors again.<br>=
<br>The abituguru3 driver is only available in kernel 2.6.23 and higher, to=
 install <br>this kernel for F-7 do:<br>yum update --enable-repo=3Dupdates-=
testing kernel<br><br>After rebooting into the new kernel do<br>modprobe ab=
ituguru3<br>sensors<br><br><br>Regards,<br><br>Hans<br></div></div><br></di=
v></div></body></html>
--0-611729638-1192820453=:30995--


--===============2467102626565446246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2467102626565446246==--

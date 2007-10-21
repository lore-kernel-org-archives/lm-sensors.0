From: JAMES SCOTT <skoona@verizon.net>
Date: Sun, 21 Oct 2007 13:35:05 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'
Message-Id: <494247.12822.qm@web84107.mail.mud.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9181717681333670109=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
To: lm-sensors@vger.kernel.org

--===============9181717681333670109==
Content-Type: multipart/alternative; boundary="0-1610294914-1192973705=:12822"

--0-1610294914-1192973705=:12822
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

=0A=0A----- Original Message ----=0AFrom: Jean Delvare <khali@linux-fr.org>=
=0ATo: James Scott Jr <skoona@verizon.net>=0ACc: Hans de Goede <j.w.r.degoe=
de@hhs.nl>; lm-sensors@lm-sensors.org=0ASent: Saturday, October 20, 2007 4:=
49:01 PM=0ASubject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values f=
rom 'sensors'=0A=0AOn Fri, 19 Oct 2007 22:53:09 -0400, James Scott Jr wrote=
:=0A> Thank you, sensor's output is now correct - coretemp's is wacked.  I=
=0A> will look into whats happening with coretemp, later.=0A> =0A> [jscott@=
vserv ~]$ sensors=0A> (...)=0A> coretemp-isa-0000=0A> Adapter: ISA adapter=
=0A> Core 0:      +54=B0C  (high =3D  +100=B0C)                   =0A> =0A>=
 coretemp-isa-0001=0A> Adapter: ISA adapter=0A> Core 1:      +51=B0C  (high=
 =3D  +100=B0C)                   =0A> =0A> coretemp-isa-0002=0A> Adapter: =
ISA adapter=0A> Core 2:      +52=B0C  (high =3D  +100=B0C)                 =
  =0A> =0A> coretemp-isa-0003=0A> Adapter: ISA adapter=0A> Core 3:      +50=
=B0C  (high =3D  +100=B0C)                   =0A> =0A=0AThe coretemp values=
 actually look alright to me.=0A=0AJean; The abituguru3... sensors output s=
howed 'CPU 40c' and coretemp... details the same CPU around '50c'.  So, I h=
ave output, it is formatted correctly.  However, I believe the reported val=
ue is wrong.  10c is a huge difference in values - which is correct?  All C=
ores are running Folding@Home at 100%, so this is a load temp and would not=
 be available if I rebooted to bios to verify.=0A=0AI did not find the core=
temp-isa-* in the sensors.conf file.  Do you know where the computes for th=
is module are setup?=0A-- =0AJean Delvare=0A=0A=0A=0A=0A
--0-1610294914-1192973705=:12822
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 10pt;"><br><br><div style=3D"font-family: times new roman,=
new york,times,serif; font-size: 12pt;">----- Original Message ----<br>From=
: Jean Delvare &lt;khali@linux-fr.org&gt;<br>To: James Scott Jr &lt;skoona@=
verizon.net&gt;<br>Cc: Hans de Goede &lt;j.w.r.degoede@hhs.nl&gt;; lm-senso=
rs@lm-sensors.org<br>Sent: Saturday, October 20, 2007 4:49:01 PM<br>Subject=
: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'<br><=
br><div>On Fri, 19 Oct 2007 22:53:09 -0400, James Scott Jr wrote:<br>&gt; T=
hank you, sensor's output is now correct - coretemp's is wacked.&nbsp;&nbsp=
;I<br>&gt; will look into whats happening with coretemp, later.<br>&gt; <br=
>&gt; [jscott@vserv ~]$ sensors<br>&gt; (...)<br>&gt;
 coretemp-isa-0000<br>&gt; Adapter: ISA adapter<br>&gt; Core 0:&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;+54=B0C&nbsp;&nbsp;(high =3D&nbsp;&nbsp;+100=B0C)&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&gt; <br>&gt; coretemp-isa-0001<br>&gt;=
 Adapter: ISA adapter<br>&gt; Core 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+5=
1=B0C&nbsp;&nbsp;(high =3D&nbsp;&nbsp;+100=B0C)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; <br>&gt; <br>&gt; coretemp-isa-0002<br>&gt; Adapter: ISA adapter<br>&=
gt; Core 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+52=B0C&nbsp;&nbsp;(high =3D=
&nbsp;&nbsp;+100=B0C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&gt; <br>&gt; co=
retemp-isa-0003<br>&gt; Adapter: ISA adapter<br>&gt; Core 3:&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;+50=B0C&nbsp;&nbsp;(high
 =3D&nbsp;&nbsp;+100=B0C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&gt; <br><br=
>The coretemp values actually look alright to me.<br><br>Jean; The abitugur=
u3... sensors output showed 'CPU 40c' and coretemp... details the same CPU =
around '50c'.&nbsp; So, I have output, it is formatted correctly.&nbsp; How=
ever, I believe the reported value is wrong.&nbsp; 10c is a huge difference=
 in values - which is correct?&nbsp; All Cores are running Folding@Home at =
100%, so this is a load temp and would not be available if I rebooted to bi=
os to verify.<br><br>I did not find the coretemp-isa-* in the sensors.conf =
file.&nbsp; Do you know where the computes for this module are setup?<br>--=
 <br>Jean Delvare<br></div></div><br></div></div></body></html>
--0-1610294914-1192973705=:12822--


--===============9181717681333670109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9181717681333670109==--

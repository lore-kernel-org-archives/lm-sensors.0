From: Dok Sander <doksander@yahoo.com>
Date: Mon, 07 Sep 2009 18:42:39 +0000
Subject: [lm-sensors] cross-compiling for mips fails
Message-Id: <801433.83353.qm@web59310.mail.re1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4422160804080948539=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4422160804080948539==
Content-Type: multipart/alternative; boundary="0-251037914-1252348959=:83353"

--0-251037914-1252348959=:83353
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to cross-compile lm-sensors for mips. I'm using eglibc 2.10.1 as=
 the main C library. I get the following error:

make: *** No rule to make target `sys/io.h', needed by `prog/dump/superio.r=
d'.=A0 Stop.

And checking the headers, sys/io.h does not exist. So this could be problem=
 of eglibc instead. Has anyone else encountered this problem?

=A0 Thanks
=0A=0A=0A      
--0-251037914-1252348959=:83353
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi,<br><br>I'm trying to cross-compile lm-sen=
sors for mips. I'm using eglibc 2.10.1 as the main C library. I get the fol=
lowing error:<br><br><span style=3D"font-style: italic;">make: *** No rule =
to make target `sys/io.h', needed by `prog/dump/superio.rd'.&nbsp; Stop.</s=
pan><br><br>And checking the headers, sys/io.h does not exist. So this coul=
d be problem of eglibc instead. Has anyone else encountered this problem?<b=
r><br>&nbsp; Thanks<br></td></tr></table><br>=0A=0A      
--0-251037914-1252348959=:83353--


--===============4422160804080948539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4422160804080948539==--

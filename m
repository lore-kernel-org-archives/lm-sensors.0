From: Kapil Dev <kapil_dev@brown.edu>
Date: Fri, 19 Jul 2013 15:28:28 +0000
Subject: [lm-sensors] Few queries about lm-sensors and core temp.c
Message-Id: <D137AD88-0DA4-4CF3-889D-862386B3C35A@brown.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3559630784626724717=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============3559630784626724717==
Content-Type: multipart/alternative; boundary="Apple-Mail=_4DC46F90-E086-4DA2-8B94-EC621393B5F4"


--Apple-Mail=_4DC46F90-E086-4DA2-8B94-EC621393B5F4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

I have a couple of queries about lm-sensors package.

1) The FAQ section in chapter-1 says that the drivers update their =
values every 1 sec. I am aware of the fact that reading the sensors more =
frequently will affect the performance as it is intrusive to CPU to read =
an MSR, but I need to read the core-temperature values at faster rate =
for a project. Would you tell me what changes I should make to read the =
sensors faster? In particular, I want to read the core temperature (I =
believe it  is done in coretemp.c through IA32_THERMAL_STATUS MSR =
register). coretemp.c seems to have "jiffy" as time stamp, if I change =
it in the coretemp.c, will it work? Or, is there any other file that =
needs to be changed during kernel-compilation?

2) Does the lm-sensor package use the correct value of Tjmax (the temp =
value at which PROCHOT signal goes high) automatically based on the =
processor brand and type? I noticed that the Tjmax =3D100C is used in =
core temp.c, but the 22nm intel processor that I am working on has Tjmax =
of 105C. Do I need to change it myself?

Thanks,
Kapil=

--Apple-Mail=_4DC46F90-E086-4DA2-8B94-EC621393B5F4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
">Hi,<div><br></div><div>I have a couple of queries about lm-sensors =
package.</div><div><br></div><div>1) The FAQ section in chapter-1 says =
that the drivers update their values every 1 sec. I am aware of the fact =
that reading the sensors more frequently will affect the performance as =
it is intrusive to CPU to read an MSR, but I need to read the =
core-temperature values at faster rate for a project. Would you tell me =
what changes I should make to read the sensors faster? In particular, I =
want to read the core temperature (I believe it &nbsp;is done in =
coretemp.c through&nbsp;<b =
id=3D"docs-internal-guid-3be99f16-f778-d2a4-cf26-c25f40eb8773"><span =
style=3D"font-size: 15px; font-family: Arial; font-weight: normal; =
vertical-align: baseline; white-space: pre-wrap; =
">IA32_THERMAL_STATUS</span></b>&nbsp;MSR register). coretemp.c seems to =
have "jiffy" as time stamp, if I change it in the coretemp.c, will it =
work? Or, is there any other file that needs to be changed during =
kernel-compilation?</div><div><br></div><div>2) Does the lm-sensor =
package use the correct value of Tjmax (the temp value at which PROCHOT =
signal goes high) automatically based on the processor brand and type? I =
noticed that the Tjmax =3D100C is used in core temp.c, but the 22nm =
intel processor that I am working on has Tjmax of 105C. Do I need to =
change it =
myself?</div><div><br></div><div>Thanks,</div><div>Kapil</div></body></htm=
l>=

--Apple-Mail=_4DC46F90-E086-4DA2-8B94-EC621393B5F4--


--===============3559630784626724717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3559630784626724717==--

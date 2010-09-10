From: Lars Ivar Igesund <larsivar@igesund.net>
Date: Fri, 10 Sep 2010 13:29:25 +0000
Subject: [lm-sensors] Lack of fan sensor output after Ubuntu upgrade
Message-Id: <201009101529.26294.larsivar@igesund.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1651458663040730891=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1651458663040730891==
Content-Type: multipart/alternative;
  boundary="Boundary-01=_2KjiM0iHmxw3TTs"
Content-Transfer-Encoding: 7bit

--Boundary-01=_2KjiM0iHmxw3TTs
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I admit to using beta software, and to the possibility that the issue is no=
t=20
in lm-sensors, but since I'm very interested in getting my issue fixed, I t=
hink=20
this list is the right place to start at least.

I upgraded to Ubuntu 10.10 beta today, and the almost immediate result is t=
hat=20
the fan has become noisy as hell.

I have a Dell XPS Studio 17 laptop, bought earlier this year. It has (among=
=20
other things) an i7 Q820 processor.

I never ran sensors before the upgrade (didn't have any fan issues there), =
so=20
I don't know if there's any actual differences in the output, but here goes.

Just running sensors give me:

acpitz-virtual-0
Adapter: Virtual device
temp1:       +26.8=C2=B0C  (crit =3D +127.0=C2=B0C)                 =20
temp2:       +61.0=C2=B0C  (crit =3D +85.0=C2=B0C) =20

Since I've little or no load on the CPU, I find the latter value unlikely h=
igh=20
(but it seems to be dropping now so I'll guess I will see how it evolves).=
=20
Anyway, I ran sensors-detect, and it found next to nothing apparently. I th=
en=20
downloaded the svn version, ran it, and it came to a different conclusion=20
(doesn't Ubuntu beta 10.10 have a recent lm-sensors?):

I could/should install the coretemp module, and so I did. Now sensors gives=
=20
me:

acpitz-virtual-0
Adapter: Virtual device
temp1:       +26.8=C2=B0C  (crit =3D +127.0=C2=B0C)                 =20
temp2:       +57.0=C2=B0C  (crit =3D +85.0=C2=B0C)                 =20

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +57.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C) =
=20

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +57.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C) =
=20

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +58.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C) =
=20

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +57.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C) =
=20

No fan speeds though, and I'd expected such info from a laptop this expensi=
ve.=20
Looking at sensors-detect again, I have this:

Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   Yes
=46ound unknown chip with ID 0x8512

Is this something of interest?

As a side note, the fan turned itself down a notch now, but it is still mor=
e=20
noisy than I'd expect it (I think).

Anyway, if anyone would like to help me with suggestions or similar as to w=
hat=20
to look for/what to test, it would be much appreciated. If there is somethi=
ng=20
I can do to help the lm-sensors project in this regard, I'll do my best.

Best regards,
Lars Ivar Igesund


--Boundary-01=_2KjiM0iHmxw3TTs
Content-Type: text/html;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd">
<html><head><meta name=3D"qrichtext" content=3D"1" /><style type=3D"text/cs=
s">
p, li { white-space: pre-wrap; }
</style></head><body style=3D" font-family:'Bitstream Vera Sans'; font-size=
:10pt; font-weight:400; font-style:normal;">
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Hi all,</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I admit to =
using beta software, and to the possibility that the issue is not in lm-sen=
sors, but since I'm very interested in getting my issue fixed, I think this=
 list is the right place to start at least.</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I upgraded =
to Ubuntu 10.10 beta today, and the almost immediate result is that the fan=
 has become noisy as hell.</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I have a De=
ll XPS Studio 17 laptop, bought earlier this year. It has (among other thin=
gs) an i7 Q820 processor.</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I never ran=
 sensors before the upgrade (didn't have any fan issues there), so I don't =
know if there's any actual differences in the output, but here goes.</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Just runnin=
g sensors give me:</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">acpitz-virt=
ual-0</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Adapter: Vi=
rtual device</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">temp1:     =
  +26.8=C2=B0C  (crit =3D +127.0=C2=B0C)                  </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">temp2:     =
  +61.0=C2=B0C  (crit =3D +85.0=C2=B0C)  </p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Since I've =
little or no load on the CPU, I find the latter value unlikely high (but it=
 seems to be dropping now so I'll guess I will see how it evolves). Anyway,=
 I ran sensors-detect, and it found next to nothing apparently. I then down=
loaded the svn version, ran it, and it came to a different conclusion (does=
n't Ubuntu beta 10.10 have a recent lm-sensors?):</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I could/sho=
uld install the coretemp module, and so I did. Now sensors gives me:</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">acpitz-virt=
ual-0</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Adapter: Vi=
rtual device</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">temp1:     =
  +26.8=C2=B0C  (crit =3D +127.0=C2=B0C)                  </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">temp2:     =
  +57.0=C2=B0C  (crit =3D +85.0=C2=B0C)                  </p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">coretemp-is=
a-0000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Adapter: IS=
A adapter</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Core 0:    =
  +57.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C)  </p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">coretemp-is=
a-0001</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Adapter: IS=
A adapter</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Core 1:    =
  +57.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C)  </p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">coretemp-is=
a-0002</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Adapter: IS=
A adapter</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Core 2:    =
  +58.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C)  </p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">coretemp-is=
a-0003</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Adapter: IS=
A adapter</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Core 3:    =
  +57.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C)  </p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">No fan spee=
ds though, and I'd expected such info from a laptop this expensive. Looking=
 at sensors-detect again, I have this:</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Probing for=
 Super-I/O at 0x4e/0x4f</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Trying fami=
ly `National Semiconductor'...                   Yes</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Found unkno=
wn chip with ID 0x8512</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Is this som=
ething of interest?</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">As a side n=
ote, the fan turned itself down a notch now, but it is still more noisy tha=
n I'd expect it (I think).</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Anyway, if =
anyone would like to help me with suggestions or similar as to what to look=
 for/what to test, it would be much appreciated. If there is something I ca=
n do to help the lm-sensors project in this regard, I'll do my best.</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Best regard=
s,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Lars Ivar I=
gesund</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p></body></html>
--Boundary-01=_2KjiM0iHmxw3TTs--


--===============1651458663040730891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1651458663040730891==--

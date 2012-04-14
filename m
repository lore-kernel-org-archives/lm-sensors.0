From: Martin Suchanek <martin.suc@googlemail.com>
Date: Sat, 14 Apr 2012 13:09:59 +0000
Subject: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus iv e
Message-Id: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5889027927868503113=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5889027927868503113==
Content-Type: multipart/alternative; boundary=14dae93404f768190d04bda34e1d

--14dae93404f768190d04bda34e1d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have found for long time ago that CPUTIN temperature is not showed
correctly by sensors command:

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +34.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C=
)
Core 0:         +30.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C=
)
...
nct6776-isa-0290
Adapter: ISA adapter
...
CPUTIN:        -60.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)=
  sensor =3D diode
...

I have cheked it in BIOS and in AI Suite in windows 7 64 bit and consulted
it with ASUS technical support and everything is working properly.
So , hardware is fine. Software in windows is fine. Only linux software is
not correct.
I have tried to detect-sensor many times and it is still the same.
If there is some kind of tweak in config please let me know but it seems to
me there is something wrong with lm-sensors 3.3.1.

...
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
...
Found `Nuvoton NCT6776F Super IO Sensors'                   Success!
...
Driver `w83627ehf':
  * ISA bus, address 0x290
    Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)
...

my /etc/modules:
...
coretemp
w83627ehf
...

This error have appeared on maximus iv extreme motherboard Revision 3 ,
BIOS from 1404 to 3202 (latest)
linux ubuntu natty -> oneiric 64 bit kernel from 2.6.39 up to 3.0.0-19
commercial version (tested on 3.3.1 compiled by me)

Could you please help me to solve it ?

Thank you very much for any clue.
Kind Regards,
Martin

--14dae93404f768190d04bda34e1d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have found for long time ago that CPUTIN temperature is not sh=
owed correctly by sensors command:<br><br>coretemp-isa-0000<br>Adapter: ISA=
 adapter<br>Physical id 0:=C2=A0 +34.0=C2=B0C=C2=A0 (high =3D +80.0=C2=B0C,=
 crit =3D +98.0=C2=B0C)<br>
Core 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +30.0=C2=B0C=C2=A0 =
(high =3D +80.0=C2=B0C, crit =3D +98.0=C2=B0C)<br>...<br>nct6776-isa-0290<b=
r>Adapter: ISA adapter<br>...<br>CPUTIN:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 -60.0=C2=B0C=C2=A0 (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)=
=C2=A0 sensor =3D diode<br>...<br><br>I have cheked it in BIOS and in AI Su=
ite in windows 7 64 bit and consulted it with ASUS technical support and ev=
erything is working properly. <br>
So , hardware is fine. Software in windows is fine. Only linux software is =
not correct.<br>I have tried to detect-sensor many times and it is still th=
e same.<br>If there is some kind of tweak in config please let me know but =
it seems to me there is something wrong with lm-sensors 3.3.1.<br>
<br>...<br>Intel digital thermal sensor...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Success!<br>=
=C2=A0=C2=A0=C2=A0 (driver `coretemp&#39;)<br>...<br>Found `Nuvoton NCT6776=
F Super IO Sensors&#39;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Success!<br>...<b=
r>Driver `w83627ehf&#39;:<br>
=C2=A0 * ISA bus, address 0x290<br>=C2=A0=C2=A0=C2=A0 Chip `Nuvoton NCT6776=
F Super IO Sensors&#39; (confidence: 9)<br><br>Driver `coretemp&#39;:<br>=
=C2=A0 * Chip `Intel digital thermal sensor&#39; (confidence: 9)<br>...<br>=
<br>my /etc/modules:<br>
...<br>coretemp<br>w83627ehf<br>...<br><br>This error have appeared on maxi=
mus iv extreme motherboard Revision 3 , BIOS from 1404 to 3202 (latest)<br>=
linux ubuntu natty -&gt; oneiric 64 bit kernel from 2.6.39 up to 3.0.0-19 c=
ommercial version (tested on 3.3.1 compiled by me)<br>
<br>Could you please help me to solve it ?<br><br>Thank you very much for a=
ny clue.<br>Kind Regards,<br>Martin<br>

--14dae93404f768190d04bda34e1d--


--===============5889027927868503113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5889027927868503113==--

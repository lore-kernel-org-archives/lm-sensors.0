From: Martin Suchanek <martin.suc@googlemail.com>
Date: Fri, 20 Apr 2012 10:47:47 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <CAGqf2iJ=J9nb+iBqdKe5-4_nzfUzh0R=jezAcQNsLe0D4EdLaA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2196874499822867253=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2196874499822867253==
Content-Type: multipart/alternative; boundary=14dae9340a47e1667904be1a045f

--14dae9340a47e1667904be1a045f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Add info:
I have found software called open hardware monitor. I have been testing it
in windows for couple of days and it works properly with Nuvoton NST6776F
chip. I have been comparing results with AI Suite software coming from ASUS
and results are corresponding and measuring is with big precise. So , you
can have a look to source code and compare with your driver. This software
should work on linux as well but I did not try it yet but I will.

(I did not tried your experimental driver yet but I will)

Regards,
Martin


On Sat, Apr 14, 2012 at 2:09 PM, Martin Suchanek
<martin.suc@googlemail.com>wrote:

> Hi,
>
> I have found for long time ago that CPUTIN temperature is not showed
> correctly by sensors command:
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +34.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +98.0=C2=
=B0C)
> Core 0:         +30.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +98.0=C2=
=B0C)
> ...
> nct6776-isa-0290
> Adapter: ISA adapter
> ...
> CPUTIN:        -60.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0=
C)  sensor =3D diode
> ...
>
> I have cheked it in BIOS and in AI Suite in windows 7 64 bit and consulte=
d
> it with ASUS technical support and everything is working properly.
> So , hardware is fine. Software in windows is fine. Only linux software i=
s
> not correct.
> I have tried to detect-sensor many times and it is still the same.
> If there is some kind of tweak in config please let me know but it seems
> to me there is something wrong with lm-sensors 3.3.1.
>
> ...
> Intel digital thermal sensor...                             Success!
>     (driver `coretemp')
> ...
> Found `Nuvoton NCT6776F Super IO Sensors'                   Success!
> ...
> Driver `w83627ehf':
>   * ISA bus, address 0x290
>     Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)
>
> Driver `coretemp':
>   * Chip `Intel digital thermal sensor' (confidence: 9)
> ...
>
> my /etc/modules:
> ...
> coretemp
> w83627ehf
> ...
>
> This error have appeared on maximus iv extreme motherboard Revision 3 ,
> BIOS from 1404 to 3202 (latest)
> linux ubuntu natty -> oneiric 64 bit kernel from 2.6.39 up to 3.0.0-19
> commercial version (tested on 3.3.1 compiled by me)
>
> Could you please help me to solve it ?
>
> Thank you very much for any clue.
> Kind Regards,
> Martin
>

--14dae9340a47e1667904be1a045f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra">Hi,<br><br>Add info:<br>I have found software ca=
lled open hardware monitor. I have been testing it in windows for couple of=
 days and it works properly with Nuvoton NST6776F chip. I have been compari=
ng results with AI Suite software coming from ASUS and results are correspo=
nding and measuring is with big precise. So , you can have a look to source=
 code and compare with your driver. This software should work on linux as w=
ell but I did not try it yet but I will.<br>
<br>(I did not tried your experimental driver yet but I will)<br><br>Regard=
s,<br>Martin<br><br><br><div class=3D"gmail_quote">On Sat, Apr 14, 2012 at =
2:09 PM, Martin Suchanek <span dir=3D"ltr">&lt;<a href=3D"mailto:martin.suc=
@googlemail.com" target=3D"_blank">martin.suc@googlemail.com</a>&gt;</span>=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br><br>I have found for long time ago th=
at CPUTIN temperature is not showed correctly by sensors command:<br><br>co=
retemp-isa-0000<br>
Adapter: ISA adapter<br>Physical id 0:=C2=A0 +34.0=C2=B0C=C2=A0 (high =3D +=
80.0=C2=B0C, crit =3D +98.0=C2=B0C)<br>
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
</blockquote></div><br></div>

--14dae9340a47e1667904be1a045f--


--===============2196874499822867253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2196874499822867253==--

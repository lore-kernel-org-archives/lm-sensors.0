From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 19 Oct 2009 10:51:46 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <alpine.DEB.2.00.0910190651110.7710@p34.internal.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463747160-1982952940-1255949506=:7710"
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-1982952940-1255949506=:7710
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Mon, 19 Oct 2009, Simon Wilson wrote:

> I am soooo close to getting this working properly.
>
> I have a GA-P35-DS3P motherboard, with an E6850 Core 2 Duo processor. The=
=20
> machine is running CentOS 5.3. It has an it8718 sensors chip.
>
> I have installed lm_sensors 2.10.8 and the kmod-it87 driver from elrepo.o=
rg=20
> (needed because of the 'old' CentOS 2.6.18 kernel), and all is basically=
=20
> working. A clear sensors output reads:
>
> it8718-isa-0290
> Adapter: ISA adapter
> in0:       +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in1:       +1.87 V  (min =3D  +1.71 V, max =3D  +1.89 V)
> in2:       +3.22 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> in3:       +2.91 V  (min =3D  +2.83 V, max =3D  +3.12 V)
> in4:       +0.85 V  (min =3D  +2.85 V, max =3D  +3.15 V)   ALARM
> in5:       +0.05 V  (min =3D  +0.85 V, max =3D  +1.09 V)   ALARM
> in6:       +0.03 V  (min =3D  +1.12 V, max =3D  +1.28 V)   ALARM
> in7:       +3.12 V  (min =3D  +2.85 V, max =3D  +3.15 V)
> in8:       +3.30 V
> fan1:     1424 RPM  (min =3D  600 RPM)
> fan2:        0 RPM  (min =3D 3994 RPM)
> fan3:        0 RPM  (min =3D    0 RPM)
> fan4:        0 RPM  (min =3D    0 RPM)
> temp1:       +30=C2=B0C  (low  =3D   +10=C2=B0C, high =3D   +60=C2=B0C)  =
 sensor =3D thermistor
> temp2:       +26=C2=B0C  (low  =3D   +10=C2=B0C, high =3D   +70=C2=B0C)  =
 sensor =3D diode
> temp3:        -2=C2=B0C  (low  =3D  +127=C2=B0C, high =3D  +127=C2=B0C)  =
 sensor =3D disabled
> vid:      +0.000 V
>
> Using the configuration from=20
> http://www.lm-sensors.org/wiki/Configurations/Gigabyte/G33-DS3R which als=
o=20
> uses the 8718 I am now at this:
>
> it8718-isa-0290
> Adapter: ISA adapter
> Vcore:     +1.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> Vram:      +1.87 V  (min =3D  +1.71 V, max =3D  +1.89 V)
> +3.3V:     +3.22 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> +5V:       +4.89 V  (min =3D  +4.76 V, max =3D  +5.24 V)
> +12V:     +12.48 V  (min =3D +11.39 V, max =3D +12.61 V)
> Vbat:      +3.30 V
> CPU Fan:  1421 RPM  (min =3D  600 RPM)
> NBr Temp:    +30=C2=B0C  (low  =3D   +10=C2=B0C, high =3D   +60=C2=B0C)  =
 sensor =3D thermistor
> CPU Temp:    +26=C2=B0C  (low  =3D   +10=C2=B0C, high =3D   +70=C2=B0C)  =
 sensor =3D diode
> vid:      +0.000 V
>
> Which is perfect apart from one thing - the 0.000 V value for VID, which =
is=20
> then also throwing off Vcore (in0) as that is calculated from VID (>95=20
> <105%).
>
> Can anyone help me work out why VID is reading 0.000?
>
> Thanks

Hi,

I have the same board and would like to know as well, my output:

it8718-isa-0290
Adapter: ISA adapter
in0:         +1.57 V  (min =3D  +0.00 V, max =3D  +4.08 V)=20
in1:         +2.11 V  (min =3D  +0.00 V, max =3D  +4.08 V)=20
in2:         +3.23 V  (min =3D  +0.00 V, max =3D  +4.08 V)=20
in3:         +2.93 V  (min =3D  +0.00 V, max =3D  +4.08 V)=20
in4:         +0.86 V  (min =3D  +0.00 V, max =3D  +4.08 V)=20
in5:         +0.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)=20
in6:         +0.16 V  (min =3D  +0.00 V, max =3D  +4.08 V)=20
in7:         +3.09 V  (min =3D  +0.00 V, max =3D  +4.08 V)=20
Vbat:        +3.28 V
fan1:          0 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:       1117 RPM  (min =3D    0 RPM)
fan4:       1102 RPM  (min =3D    0 RPM)
temp1:       +46.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D thermistor
temp2:       +35.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D thermal diode
temp3:        -2.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D thermistor
cpu0_vid:   +0.000 V

Justin.

---1463747160-1982952940-1255949506=:7710
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1463747160-1982952940-1255949506=:7710--

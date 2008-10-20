From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 20 Oct 2008 15:10:51 +0000
Subject: Re: [lm-sensors] abituguru3: Please send .. to the abituguru3 (see
Message-Id: <alpine.DEB.1.10.0810201018130.13672@p34.internal.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463747160-466986530-1224515451=:4791"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0810191251550.19058@p34.internal.lan>
In-Reply-To: <alpine.DEB.1.10.0810191251550.19058@p34.internal.lan>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-466986530-1224515451=:4791
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Sun, 19 Oct 2008, Alistair John Strachan wrote:

> On Sunday 19 October 2008 17:54:15 Justin Piszcz wrote:
>> Kernel: 2.6.27.2:
>> [   10.242065] abituguru3: found Abit uGuru3, motherboard ID: 0016
>> [   10.242105] abituguru3: this motherboard was not detected using DMI.
>> Please send the output of "dmidecode" to the abituguru3 maintainer(see
>> MAINTAINERS)
>>
>> Motherboard: AW9D-MAX as shown below.
>>
>> DMI Decode:
> [snip]
>>  =09Product Name: AW9D-MAX       (Intel i975-ICH7)
>
> The spaces are a somewhat worrying (Abit haven't done this on other board=
s I
> have DMI information for), but assuming they're constant through all BIOS
> revisions the attached patch should be safe.
>
> (In the longer term it might be safer to only match the board product nam=
e,
> and ignore the chipset information. I'll do this if the need arises.)
>
> Please test the attached patch. I'll resubmit a cleaned up version if you=
 can
> verify that the kernel message disappears and your sensors still work.
>
> --=20
> Cheers,
> Alistair.
>

Against 2.6.27.2:

# patch -p1 < /home/war/aw9d-max-dmi-detection.diff
patching file drivers/hwmon/abituguru3.c

Reboot, dmesg:

[   10.247075] abituguru3: found Abit uGuru3, motherboard ID: 0016

Success.. and the sensors continue to work, btw the colon is off in one of=
=20
the sensors (display artifact), not related to this patch/etc, just FYI:

abituguru3-isa-00e0
Adapter: ISA adapter
CPU Core:          +1.23 V  (min =3D  +0.00 V, max =3D  +1.60 V)
DDR2:              +2.00 V  (min =3D  +1.60 V, max =3D  +2.40 V)
DDR2 VTT:          +1.01 V  (min =3D  +0.80 V, max =3D  +1.20 V)
CPU VTT 1.2V:      +1.22 V  (min =3D  +0.95 V, max =3D  +1.45 V)
MCH & PCIE 1.5V:   +1.50 V  (min =3D  +1.20 V, max =3D  +1.80 V)
MCH 2.5V:          +2.58 V  (min =3D  +2.00 V, max =3D  +3.00 V)
ICH 1.05V:         +1.04 V  (min =3D  +0.85 V, max =3D  +1.25 V)
ATX +12V (24-Pin):+12.18 V  (min =3D  +9.60 V, max =3D +14.40 V)
ATX +12V (4-pin): +12.24 V  (min =3D  +9.60 V, max =3D +14.40 V)
ATX +5V:           +5.07 V  (min =3D  +3.99 V, max =3D  +6.00 V)
+3.3V:             +3.38 V  (min =3D  +2.64 V, max =3D  +3.94 V)
5VSB:              +5.10 V  (min =3D  +3.99 V, max =3D  +6.00 V)
CPU Fan:          1380 RPM  (min =3D  300 RPM)
NB Fan:              0 RPM  (min =3D  300 RPM)
SYS Fan:             0 RPM  (min =3D  300 RPM)
AUX1 Fan:            0 RPM  (min =3D  300 RPM)
AUX2 Fan:            0 RPM  (min =3D  300 RPM)
AUX3 Fan:            0 RPM  (min =3D  300 RPM)
OTES1 Fan:           0 RPM  (min =3D  300 RPM)
CPU:               +37.0=B0C  (high =3D +75.0=B0C, crit =3D +85.0=B0C)=20
System :           +35.0=B0C  (high =3D +55.0=B0C, crit =3D +65.0=B0C)
       ^^^ (artifact)
PWM1:              +37.0=B0C  (high =3D +80.0=B0C, crit =3D +90.0=B0C)=20
PWM2:              +39.0=B0C  (high =3D +80.0=B0C, crit =3D +90.0=B0C)=20
PWM3:              +41.0=B0C  (high =3D +80.0=B0C, crit =3D +90.0=B0C)=20
PWM4:              +36.0=B0C  (high =3D +80.0=B0C, crit =3D +90.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +46.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +48.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

There should be another fan running as well, will have to check that=20
later, but the rest of the sensors look normal.

Thank you,

Justin.

---1463747160-466986530-1224515451=:4791
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1463747160-466986530-1224515451=:4791--

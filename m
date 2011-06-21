From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Jun 2011 07:16:31 +0000
Subject: Re: [lm-sensors] IT8721F on Asus M5A88-V EVO
Message-Id: <20110621091631.3da18968@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201106192314.40074.plr.vincent@gmail.com>
In-Reply-To: <201106192314.40074.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Salut Vincent,

On Mon, 20 Jun 2011 13:20:49 +0200, Vincent Pelletier wrote:
> Again, with atk0110 loaded (after I noticed the warning in dmesg about us=
ing=20
> acpi_enforce_resources kernel parameter preventing atk module from loadin=
g).
> All values provided again for comparison.

Your copy-and-paste method added a lot of trailing white space, making
your post needlessly large and quoting difficult. Please clean up your
post before sending next time.

>=20
> $ sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +28.5=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +70.0=B0C, hyst =3D +65.0=B0C)
>
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:      +1.27 V  (min =3D  +0.85 V, max =3D  +1.60 V)
>  +3.3 Voltage:      +3.28 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>  +5 Voltage:        +5.06 V  (min =3D  +4.50 V, max =3D  +5.50 V)
>  +12 Voltage:      +12.13 V  (min =3D +10.20 V, max =3D +13.80 V)
> CPU FAN Speed:     2616 RPM  (min =3D  600 RPM)
> CHASSIS FAN Speed: 1562 RPM  (min =3D  600 RPM)
> POWER FAN Speed:   1683 RPM  (min =3D  600 RPM)
> CPU Temperature:    +37.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:     +35.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)

This is indeed the driver you want to use on every recent Asus desktop
board.

>
> it8721-isa-0290
> Adapter: ISA adapter
> VCore:        +2.92 V  (min =3D  +1.82 V, max =3D  +0.17 V)  ALARM
> VDDR:         +2.89 V  (min =3D  +2.34 V, max =3D  +2.06 V)  ALARM
> +3.3V:        +1.27 V  (min =3D  +2.10 V, max =3D  +2.68 V)  ALARM
> +5V:          +3.29 V  (min =3D  +2.38 V, max =3D  +2.90 V)  ALARM
> +12V:         +1.70 V  (min =3D  +2.82 V, max =3D  +1.31 V)  ALARM
> in5:          +2.63 V  (min =3D  +2.10 V, max =3D  +1.40 V)  ALARM
> in6:          +1.01 V  (min =3D  +1.99 V, max =3D  +1.25 V)  ALARM
> VSB:          +4.27 V  (min =3D  +1.30 V, max =3D  +2.76 V)  ALARM
> VBat:         +3.34 V

It no longer matters, but the first 5 voltage labels are wrong. Not
sure where you got them from. in2 is obviously Vcore and in3 matches
+3.3V.=20

> CPU fan:     2606 RPM  (min =3D   14 RPM)
> CHA fan:     1566 RPM  (min =3D   24 RPM)
> PSU fan:     1683 RPM  (min =3D   21 RPM)
> CPU Temp:     +37.0=B0C  (low  =3D  +0.0=B0C, high =3D +70.0=B0C)  sensor=
 =3D thermistor
> MB Temp:      +35.0=B0C  (low  =3D  +0.0=B0C, high =3D +70.0=B0C)  sensor=
 =3D thermistor
>=20
> atk driver provides values very close to bios, with following exceptions:

Not surprising, given that the asus_atk0110 driver gets the values from
the BIOS itself, rather than from the monitoring chip directly.

> - cpu temp is lower (46=B0 in bios), in my understanding cpu is at full
>   speed during bios so it can explain
> - chassis fan lower (1717 RPM in bios), most probably related to higher c=
pu
>   temperature, as its speed under OS follows CPU temperature

Both correct.

> - power fan min RPM cannot be set in the bios, others are consistent with=
 my
>   settings
> - MB temperature shutdown level in bios is 95=B0. Not sure if it contradi=
cts
>   "crit" level reported above (maybe unrelated).

Looks wrong indeed, as it is set to 75=B0C, not 95=B0C. Is there a CPU
temperature shutdown level that you can set as well? If so, to what
value did you set it?

What surprises me the most is that the it87 driver reported completely
different limits, which means that these are software limits... The
BIOS never wrote them to the chip (unless you screwed them up yourself
with a libsensors configuration file?) I wonder how such software
limits can be enforced. Maybe this only works on Windows with Asus
proprietary software loaded. Or maybe the BIOS is polling the device
periodically at run-time. Ugly in both cases.

> For some reason, when changing fan settings in bios, linux fails booting =
after=20
> detecting all hard disks, undoing the config doesn't always cure startup.=
 I=20
> could originally boot in "auto" mode, now I can bot in "manual" mode (bio=
s=20
> controls fans, but I get to set the levels - for no audible difference=20
> anyway). I suspect bios has a good share of bugs

Could be indeed. Feel free to report to the board vendor.

> (it seems this motherboard is=20
> more recent than I thought... dmidecode says "Release Date: 04/18/2011" i=
n=20
> "BIOS Information" section).

Means that the BIOS is recent, not necessarily the board. But looking
at the Asus website, the board indeed seems to be brand new, so
hopefully any BIOS bug reported now will get fixed in the next BIOS
update.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

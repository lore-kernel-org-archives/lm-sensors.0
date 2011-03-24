From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Mar 2011 08:40:02 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <20110324094002.005f107a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312212759.3c9e0e56@endymion.delvare>
In-Reply-To: <20110312212759.3c9e0e56@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Anders,

On Sun, 20 Mar 2011 23:36:32 +0100, Anders Kullenberg wrote:
> > Fr=E5n: Jean Delvare [mailto:khali@linux-fr.org]
> > Skickat: den 16 mars 2011 12:38
> > Till: Anders Kullenberg
> > Kopia: 'Luca Tettamanti'; 'LM Sensors'
> > =C4mne: Re: [lm-sensors] extreme fan rpms with atk0110
> > On Tue, 15 Mar 2011 20:39:12 +0100, Anders Kullenberg wrote:
> > > Blacklisting is done in "/usr/src/linux-headers-2.6.35-27-
> > server/.config" correct?
> > > In the ACPI drivers section I have:
> > > CONFIG_SENSORS_ATK0110=3Dm
> > > CONFIG_SENSORS_LIS3LV02D=3Dm
> > >
> > > Should I comment both those out?
> >=20
> > No, blacklisting is done with statements in /etc/modprobe.d/*. On my
> > distribution, I'd add:
> >=20
> > blacklist asus_atk0110
> >=20
> > to file etc/modprobe.d/99-local.conf. Or you can create a brand new
> > file in this directory if you want.
> >=20
> > >
> > > Where do I put the "acpi_enforce_resources=3Dlax"
> >=20
> > It has to go on the boot command line, typically you add it when grub
> > presents the boot options at system start-up. Alternatively, you can
> > edit /boot/grub/menu.lst or /boot/grub/grub.cfg (depending on your
> > distribution) manually to add it at the end of the relevant "linux" or
> > "kernel" line.
>=20
> Followed the instructions and it worked until next reboot, then the CPU f=
an

Boot parameters typed on the grub command line are only for the current
boot. If you want them to be permanent, you have to edit the grub
configuration files instead.

> jumped up to ~3000 rpm's. I went back to using the atk0110 again.
> I have computed the CPU fan with @/32,32*@ and the chassis fan with @/8,8=
*@,
> seams to give relatively correct figures. Tried using the set fanN_div
> statement to get correct min values but I get an error when running senso=
rs
> afterwards. Any recommendations on that?

The asus_atk0110 driver doesn't support changing the divisor values,
because the ACPI interface implemented by the BIOS doesn't expose these
settings. So the error you hit is expected.

Please provide the output of the following command:
# isadump 0xd05 0xd06

This will show the IT8712F hardware monitoring registers, and in
particular register 0x0c which contains the 8/16-bit fan configuration
bits. Luca says that the ATK0110 code expects them to be set to 8-bit.

Additionally, I would like to know the exact revision of your IT8712F
chip. The it87 driver logged the information when you loaded it, so you
may be able to find the information in your logs. If not, the following
dump will tell:
# isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

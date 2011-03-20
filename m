From: "Anders Kullenberg" <akullen@swipnet.se>
Date: Sun, 20 Mar 2011 22:36:32 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <000001cbe74f$438874c0$ca995e40$@se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312212759.3c9e0e56@endymion.delvare>
In-Reply-To: <20110312212759.3c9e0e56@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Fr=E5n: Jean Delvare [mailto:khali@linux-fr.org]
> Skickat: den 16 mars 2011 12:38
> Till: Anders Kullenberg
> Kopia: 'Luca Tettamanti'; 'LM Sensors'
> =C4mne: Re: [lm-sensors] extreme fan rpms with atk0110
>=20
> Anders,
>=20
> On Tue, 15 Mar 2011 20:39:12 +0100, Anders Kullenberg wrote:
> > > Fr=E5n: Luca Tettamanti [mailto:kronos.it@gmail.com]
> > > Skickat: den 15 mars 2011 17:01
> > > Till: Jean Delvare
> > > Kopia: Anders Kullenberg; LM Sensors
> > > =C4mne: Re: [lm-sensors] extreme fan rpms with atk0110
> > >
> > > On Tue, Mar 15, 2011 at 3:58 PM, Jean Delvare <khali@linux-fr.org>
> > > wrote:
> > > > On Tue, 15 Mar 2011 15:01:24 +0100, Luca Tettamanti wrote:
> > > [cut]
> > > > Found `ITE IT8712F Super IO Sensors'
> Success!
> > > >    (address 0xd00, driver `it87')
> > > >
> > > >> If possible load the native driver (blacklist asus_atk0110 and
> boot
> > > >> with acpi_enforce_resources=3Dlax) and compare the fan readings.
> >
> > Blacklisting is done in "/usr/src/linux-headers-2.6.35-27-
> server/.config" correct?
> > In the ACPI drivers section I have:
> > CONFIG_SENSORS_ATK0110=3Dm
> > CONFIG_SENSORS_LIS3LV02D=3Dm
> >
> > Should I comment both those out?
>=20
> No, blacklisting is done with statements in /etc/modprobe.d/*. On my
> distribution, I'd add:
>=20
> blacklist asus_atk0110
>=20
> to file etc/modprobe.d/99-local.conf. Or you can create a brand new
> file in this directory if you want.
>=20
> >
> > Where do I put the "acpi_enforce_resources=3Dlax"
>=20
> It has to go on the boot command line, typically you add it when grub
> presents the boot options at system start-up. Alternatively, you can
> edit /boot/grub/menu.lst or /boot/grub/grub.cfg (depending on your
> distribution) manually to add it at the end of the relevant "linux" or
> "kernel" line.
>=20
> --
> Jean Delvare

Followed the instructions and it worked until next reboot, then the CPU fan
jumped up to ~3000 rpm's. I went back to using the atk0110 again.
I have computed the CPU fan with @/32,32*@ and the chassis fan with @/8,8*@,
seams to give relatively correct figures. Tried using the set fanN_div
statement to get correct min values but I get an error when running sensors
afterwards. Any recommendations on that?

Thanks
Anders


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

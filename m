From: "Anders Kullenberg" <akullen@swipnet.se>
Date: Thu, 24 Mar 2011 17:23:08 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <000901cbea48$2567dde0$703799a0$@se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312212759.3c9e0e56@endymion.delvare>
In-Reply-To: <20110312212759.3c9e0e56@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

> -----Ursprungligt meddelande-----
> Fr=E5n: Jean Delvare [mailto:khali@linux-fr.org]
> Skickat: den 24 mars 2011 09:40
> Till: Anders Kullenberg
> Kopia: 'Luca Tettamanti'; 'LM Sensors'
> =C4mne: Re: [lm-sensors] extreme fan rpms with atk0110
>=20
> Hi Anders,
>=20
> On Sun, 20 Mar 2011 23:36:32 +0100, Anders Kullenberg wrote:
> > > Fr=E5n: Jean Delvare [mailto:khali@linux-fr.org]
> > > Skickat: den 16 mars 2011 12:38
> > > Till: Anders Kullenberg
> > > Kopia: 'Luca Tettamanti'; 'LM Sensors'
> > > =C4mne: Re: [lm-sensors] extreme fan rpms with atk0110
> > > On Tue, 15 Mar 2011 20:39:12 +0100, Anders Kullenberg wrote:
> > > > Blacklisting is done in "/usr/src/linux-headers-2.6.35-27-
> > > server/.config" correct?
> > > > In the ACPI drivers section I have:
> > > > CONFIG_SENSORS_ATK0110=3Dm
> > > > CONFIG_SENSORS_LIS3LV02D=3Dm
> > > >
> > > > Should I comment both those out?
> > >
> > > No, blacklisting is done with statements in /etc/modprobe.d/*. On
> my
> > > distribution, I'd add:
> > >
> > > blacklist asus_atk0110
> > >
> > > to file etc/modprobe.d/99-local.conf. Or you can create a brand new
> > > file in this directory if you want.
> > >
> > > >
> > > > Where do I put the "acpi_enforce_resources=3Dlax"
> > >
> > > It has to go on the boot command line, typically you add it when
> grub
> > > presents the boot options at system start-up. Alternatively, you
> can
> > > edit /boot/grub/menu.lst or /boot/grub/grub.cfg (depending on your
> > > distribution) manually to add it at the end of the relevant "linux"
> or
> > > "kernel" line.
> >
> > Followed the instructions and it worked until next reboot, then the
> CPU fan
>=20
> Boot parameters typed on the grub command line are only for the current
> boot. If you want them to be permanent, you have to edit the grub
> configuration files instead.

I did added  GRUB_CMDLINE_LINUX=3D"acpi_enforce_resources=3Dlax" to
/etc/default/grub and ran update-grub2
That added it to the grub.cfg file for me. Does not that mean that it should
stick after reboot?

>=20
> > jumped up to ~3000 rpm's. I went back to using the atk0110 again.
> > I have computed the CPU fan with @/32,32*@ and the chassis fan with
> @/8,8*@,
> > seams to give relatively correct figures. Tried using the set
> fanN_div
> > statement to get correct min values but I get an error when running
> sensors
> > afterwards. Any recommendations on that?
>=20
> The asus_atk0110 driver doesn't support changing the divisor values,
> because the ACPI interface implemented by the BIOS doesn't expose these
> settings. So the error you hit is expected.
>=20
> Please provide the output of the following command:
> # isadump 0xd05 0xd06

akullen@ubuntu64:~$ sudo isadump 0xd05 0xd06
[sudo] password for akullen:
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0xd05 and data register 0xd06.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 19 00 ff 03 00 00 00 00 00 80 7f 3b 07 80 ff ff
10: ff ff ff 77 87 80 7f 7f 00 ff ff ff ff ff ff ff
20: 46 ff cf ba ba ff ff ff cc 1e 2e 80 0e fe fe fe
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff 2d ff ff ff ff ff ff ff
50: 1d 18 7f 7f 7f 00 56 00 90 56 ff 12 80 00 00 00
60: 00 23 7f 37 18 03 ff ff 00 19 7f 28 18 03 ff ff
70: 7f 7f 7f 00 00 7f ff ff ff ff ff ff ff ff ff ff
80: 00 00 00 00 ff ff ff ff 00 00 ff ca 02 00 99 99
90: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff
a0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

>=20
> This will show the IT8712F hardware monitoring registers, and in
> particular register 0x0c which contains the 8/16-bit fan configuration
> bits. Luca says that the ATK0110 code expects them to be set to 8-bit.
>=20
> Additionally, I would like to know the exact revision of your IT8712F
> chip. The it87 driver logged the information when you loaded it, so you
> may be able to find the information in your logs. If not, the following
> dump will tell:
> # isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4

akullen@ubuntu64:/var/log$ sudo isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4
[sudo] password for akullen:
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 4 using bank register 0x07.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 87 12 08 01 00 00 00 00 00 40 00 00 1d 00 00 00
30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0d 00 0c 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 02 00 00 04 04 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 a0 00 fd 00 00 00 00 00 00 00 00 00

Also found this in the logs
messages:Mar 21 22:18:38 ubuntu64 kernel: [    6.528399] it87: Found IT8712F
chip at 0xd00, revision 8
messages:Mar 21 22:18:38 ubuntu64 kernel: [    6.528413] it87: in3 is VCC
(+5V)
messages:Mar 21 22:18:38 ubuntu64 kernel: [    6.528454] ACPI: resource it87
[io  0x0d05-0x0d06] conflicts w                       ith ACPI region ECRE
[mem 0x00000d00-0x00000d1f 64bit pref window disabled]

Is this something to worry about?

Thanks
Anders

>=20
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

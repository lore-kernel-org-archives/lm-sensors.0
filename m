From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Mar 2011 18:08:03 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <20110324190803.4f63213c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312212759.3c9e0e56@endymion.delvare>
In-Reply-To: <20110312212759.3c9e0e56@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Anders,

On Thu, 24 Mar 2011 18:23:08 +0100, Anders Kullenberg wrote:
> Hi Jean,
>=20
> > -----Ursprungligt meddelande-----
> > Fr=E5n: Jean Delvare [mailto:khali@linux-fr.org]
> > Skickat: den 24 mars 2011 09:40
> > Till: Anders Kullenberg
> > Kopia: 'Luca Tettamanti'; 'LM Sensors'
> > =C4mne: Re: [lm-sensors] extreme fan rpms with atk0110
> >
> > Boot parameters typed on the grub command line are only for the current
> > boot. If you want them to be permanent, you have to edit the grub
> > configuration files instead.
>=20
> I did added  GRUB_CMDLINE_LINUX=3D"acpi_enforce_resources=3Dlax" to
> /etc/default/grub and ran update-grub2
> That added it to the grub.cfg file for me. Does not that mean that it sho=
uld
> stick after reboot?

I'm not familiar with grub2, but yes, it certainly looks like it should
stick after reboot.

> > (...)
> > Please provide the output of the following command:
> > # isadump 0xd05 0xd06
>=20
> akullen@ubuntu64:~$ sudo isadump 0xd05 0xd06
> [sudo] password for akullen:
> WARNING! Running this program can cause system crashes, data loss and wor=
se!
> I will probe address register 0xd05 and data register 0xd06.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 19 00 ff 03 00 00 00 00 00 80 7f 3b 07 80 ff ff

You can see the value of register 0x0c: 0x07. This means fan1, fan2 and
fan3 in 16-bit mode.

> > This will show the IT8712F hardware monitoring registers, and in
> > particular register 0x0c which contains the 8/16-bit fan configuration
> > bits. Luca says that the ATK0110 code expects them to be set to 8-bit.

According to Luca, the ATK0110 code on this board expects all fans to
be in 8-bit mode (which according to the IT8712F datasheet is the
default, but the datasheet isn't necessarily correct on this.)

I don't know who enabled 16-bit mode... undocumented hardware default,
faulty BIOS, Linux kernel driver (the it87 driver would, but is
normally not allowed to load on ATK0110-enabled machines)? But
certainly the atk0110 driver would work fine if we the register value
was reverted to 8-bit mode.

So you could do the following:
* Unload the it87 driver if it is loaded.
* Temporarily comment out the fan compute statements in the
  asus_atk0110 section of your libsensors configuration file.
* As root, run:
  # isaset 0xd05 0xd06 0x0c 0x00 0x07
  This will set fan1, fan2 and fan3 to 8-bit mode.
* Load the asus_atk0110 driver if it's not already loaded.
* Check the fan speeds. I expect them to be back to normal.

Now there is a potential problem: the datasheet for the revision J of
the IT8712F (which is the one you have) does _not_ list fan clock
divisor register which 8-bit fan mode needs. If the register in
question is really no longer implemented in the hardware, this makes
the 8-bit fan mode pretty much useless, as speeds below ~2650 RPM can't
be monitored.

So, here's my theory: I think Asus has been using the previous revision
(I) of the IT8712F for this board originally, and it supported 8-bit
fan mode just fine, and they wrote their BIOS for it. Then ITE upgraded
their line to revision J and Asus used this as a replacement of the
revision I, without realizing it wasn't fully compatible. Now they may
have two variants of the board in the wild.

> (...)
> Also found this in the logs
> messages:Mar 21 22:18:38 ubuntu64 kernel: [    6.528399] it87: Found IT87=
12F
> chip at 0xd00, revision 8
> messages:Mar 21 22:18:38 ubuntu64 kernel: [    6.528413] it87: in3 is VCC
> (+5V)
> messages:Mar 21 22:18:38 ubuntu64 kernel: [    6.528454] ACPI: resource i=
t87
> [io  0x0d05-0x0d06] conflicts with ACPI region ECRE
> [mem 0x00000d00-0x00000d1f 64bit pref window disabled]
>=20
> Is this something to worry about?

No, this is expected. This is the I/O resource conflict which forces
you to choose between asus_atk0110 and it87.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

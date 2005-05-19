From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [mbuesch@freenet.de: [2.6.2-rc1] BTTV, RTC and I2C warning messages]
Message-Id: <20040126152121.GA634@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

----- Forwarded message from Michael Buesch <mbuesch@freenet.de> -----

From: Michael Buesch <mbuesch@freenet.de>
To: kraxel@bytesex.org, frodol@dds.nl, greg@kroah.com
Subject: [2.6.2-rc1] BTTV, RTC and I2C warning messages
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
X-MIME-Autoconverted: from quoted-printable to 8bit by morannon.frodo.local=
 id i0OJA4ER026501
X-Spam-Status: No, hits=3D-2.1 required=3D5.0 tests=3DPGP_SIGNATURE version=
=3D2.20
X-Spam-Level:=20

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I got these messages in the syslog while watching TV with
the "tvtime" application.

Jan 24 18:04:24 lfs kernel: bttv0: skipped frame. no signal? high irq laten=
cy? [main=1Fd81000,o_vbi=1Fd81018,o_field=1B0b6000,rc=1B0b601c]
Jan 24 18:21:54 lfs kernel: bttv0: skipped frame. no signal? high irq laten=
cy? [main=1Fd81000,o_vbi=1Fd81018,o_field=1B0b6000,rc=1B0b601c]
Jan 24 18:29:01 lfs kernel: bttv0: skipped frame. no signal? high irq laten=
cy? [main=1Fd81000,o_vbi=1Fd81018,o_field=D52b000,rc=D52b01c]
Jan 24 18:41:09 lfs kernel: bttv0: skipped frame. no signal? high irq laten=
cy? [main=1Fd81000,o_vbi=1Fd81018,o_field=1B0b4000,rc=1B0b401c]
Jan 24 18:59:21 lfs kernel: bttv0: skipped frame. no signal? high irq laten=
cy? [main=1Fd81000,o_vbi=1Fd81018,o_field=1B0b4000,rc=1B0b401c]
Jan 24 19:27:27 lfs kernel: bttv0: skipped frame. no signal? high irq laten=
cy? [main=1Fd81000,o_vbi=1Fd81018,o_field=D569000,rc=D56901c]
Jan 24 19:40:39 lfs kernel: bttv0: skipped frame. no signal? high irq laten=
cy? [main=1Fd81000,o_vbi=1Fd81018,o_field=1B0b4000,rc=1B0b4264]
Jan 24 19:43:59 lfs kernel: i2c IR (Hauppauge): unknown key: key=3D0x3f raw=
=3D0x3fff down=3D1
Jan 24 19:43:59 lfs kernel: i2c IR (Hauppauge): unknown key: key=3D0x3f raw=
=3D0x3fff down=3D0
Jan 24 19:44:27 lfs kernel: rtc: lost some interrupts at 1024Hz.

The "skipped frame" and "lost interrupt" messages were there
forever in kernel 2.6 for me. (I never saw them in 2.4). I had
several threads about them on lkml but nobody could really help me, so
I began to ignore these, as it runs even with them pretty good.

But the new message I got today was the "i2c IR (Hauppauge):" message
Yes, my Happauge WinTV PCI has an IR connector for remote control.
So kernel tells me, that someone pressed an unknown key on the
remote control (I guess this from the message). But the curious thing is:
There's no IR remote-control device connected to the Hauppauge
connection pin for at least a year, now. :) I've no IR-device
connected to any port.

yes, the "rtc" message... . I think it has something to do with that
tvtime uses RTC to display some picture or so. So tvtime accesses
the bttv driver and the rtc driver at once. So my guess: Probably a
race condition here? Probably in the kernel? Who knows... I don't.

mb@lfs:~> cat /proc/interrupts
           CPU0      =20
  0:    7284059    IO-APIC-edge  timer
  1:      10495    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:      49597    IO-APIC-edge  serial
  8:    7222782    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     279485    IO-APIC-edge  i8042
 14:     104363    IO-APIC-edge  ide0
 15:         40    IO-APIC-edge  ide1
 16:    1160911   IO-APIC-level  eth0, nvidia
 17:     528152   IO-APIC-level  bttv0
 19:      64980   IO-APIC-level  uhci_hcd, Ensoniq AudioPCI
 20:          0   IO-APIC-level  ohci_hcd
 21:          0   IO-APIC-level  ohci_hcd
 22:          0   IO-APIC-level  ehci_hcd
 23:          0   IO-APIC-level  uhci_hcd
NMI:          0=20
LOC:    7284538=20
ERR:          0
MIS:          0

Yes, somebody told me, that assigning a lower interrupt number to
the bttv card removed the "lost interrupt" messages, but how to do that?
I've tried to move the card around in the pci-slots, but it has always
been assigned the same IRQ. I've tried to set some interrupt options in
the bios, but that also didn't help. Is there any way to tell bttv to use
for example IRQ 11 or something like that? Also loading bttv before
the eth0 driver didn't work. As you see, bttv still has a higher IRQ.

Thanks you for all your help and suggestions.

- --=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAEsGLFGK1OIvVOP4RAsUaAJ4kHsKRWLXFGIiSS7OtWzLlOYNmKwCgkBhR
dw+QxPwCP/dhXbImazANp38=3DbIBi
-----END PGP SIGNATURE-----

----- End forwarded message -----

--=20
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~fr=
odol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually follow=
ed
  by the installation of Linux or some other Unix-like operating system.

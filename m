From: "David O'Shea" <dcoshea@hotmail.com>
Date: Thu, 08 Jan 2009 10:33:42 +0000
Subject: [lm-sensors] Compaq Evo D51S hidden sensor
Message-Id: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi all,

I have a Compaq Evo D51S (D510 Small Form Factor) running Fedora 10.  senso=
rs-detect says it can't find any sensors.  From reading http://www.lm-senso=
rs.org/ticket/2304 I got the impression that this particular model of PC sh=
ould be supported in 2.6.27-rc1 and I am running 2.6.27.9-159.fc10.i686.

From looking at http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux=
-2.6.git;a=3Dblob;f=3Ddrivers/pci/quirks.c;h=93faf84e4ec47c81fb10a2b6389f32=
4c9e08c50e;hb=10260d9ab702454460242ef4d3ecfc49fcb96a5b (commit of patch ref=
erenced by the ticket above) it looks like this code is meant to address th=
is model of PC:

>>>
1043         } else if (unlikely(dev->subsystem_vendor =3D PCI_VENDOR_ID_CO=
MPAQ)) {
[...]
1057                 else if (dev->device =3D PCI_DEVICE_ID_INTEL_82845G_IG)
1058                         switch(dev->subsystem_device) {
1059                         case 0x00b8: /* Compaq Evo D510 CMT */
1060                         case 0x00b9: /* Compaq Evo D510 SFF */
1061                                 asus_hides_smbus =3D 1;
1062                         }
<<<

In the attachment http://www.lm-sensors.org/attachment/ticket/2304/lspci-af=
ter-fakephp to the support ticket, I see:

>>>
00:02.0 VGA compatible controller [0300]: Intel Corporation
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device
[8086:2562] (rev 01) (prog-if 00 [VGA controller])
        Subsystem: Compaq Computer Corporation Evo D510 SFF [0e11:00b9]
<<<

which seems to correspond to the values that the kernel code checks for (ap=
ologies if I'm wrong - I'm making lots of assumptions here).

When I run 'lspci -vvxnn' I don't see the same thing.  I see a few items wi=
th the same "Subsystem:" line - 3 USB controllers and an IDE interface - bu=
t my VGA controller is:

>>>
01:00.0 VGA compatible controller [0300]: nVidia Corporation NV44A [GeForce=
 6200] [10de:0221] (rev a1) (prog-if 00 [VGA controller])
        Subsystem: XFX Pine Group Inc. Device [1682:2152]
<<<

I'm using an AGP card I added to the PC instead of the on-board video.  I a=
m assuming that the on-board video is not appearing because I added the AGP=
 card - would that be a normal thing to happen?

I am assuming that pci/quirks.c above just happens to check for the onboard=
 video as a way to detect this model of PC and it could check for something=
 else instead - would that be true?  If so (and there's no other investigat=
ion that might be needed), is this likely to be "fixed"/enhanced anytime so=
on or should I try kernel hacking myself?  I'm assuming I could add a check=
 for the IDE or USB (I'll try and check the BIOS settings or documentation =
to see if one of these in particular can't be disabled and therefore would =
always be present).

Thanks in advance,
David

PS Please cc: me on replies as I'm not subscribed

_________________________________________________________________
Holiday cheer from Messenger. Download free emoticons today!
http://livelife.ninemsn.com.au/article.aspx?idf9758=20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 10 Jan 2009 21:34:37 +0000
Subject: Re: [lm-sensors] Compaq Evo D51S hidden sensor
Message-Id: <20090110223437.0007d812@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
In-Reply-To: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi David,

On Thu, 8 Jan 2009 20:33:42 +1000, David O'Shea wrote:
>=20
> Hi all,
>=20
> I have a Compaq Evo D51S (D510 Small Form Factor) running Fedora 10.  sen=
sors-detect says it can't find any sensors.  From reading http://www.lm-sen=
sors.org/ticket/2304 I got the impression that this particular model of PC =
should be supported in 2.6.27-rc1 and I am running 2.6.27.9-159.fc10.i686.
>=20
> >From looking at http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/lin=
ux-2.6.git;a=3Dblob;f=3Ddrivers/pci/quirks.c;h=93faf84e4ec47c81fb10a2b6389f=
324c9e08c50e;hb=10260d9ab702454460242ef4d3ecfc49fcb96a5b (commit of patch r=
eferenced by the ticket above) it looks like this code is meant to address =
this model of PC:
>=20
> >>>
> 1043         } else if (unlikely(dev->subsystem_vendor =3D PCI_VENDOR_ID_=
COMPAQ)) {
> [...]
> 1057                 else if (dev->device =3D PCI_DEVICE_ID_INTEL_82845G_=
IG)
> 1058                         switch(dev->subsystem_device) {
> 1059                         case 0x00b8: /* Compaq Evo D510 CMT */
> 1060                         case 0x00b9: /* Compaq Evo D510 SFF */
> 1061                                 asus_hides_smbus =3D 1;
> 1062                         }
> <<<
>=20
> In the attachment http://www.lm-sensors.org/attachment/ticket/2304/lspci-=
after-fakephp to the support ticket, I see:
>=20
> >>>
> 00:02.0 VGA compatible controller [0300]: Intel Corporation
> 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device
> [8086:2562] (rev 01) (prog-if 00 [VGA controller])
>         Subsystem: Compaq Computer Corporation Evo D510 SFF [0e11:00b9]
> <<<
>=20
> which seems to correspond to the values that the kernel code checks for (=
apologies if I'm wrong - I'm making lots of assumptions here).

Your assumptions are correct.

> When I run 'lspci -vvxnn' I don't see the same thing.  I see a few items =
with the same "Subsystem:" line - 3 USB controllers and an IDE interface - =
but my VGA controller is:
>=20
> >>>
> 01:00.0 VGA compatible controller [0300]: nVidia Corporation NV44A [GeFor=
ce 6200] [10de:0221] (rev a1) (prog-if 00 [VGA controller])
>         Subsystem: XFX Pine Group Inc. Device [1682:2152]
> <<<
>=20
> I'm using an AGP card I added to the PC instead of the on-board video.  I=
 am assuming that the on-board video is not appearing because I added the A=
GP card - would that be a normal thing to happen?

Yes, that makes sense. Maybe there's an option in the BIOS to forcibly
enable the on-board video controller to stay visible. But most likely
it is hidden automatically and you can't work around it. Just check in
the BIOS if you can find any option controlling this behavior.

> I am assuming that pci/quirks.c above just happens to check for the onboa=
rd video as a way to detect this model of PC and it could check for somethi=
ng else instead - would that be true?  If so (and there's no other investig=
ation that might be needed), is this likely to be "fixed"/enhanced anytime =
soon or should I try kernel hacking myself?  I'm assuming I could add a che=
ck for the IDE or USB (I'll try and check the BIOS settings or documentatio=
n to see if one of these in particular can't be disabled and therefore woul=
d always be present).

You are correct, we used this device as a mean to detect these
machines, but another device could do as well. What matters is to find
a device with subvendor and subdevice values properly defined. Both the
IDE and the USB controllers meet this condition as far as I can see. I
think I'd use IDE. If you write a patch that does this and it fixes the
problem on your system, I'll be happy to review it and push it upstream.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

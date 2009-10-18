From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Oct 2009 12:07:35 +0000
Subject: Re: [lm-sensors] How do you make lm_sensors see a hwmon device?
Message-Id: <20091018140735.321f3291@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AD1E14B.90604@shikadi.net>
In-Reply-To: <4AD1E14B.90604@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Adam,

On Mon, 12 Oct 2009 15:36:39 +0200, Jean Delvare wrote:
> On Mon, 12 Oct 2009 22:49:17 +1000, Adam Nielsen wrote:
> > Ha, it worked perfectly:
> >=20
> > $ ./sensors
> > ...
> > odin-hid-3-12
> > Adapter: HID adapter
> > 3.3V:        +3.40 V
> > 5V:          +5.14 V
> > 5VSB:        +5.13 V
> > 12V1:       +12.11 V
> > 12V2:       +12.16 V
> > 12V3:       +12.15 V
> > 12V4:       +12.07 V
> > -12V:       -12.25 V
> > PSU Fan:    1095 RPM
> > System Fan:  700 RPM
> > Internal:    +40.0=B0C
> > External 1:   +0.0=B0C
> > External 2:   +0.0=B0C
> > External 3:   +0.0=B0C
> > External 4:   +0.0=B0C
> > 5V:          27.01 W
> > 12V1:        11.40 W
> > 12V2:        11.68 W
> > 12V3:        16.59 W
> > 12V4:        13.83 W
> > Total:       91.45 W
> > 5V:          +5.25 A
> > 5VSB:        +1.25 A
> > 12V1:        +0.94 A
> > 12V2:        +0.96 A
> > 12V3:        +1.37 A
> > 12V4:        +1.15 A
> > -12V:        +0.00 A
>=20
> Hey, very nice :) I'm waiting to see where the HID device names are
> going, and then I'll commit the code change.

As there doesn't seem to be any change planned in the immediate future,
I've committed my code as is. If the name format changes upstream,
we'll have to update libsensors accordingly.

> > Okay, I'll tidy it up and get it ready.  In order to run it you will ne=
ed the
> > following options enabled in your kernel (I have them all as modules):
> >=20
> > USB_GADGET (Device drivers, USB support, USB Gadget Support)
> > USB_GADGET_DUMMY_HCD (USB Gadget Support, USB Peripheral Controller, Du=
mmy HCD)
> > USB_GADGETFS (USB Gadget Support, USB Gadget Drivers, Gadget Filesystem)
>=20
> Building :)
>=20
> > I'll post instructions on what to do once the modules are loaded when I=
 post
> > the code shortly.
>=20
> Great, thanks.

Unfortunately I can't seem to find the time to test it, sorry.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

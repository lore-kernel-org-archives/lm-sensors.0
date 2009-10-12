From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Oct 2009 13:36:39 +0000
Subject: Re: [lm-sensors] How do you make lm_sensors see a hwmon device?
Message-Id: <20091012153639.372e9e56@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AD1E14B.90604@shikadi.net>
In-Reply-To: <4AD1E14B.90604@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Adam,

On Mon, 12 Oct 2009 22:49:17 +1000, Adam Nielsen wrote:
> > Ouch. This bus ID format is pretty nasty. It includes vendor and
> > product IDs, which really do not belong there. And the last part is an
> > auto-incremented counter, so it isn't stable.
> >=20
> > I've done what I could to make it fit in what libsensors expects, but
> > this is less than perfect. And I expect this bus ID format to evolve
> > over time, because I can't be the only one thinking it sucks. So we may
> > have to update libsensors for future kernels.
>=20
> Well if you need a unique per-device ID (unique if you connect multiple
> devices) then the USB bus number and the device ID you have chosen would =
seem
> to be the most appropriate.

Yes, that's what we want. Having to find out the parent device would
add some complexity to libsensors, but can certainly be done. OTOH I
guess HID devices aren't all USB-backed, so it might be hard to come up
with naming convention. Unless we give up on HID entirely and go with
odin-usb-something as the name. I admit I'm not sure yet. This device
of yours is really the first or its kind as far as the Linux kernel and
lm-sensors are concerned.

> If you need a value that is unique across reboots
> then I imagine the USB vendor/device ID would be the only option - this d=
evice
> doesn't seem to have a unique serial number as many USB devices do.

No, we already know that we can't get this in the real world.

> > For now, can you please send me the output of:
> > $ ls -l /sys/bus/hid/devices
>=20
> total 0
> drwxr-xr-x 2 root root 0 2009-10-12 22:35 .
> drwxr-xr-x 4 root root 0 2009-10-12 22:35 ..
> lrwxrwxrwx 1 root root 0 2009-10-12 22:35 0003:046D:C226.0001 ->
> ../../../devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2.1/3-2.1:1.0/0003:04=
6D:C226.0001
> lrwxrwxrwx 1 root root 0 2009-10-12 22:35 0003:046D:C226.0002 ->
> ../../../devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2.1/3-2.1:1.1/0003:04=
6D:C226.0002
> lrwxrwxrwx 1 root root 0 2009-10-12 22:35 0003:046D:C525.0003 ->
> ../../../devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2.2/3-2.2:1.0/0003:04=
6D:C525.0003
> lrwxrwxrwx 1 root root 0 2009-10-12 22:35 0003:046D:C525.0004 ->
> ../../../devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:04=
6D:C525.0004
> lrwxrwxrwx 1 root root 0 2009-10-12 22:35 0003:1044:4001.0012 ->
> ../../../devices/pci0000:00/0000:00:1d.2/usb8/8-1/8-1:1.0/0003:1044:4001.=
0012

Huu. Ugly.

> > OK, let's handle it as a HID device then. Experimental libsensors patch
> > at the end of this message, please give it a try and report. I couldn't
> > test it so there might be some rough edges left.
>=20
> Ha, it worked perfectly:
>=20
> $ ./sensors
> ...
> odin-hid-3-12
> Adapter: HID adapter
> 3.3V:        +3.40 V
> 5V:          +5.14 V
> 5VSB:        +5.13 V
> 12V1:       +12.11 V
> 12V2:       +12.16 V
> 12V3:       +12.15 V
> 12V4:       +12.07 V
> -12V:       -12.25 V
> PSU Fan:    1095 RPM
> System Fan:  700 RPM
> Internal:    +40.0=B0C
> External 1:   +0.0=B0C
> External 2:   +0.0=B0C
> External 3:   +0.0=B0C
> External 4:   +0.0=B0C
> 5V:          27.01 W
> 12V1:        11.40 W
> 12V2:        11.68 W
> 12V3:        16.59 W
> 12V4:        13.83 W
> Total:       91.45 W
> 5V:          +5.25 A
> 5VSB:        +1.25 A
> 12V1:        +0.94 A
> 12V2:        +0.96 A
> 12V3:        +1.37 A
> 12V4:        +1.15 A
> -12V:        +0.00 A

Hey, very nice :) I'm waiting to see where the HID device names are
going, and then I'll commit the code change.

> > This power supply unit you're working on seems pretty cool. Is this
> > something one can buy for his/her PC, or only meant for high end server
> > racks or something? Care to tell us the brand and model name? I would
> > love to have a monitorable PSU.
>=20
> Sure, it's a standard ATX power supply, comes in 550W and 800W versions. =
 Same
> USB ID/driver for both.  It's manufactured by Gigabyte, and it's called an
> Odin GT.  Manufacturer web page is here:
> http://www.gigabyte.com.tw/Products/PowerSupply/Products_Spec.aspx?Produc=
tID$90

I didn't know Gigabyte had joined the PSU business. So far I haven't
been impressed by their motherboards, I wonder how good their PSUs will
be. Relatively expensive models, but I'm convinced for a long time now
that good PSUs are worth the money.

It's a long time since I last bought a PSU, but I lost one - with the
motherboard it was feeding :( - a few months ago, so I might have to
buy a new one soon. Apparently there have been a number of improvements
in this area lately... "modular" PSUs seems like a very good idea to
me. And passively-cooled PSUs are now at an affordable price, although
I don't know how reliable they are these days. Time for me to read some
articles and reviews...

> If you buy one, be sure to let Gigabyte know you bought it because of the
> Linux support - they didn't want to give out any specs because they were
> worried it might send them out of business...

OK, if I buy it I'll let them know. How much Linux support do you have
at the moment? Just the monitoring shown above, or also control, e.g.
of the fan speed?

I see a huge potential for this type of PSU for the hardware monitoring
support area. We usually have a hard time figuring out wirings and
scaling factors for motherboard sensors. Now if we know what values we
should find, because the PSU is reporting them already, that would be
much easier.

We can also imagine that voltage sensors will disappear from
motherboards in the future. After all, monitoring the PSU voltages
directly makes a lot more sense, and if standardized properly, it could
be done with a single driver and all the scaling / mapping issues would
be solved. Dreaming :) Time will how (and where) it all goes.

> >> If it would help I can post a gadgetfs userspace program I wrote to em=
ulate
> >> the device.
> >=20
> > Yes, please post it together with explanations how to use it. If I can
> > emulate the device and test my libsensors patches myself, this should
> > be much faster.
>=20
> Okay, I'll tidy it up and get it ready.  In order to run it you will need=
 the
> following options enabled in your kernel (I have them all as modules):
>=20
> USB_GADGET (Device drivers, USB support, USB Gadget Support)
> USB_GADGET_DUMMY_HCD (USB Gadget Support, USB Peripheral Controller, Dumm=
y HCD)
> USB_GADGETFS (USB Gadget Support, USB Gadget Drivers, Gadget Filesystem)

Building :)

> I'll post instructions on what to do once the modules are loaded when I p=
ost
> the code shortly.

Great, thanks.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

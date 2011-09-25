From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 25 Sep 2011 18:12:08 +0000
Subject: Re: [lm-sensors] Zotac ION ITX-G Synergy Edition
Message-Id: <20110925181208.GA2214@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAL9G6WVbiEnRtAoA0Wzf7TLn0hXj3AQMtQrzSbC7keLFN795ow@mail.gmail.com>
In-Reply-To: <CAL9G6WVbiEnRtAoA0Wzf7TLn0hXj3AQMtQrzSbC7keLFN795ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Sep 25, 2011 at 01:42:19PM -0400, Josu Lazkano wrote:
> 2011/9/25 Guenter Roeck <guenter.roeck@ericsson.com>:
> > On Sun, Sep 25, 2011 at 12:27:48PM -0400, Josu Lazkano wrote:
> > [ ... ]
> >>
> >> Thanks for your reply, I have loaded the lm90 module:
> >>
> >> $ lsmod | grep lm90
> >> lm90 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A07728 =A00
> >> i2c_core =A0 =A0 =A0 =A0 =A0 =A0 =A0 12795 =A09
> >> i2c_dev,lm90,ds3000,cx23885,v4l2_common,videodev,nvidia,tveeprom,i2c_n=
force2
> >>
> >> Sorry, but I have no idea how to compile the driver for my kernel.
> >> Could you help with some steps?
> >>
> > Download all files from http://khali.linux-fr.org/devel/misc/lm90 into =
some directory,
> > then run
> > =A0 =A0 =A0 =A0make
> > =A0 =A0 =A0 =A0sudo make install
> > =A0 =A0 =A0 =A0sudo modprobe -r lm90
> > =A0 =A0 =A0 =A0sudo modprobe lm90
> >
> > Guenter
> >
>=20
> Thanks!!! Now I have more data, I make this:
>=20
> $ make
>   CC [M]  /home/lazkano/Desktop/lm90_driver/lm90.o
>   Building modules, stage 2.
>   MODPOST 1 modules
>   CC      /home/lazkano/Desktop/lm90_driver/lm90.mod.o
>   LD [M]  /home/lazkano/Desktop/lm90_driver/lm90.ko
>=20
> # make install
> test -d /lib/modules/2.6.32-5-686/kernel/drivers/hwmon || mkdir
> /lib/modules/2.6.32-5-686/kernel/drivers/hwmon
> cp lm90.ko /lib/modules/2.6.32-5-686/kernel/drivers/hwmon
> depmod -a -F /boot/System.map-2.6.32-5-686 2.6.32-5-686
>=20
> # modprobe -r lm90
>=20
> # modprobe lm90
>=20
> Then sensor-detect and I got this:
>=20
> # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +34.0=B0C  (crit =3D +90.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +34.0=B0C  (crit =3D +90.0=B0C)
>=20
> w83l771-i2c-0-4c
> Adapter: SMBus nForce2 adapter at 4d00
> temp1:       +54.0=B0C  (low  =3D -40.0=B0C, high =3D +70.0=B0C)
>                       (crit =3D +85.0=B0C, hyst =3D +75.0=B0C)
> temp2:       +65.4=B0C  (low  =3D -40.0=B0C, high =3D +70.0=B0C)
>                       (crit =3D +110.0=B0C, hyst =3D +100.0=B0C)
>=20
> Are this temps for my GPU?
>=20
No idea.

> I want to get USB voltage of my board, is this possible?
>=20
sensors-detect did not find any known chips, so this is unlikely.=20
The chipset seems to be NVIDIA MCP7A-ION, and Nvidia is not really
known to publish much if anything about their chips.

You could try to download and install linux drivers available from Zotac
and/or from Nvidia, but I don't know if that would help. I did not find a=20
linux hw monitoring driver to download anyway.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

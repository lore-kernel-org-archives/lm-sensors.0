From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Nov 2009 08:54:49 +0000
Subject: Re: [lm-sensors] ADT7490 support
Message-Id: <20091130095449.2eae2667@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
In-Reply-To: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Justin,

On Sun, 29 Nov 2009 15:32:37 -0500 (EST), Justin Piszcz wrote:
> On Sun, 29 Nov 2009, Jean Delvare wrote:
> > I have added support for the ADT7490 to the adt7475 driver. My current
> > work is available for you to test if you are still interested:
> >
> > http://khali.linux-fr.org/devel/misc/adt7490/
> >
> > This is a standalone driver, you'll need a proper build environment
> > then type "make" the load the driver.
> >
> > If you prefer, I can also provide a patch for whatever kernel version
> > you're running.
> >
> > There are still a few configuration cases that aren't properly
> > supported, I'll work on that later as my time permits.
>=20
> First test run is as follows:
>=20
> $ make
>    CC [M]  /home/user/a/adt7475.o
>    Building modules, stage 2.
>    MODPOST 1 modules
>    CC      /home/user/a/adt7475.mod.o
>    LD [M]  /home/user/a/adt7475.ko
> 0.44user 0.12system 0:01.73elapsed 32%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (12major+93517minor)pagefaults 0swaps
>=20
> $ sudo insmod adt7475.ko=20
> $
>=20
> $ sensors
> adt7490-i2c-0-2c
> Adapter: SMBus I801 adapter at 7000
> in0:         +1.52 V  (min =3D  +0.00 V, max =3D  +3.31 V)=20
> in1:         +0.87 V  (min =3D  +0.00 V, max =3D  +2.99 V)=20
> in2:         +3.31 V  (min =3D  +0.00 V, max =3D  +4.39 V)=20
> in3:         +5.12 V  (min =3D  +0.00 V, max =3D  +6.68 V)=20
> in4:        +12.01 V  (min =3D  +0.00 V, max =3D +15.69 V)=20
> in5:         +2.21 V  (min =3D  +0.00 V, max =3D  +4.48 V)=20
> fan1:       1345 RPM  (min =3D    0 RPM)
> fan2:       1415 RPM  (min =3D    0 RPM)
> fan3:        767 RPM  (min =3D    0 RPM)
> fan4:        978 RPM  (min =3D    0 RPM)
> temp1:         FAULT  (low  =3D -127.0=B0C, high =3D +127.0=B0C)  ALARM
>                        (crit =3D +100.0=B0C, hyst =3D +100.0=B0C)=20
> temp2:       +42.2=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>                        (crit =3D +65.0=B0C, hyst =3D +61.0=B0C)=20
> temp3:       +46.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>                        (crit =3D +65.0=B0C, hyst =3D +61.0=B0C)

Thanks for the fast test and report. Looks overall OK. Do you actually
have 4 fans in this system?

> Why does temp1 say fault?

The driver merely reports what the chip says. According to the dump you
sent on October 16th, register 0x25 has value 0x80, bits [3:2] of
register 0x76 have value 11b, this is a temperature value of -127.25=B0C.
The fault is confirmed by bit 4 of register 0x41 (1b) and bit 6 of
register 0x42 (1b) which stand for temp1 out of limits and temp1 open
or short circuit, respectively.

> All of the temps in the BIOS report properly.

Can you please copy all the information reported by the BIOS and send
it over? It will be interesting to compare what the BIOS says with what
the adt7475 driver reports.

The above output suggests that temp1 isn't used on your system, temp2 is
internal to the ADT7490 so it would be the motherboard temperature,
while temp3 would likely be the CPU temperature. Does the BIOS report
more than 2 temperature values?

I think we can use the following as the default configuration for the
ADT7490:

chip "adt7490-*"

    label in1 "Vcore"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"

    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10
    set in3_min  5.0 * 0.90
    set in3_max  5.0 * 1.10
    set in4_min 12.0 * 0.90
    set in4_max 12.0 * 1.10

    label temp2 "M/B Temp"


> James, does this happen to you too?

James, if/when you report the results of your tests with the modified
adt7475 driver, please also send a dump of your chip (using the i2c-dev
driver and i2cdump from the i2c-tools package.)

Thanks,
--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

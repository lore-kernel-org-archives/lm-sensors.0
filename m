From: =?iso-8859-1?B?Sm9zZSDBbHZhcmV6?= <dynamix66@hotmail.com>
Date: Sun, 01 May 2011 12:35:32 +0000
Subject: Re: [lm-sensors] HELP with  and [msi p67a-gd65]
Message-Id: <SNT141-w50B24B9A8381CED810A8E3A19C0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT141-w55955A6C97713857828A23A19C0@phx.gbl>
In-Reply-To: <SNT141-w55955A6C97713857828A23A19C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


SOLVED!!=A0thank you=A0both!

----------------------------------------
> Date: Sun, 1 May 2011 13:35:25 +0200
> From: khali@linux-fr.org
> To: dynamix66@hotmail.com
> CC: i.dobson@planet-ian.com; lm-sensors@lm-sensors.org; hdegoede@redhat.c=
om
> Subject: Re: [lm-sensors] HELP with and [msi p67a-gd65]
>
> On Sun, 1 May 2011 11:03:59 +0000, Jose =C1lvarez wrote:
> > > Chip ID 0x1005appears to be a F71889 a standalone drive is available =
here
> > > http://people.fedoraproject.org/~jwrdegoede/f71882fg/
> > >
> > > Just manually download the driver to some directory than do a make &&=
 sudo
> > > make install && modprobe f71882fg
>
> FWIW, the "official" (i.e. somewhat maintained and reasonably
> up-to-date) standalone version of the f71882fg driver is the one at:
> http://khali.linux-fr.org/devel/misc/f71882fg/
>
> Hans, maybe you should remove yours altogether, to avoid confusion?
>
> Generic instructions are available at:
> http://khali.linux-fr.org/devel/misc/INSTALL
>
> > thanks for responding so quickly, amazing
> >
> > I'll try with that driver
> >
> > one question ...
> >
> > > Do you want to probe the I2C/SMBus adapters now? (YES / no):
> > > Using driver `i2c-i801 'for device 0000:00:1 f.3: Intel Cougar Point =
(PCH)
> > > Module i2c-i801 loaded successfully.
> > > i2c-dev Module loaded successfully.
> >
> > why i2c-i801 not come out in the summary of sensors-detect to add it to=
 /etc / modules? is not necessary?
>
> Because 1* i2c-i801 is not a hwmon driver, it's only an accessor driver
> in case there are hwmon devices in the SMBus, which isn't your case and
> 2* the i2c-i801 driver is typically loaded automatically thanks to
> module aliases and udev anyway.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
 		 	   		 =20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

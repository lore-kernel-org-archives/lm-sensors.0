From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 15 Jul 2015 17:44:53 +0000
Subject: Re: [lm-sensors] support for IT8586E
Message-Id: <20150715174453.GA30206@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANOLSHBWuQCpJTUT3aNi7_rqPwPT4QK7CkVxvhcuyfm4qqFw8g@mail.gmail.com>
In-Reply-To: <CANOLSHBWuQCpJTUT3aNi7_rqPwPT4QK7CkVxvhcuyfm4qqFw8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Jul 15, 2015 at 12:27:04PM -0400, Dev Anand wrote:
> Thanks Jean and Guenter,
>=20
> There is no /proc/acpi/fan or /proc/acpi/thermal_zone folder but, I do see
> /proc/acpi/button and /proc/acpi/wakeup.
> Is there any guide on how to setup the ACPI fan control?
>=20
Did you try to load the acpi modules Jean suggested ?=20

Guenter

> Regards,
> Dev
>=20
> $sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +37.8=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +100.0=B0C, hyst =3D +99.0=B0C)
>=20
> fam15h_power-pci-00c4
> Adapter: PCI adapter
> power1:           N/A  (crit =3D  18.96 W)
>=20
> $sudo sensors-detect
> .....
> AMD Family 15h thermal sensors...                           Success!
>     (driver `k10temp')
> .....
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): YES
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor/ITE'...               No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor/ITE'...               Yes
> Found unknown chip with ID 0x8586
> ....
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>=20
> Driver `k10temp' (autoloaded):
>   * Chip `AMD Family 15h thermal sensors' (confidence: 9)
>=20
> No modules to load, skipping modules configuration.
>=20
> Unloading cpuid... OK
>=20
>=20
> $sudo pwmconfig
> ...
> /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
>=20
>=20
> On Wed, Jul 15, 2015 at 10:37 AM, Guenter Roeck <linux@roeck-us.net> wrot=
e:
>=20
> > On Wed, Jul 15, 2015 at 09:46:26AM +0200, Jean Delvare wrote:
> > > Hi Dev,
> > >
> > > On Tue, 14 Jul 2015 23:27:41 -0400, Dev Anand wrote:
> > > > I got myself a Lenovo z50-75. The fan is always on. And, sensors-de=
tect
> > > > reports the following.
> > > >
> > > > Trying family `ITE'...                                      No
> > > >
> > > > Probing for Super-I/O at 0x4e/0x4f
> > > >
> > > > Trying family `National Semiconductor/ITE'...               Yes
> > > >
> > > > Found unknown chip with ID 0x8586
> > > >
> > > >
> > > > Appears to be IT8586E. Are there any plans of supporting this chip.=
 I
> > don't
> > > > see it listed on the http://www.lm-sensors.org/wiki/Devices web sit=
e.
> > >
> > > It's not listed on ITE's website either. Never heard of that chip. I'=
ve
> > > added an entry in the wiki, with your request. But without a datasheet
> > > there's nothing we can do.
> > >
> > I think this is an embedded controller, not a legacy Super-IO chip.
> > Trying the ACPI drivers you mentioned below might be the best option.
> >
> > Guenter
> >
> > > Please note that on a laptop the fan is most certainly controlled by
> > > ACPI anyway so a driver for the IT8586E would not necessarily help. If
> > > the fan does not behave the way it should, you should check the BIOS
> > > options and report the problem to the linux-acpi ACPI.
> > >
> > > Also check the thinkpad_acpi and ideapad-laptop kernel drivers. There
> > > is no explicit mention of your laptop model there but other Lenovo
> > > laptops are supported so maybe support for your model could/should be
> > > added there.
> > >
> > > --
> > > Jean Delvare
> > > SUSE L3 Support
> > >
> > > _______________________________________________
> > > lm-sensors mailing list
> > > lm-sensors@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 14 Aug 2011 17:47:08 +0000
Subject: Re: [lm-sensors] lm_sensors: sensors output
Message-Id: <20110814174708.GA5790@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAv-bCz-NKoaLr3=L8_AkEg2fQyuadHrh=kQax89_bu3H-mUxg@mail.gmail.com>
In-Reply-To: <CAAv-bCz-NKoaLr3=L8_AkEg2fQyuadHrh=kQax89_bu3H-mUxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Aug 13, 2011 at 06:44:53AM -0400, Jo=E3o M. S. Silva wrote:
> Hi,
>=20
> Yes, the sensors daemon is loading it:
>=20
> [jmss@steklov ~]$ lsmod |grep it87
> it87                   19266  0
> hwmon_vid               2056  1 it87
>=20
> When I restart the sensors daemon it prints this to the system log:
> Aug 13 11:45:04 localhost kernel: [32388.581173] it87: Found IT8705F
> chip at 0x290, revision 2
>=20
Guess we'll have to wait for feedback from the it87 driver folks.

On a side note, please don't top-post.

Thanks,
Guenter

> On Fri, Aug 12, 2011 at 7:32 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Fri, Aug 12, 2011 at 07:06:07AM -0400, Jo=E3o M. S. Silva wrote:
> >> Hi,
> >>
> >> When I type "sensors", I get:
> >>
> >> acpitz-virtual-0
> >> Adapter: Virtual device
> >> temp1: =A0 =A0 =A0 =A0+51.0=B0C =A0(crit =3D +105.0=B0C)
> >>
> >> and nothing else. I can't seem to get the chipset info.
> >>
> >> "sensors-detect" detected:
> >>
> >> (...)
> >> Now follows a summary of the probes I have just done.
> >> Just press ENTER to continue:
> >>
> >> Driver `it87':
> >> =A0 * ISA bus, address 0x290
> >> =A0 =A0 Chip `ITE IT8705F Super IO Sensors' (confidence: 9)
> >>
> >> Do you want to generate /etc/conf.d/lm_sensors? (YES/no):
> >> You should now start the lm_sensors service to load the required
> >> kernel modules.
> >>
> >> Unloading i2c-dev... OK
> >> Unloading cpuid... OK
> >> (...)
> >>
> >> Why doesn't "sensors" print it87-related info?
> >>
> >> I don't know if it is related, but sometimes the temperature gets very
> >> high (I notice it with my fingers) and I have to reboot; then the fan
> >> runs at full speed for about 2 min to cool the CPU.
> >>
> >> Any help?
> >>
> > Did you add it87 to the list of modules to load, and is it loaded ?
> > You should see that with the "lsmod" command.
> >
> > Guenter
> >
>=20
>=20
>=20
> --=20
> Jo=E3o M. S. Silva

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

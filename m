From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 12 Aug 2011 18:32:12 +0000
Subject: Re: [lm-sensors] lm_sensors: sensors output
Message-Id: <20110812183212.GA25265@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAv-bCz-NKoaLr3=L8_AkEg2fQyuadHrh=kQax89_bu3H-mUxg@mail.gmail.com>
In-Reply-To: <CAAv-bCz-NKoaLr3=L8_AkEg2fQyuadHrh=kQax89_bu3H-mUxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Aug 12, 2011 at 07:06:07AM -0400, Jo=E3o M. S. Silva wrote:
> Hi,
>=20
> When I type "sensors", I get:
>=20
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +51.0=B0C  (crit =3D +105.0=B0C)
>=20
> and nothing else. I can't seem to get the chipset info.
>=20
> "sensors-detect" detected:
>=20
> (...)
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>=20
> Driver `it87':
>   * ISA bus, address 0x290
>     Chip `ITE IT8705F Super IO Sensors' (confidence: 9)
>=20
> Do you want to generate /etc/conf.d/lm_sensors? (YES/no):
> You should now start the lm_sensors service to load the required
> kernel modules.
>=20
> Unloading i2c-dev... OK
> Unloading cpuid... OK
> (...)
>=20
> Why doesn't "sensors" print it87-related info?
>=20
> I don't know if it is related, but sometimes the temperature gets very
> high (I notice it with my fingers) and I have to reboot; then the fan
> runs at full speed for about 2 min to cool the CPU.
>=20
> Any help?
>=20
Did you add it87 to the list of modules to load, and is it loaded ?
You should see that with the "lsmod" command.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 17 Dec 2014 16:27:12 +0000
Subject: Re: [lm-sensors] Supermicro X7DBU configuration
Message-Id: <20141217162712.GA27228@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU175-DS1275A243EB8731D1852460E66C0@phx.gbl>
In-Reply-To: <BLU175-DS1275A243EB8731D1852460E66C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Dec 17, 2014 at 04:47:58PM +0100, Jean Delvare wrote:
> Le Wednesday 17 December 2014 =E0 06:43 -0800, Guenter Roeck a =E9crit :
> > On 12/17/2014 02:08 AM, Jean Delvare wrote:
> > > This chip is missing from the output of "sensors" below. You need to
> > > figure out why. Is the w83793 kernel module available on your system?
> > > Is it loaded? If not, what happens if you try to load it manually? Any
> > > error message in the kernel log? The fans are certainly connected to
> > > that chip.
> >=20
> > Hardware monitoring might be disabled for this chip. I have seen this
> > with other Supermicro boards; on mine, for example, they use the second
> > SuperIO chip only for additional serial ports. The kernel log might
> > give a hint if that is the case.
>=20
> I doubt this is the case here, as the W83793G is a dedicated hardware
> monitoring chip. There's no point in putting it on the board if they
> don't use the feature.
>=20
> > Another option might be that the missing chip is the one used for hardw=
are
> > monitoring but its register space is reserved by ACPI. That would expla=
in
> > why the chip listed below doesn't report much useful data. Again, the
> > kernel log should give a hint.
>=20
> I don't think this can happen for an SMBus device. If the SMBus
> controller had an ACPI I/O resource conflict, sensors-detect would not
> have been able to scan it. And there is no notion of I2C/SMBus resource
> space in ACPI.
>=20
Good point. Maybe the w83793 driver is simply not loaded.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

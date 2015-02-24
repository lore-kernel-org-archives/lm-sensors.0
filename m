From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 24 Feb 2015 16:41:08 +0000
Subject: Re: [lm-sensors] Test with Chip IT8620E on a Gigabyte GA-H97M-HD3 version 2
Message-Id: <20150224164108.GA12671@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU436-SMTP1351904A8E5B1CC00D893290240@phx.gbl>
In-Reply-To: <BLU436-SMTP1351904A8E5B1CC00D893290240@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Feb 24, 2015 at 04:23:01PM +0100, Jean Delvare wrote:
> On Tue, 24 Feb 2015 16:15:09 +0100, cedric wrote:
> > Le 24/02/2015 14:21, Jean Delvare a =E9crit
> > >> chip "coretemp-isa-0000"
> > >>
> > >> # ark.intel.com
> > >> # maxi 72 degrees C
> > >>
> > >> label temp1 "CPU Temp"
> > >> compute temp1  @ + 10, @ / @ - 10
> > >> compute temp2  @ + 10, @ / @ - 10
> > >> compute temp3  @ + 10, @ / @ - 10
> > > Which CPU model is this? If the coretemp driver doesn't get TjMax
> > > right, it should be fixed.
> >=20
> > It's a Intel Pentium G3258.
>=20
> What's the CPU ID of this model (family/model/stepping
> in /proc/cpuinfo)?
>=20
> > ark.intel.com :Tcase_     72=B0C
>=20
> This is Tcase, not TjMax. They represent different limits.
>=20
This is a Haswell based chip. It is very unlikely that it doesn't
support reading TjMax from the CPU. Also, Information available
online (search for Pentium G3258 tjmax) suggests that TjMax is
100 degrees C.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 Jan 2010 18:14:26 +0000
Subject: Re: [lm-sensors] hwmon: (coretemp) Check the sensor existence
Message-Id: <20100108191426.5dd85c23@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100108160144.GA23650@owl>
In-Reply-To: <20100108160144.GA23650@owl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 9 Jan 2010 00:01:44 +0800, Huaxu Wan wrote:
> On 11:28 Fri 08 Jan, Jean Delvare wrote:
> > Hi Huaxu,
> >=20
> > On Fri, 8 Jan 2010 17:23:27 +0800, Huaxu Wan wrote:
> > >=20
> > >     hwmon: (coretemp) Check the sensor existence instead of enumerati=
on.
> > >=20
> > >     The processor supports a digital thermal sensor if CPUID.06H.EAX[=
0] =3D 1.
> > >=20
> > >     Signed-off-by: Huaxu Wan <huaxu.wan@linux.intel.com>
> > >=20
> > > ---
> > >  Documentation/hwmon/coretemp |    3 ---
> > >  drivers/hwmon/coretemp.c     |   24 +++++++-----------------
> > >  2 files changed, 7 insertions(+), 20 deletions(-)
> > >=20
> >=20
> > Hmm. I don't like it for two reasons:
> >=20
> > * Which guarantee do we have that "the processor supports a digital
> >   thermal sensor" implies that this digital thermal sensor is
> >   compatible with what the Core/Core2/Atom have? Couldn't the format
> >   change in the future?
>=20
> It's quote from page 612 of Software Developer=E2=80=99s Manual V3A[1](14=
.5.5 On
> Die Digital Thermal Sensors). Look from the history, I think it's
> compatible with Core/Core2/Atom and even the feature CPU. Actually, this
> patch has tested on old P4, Core2, i3(launched today?) system, all works
> as expected.
>=20
> [1] http://www.intel.com/Assets/PDF/manual/253668.pdf

$ wget http://www.intel.com/Assets/PDF/manual/253668.pdf
--2010-01-08 19:05:33--  http://www.intel.com/Assets/PDF/manual/253668.pdf
Resolving www.intel.com... 88.221.93.91, 88.221.93.112
Connecting to www.intel.com|88.221.93.91|:80... connected.
HTTP request sent, awaiting response... 403 Forbidden
2010-01-08 19:05:33 ERROR 403: Forbidden.
$=20

I am not worried about past models. I am worried about future models
which could feature a different implementation of the thermal sensor.

> > * Each CPU model has its own high temperature limit, which we use to
> >   compute the current temperature. So we can't pretend that we support
> >   all future CPU models, we really do not. Just look at how complex
> >   function adjust_tjmax is.
> >
>=20
> TjMax varies with specific CPU series, sometimes even different within
> same modle for industrial temperature. At this point, we can't support
> all feature CPU models, but we can support all the released CPUs. I had
> a plan to make an investigation about those.
>=20
> > It would only make sense to have "universal" support if the driver
> > could report a relative value. Unfortunately our sysfs interface
> > doesn't support this, although there have been discussions on that
> > topic lately:
> >=20
> > http://thread.gmane.org/gmane.linux.drivers.sensors/20721/focus=917317
> >=20
>=20
> This patch avoid to patch everytime for new release CPU. We foucs on
> the adjust_tjmax function calibration. I think the effort is much less
> than calibration for each CPU model.

Effort is one thing. Telling the user that we support his/her CPU when
we don't really (and thus potentially report wrong temperature values)
is another. I think this is simply not acceptable.

> BTW, I saw openBSD[2] use the CPUID.06H.EAX[0] to identify the sensor.
>=20
> [2] http://archives.neohapsis.com/archives/openbsd/2007-05/2506.html

I am not opposed to using this bit. What I am opposed to is using this
bit as a replacement for the list of known supported CPU models. This
bit could be used to exit quickly on unsupported models and let the
user know when they have a CPU that isn't yet supported but could be.
That would be better than our current code for that.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

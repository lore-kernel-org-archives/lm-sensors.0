From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Fri, 08 Jan 2010 16:01:44 +0000
Subject: Re: [lm-sensors] hwmon: (coretemp) Check the sensor existence
Message-Id: <20100108160144.GA23650@owl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 11:28 Fri 08 Jan, Jean Delvare wrote:
> Hi Huaxu,
>=20
> On Fri, 8 Jan 2010 17:23:27 +0800, Huaxu Wan wrote:
> >=20
> >     hwmon: (coretemp) Check the sensor existence instead of enumeration.
> >=20
> >     The processor supports a digital thermal sensor if CPUID.06H.EAX[0]=
 =3D 1.
> >=20
> >     Signed-off-by: Huaxu Wan <huaxu.wan@linux.intel.com>
> >=20
> > ---
> >  Documentation/hwmon/coretemp |    3 ---
> >  drivers/hwmon/coretemp.c     |   24 +++++++-----------------
> >  2 files changed, 7 insertions(+), 20 deletions(-)
> >=20
>=20
> Hmm. I don't like it for two reasons:
>=20
> * Which guarantee do we have that "the processor supports a digital
>   thermal sensor" implies that this digital thermal sensor is
>   compatible with what the Core/Core2/Atom have? Couldn't the format
>   change in the future?

It's quote from page 612 of Software Developer=E2=80=99s Manual V3A[1](14.5=
.5 On
Die Digital Thermal Sensors). Look from the history, I think it's
compatible with Core/Core2/Atom and even the feature CPU. Actually, this
patch has tested on old P4, Core2, i3(launched today?) system, all works
as expected.

[1] http://www.intel.com/Assets/PDF/manual/253668.pdf

> * Each CPU model has its own high temperature limit, which we use to
>   compute the current temperature. So we can't pretend that we support
>   all future CPU models, we really do not. Just look at how complex
>   function adjust_tjmax is.
>

TjMax varies with specific CPU series, sometimes even different within
same modle for industrial temperature. At this point, we can't support
all feature CPU models, but we can support all the released CPUs. I had
a plan to make an investigation about those.

> It would only make sense to have "universal" support if the driver
> could report a relative value. Unfortunately our sysfs interface
> doesn't support this, although there have been discussions on that
> topic lately:
>=20
> http://thread.gmane.org/gmane.linux.drivers.sensors/20721/focus=917317
>=20

This patch avoid to patch everytime for new release CPU. We foucs on
the adjust_tjmax function calibration. I think the effort is much less
than calibration for each CPU model.

BTW, I saw openBSD[2] use the CPUID.06H.EAX[0] to identify the sensor.

[2] http://archives.neohapsis.com/archives/openbsd/2007-05/2506.html

--=20
Thanks
Huaxu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Jul 2012 21:11:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Don't reset hysteresis on device removal
Message-Id: <20120726211147.GA16693@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120726145745.0bc82f8d@endymion.delvare>
In-Reply-To: <20120726145745.0bc82f8d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Jul 26, 2012 at 09:59:36PM +0200, Jean Delvare wrote:
> Hi Guenter,
>=20
> On Thu, 26 Jul 2012 06:37:50 -0700, Guenter Roeck wrote:
> > On Thu, Jul 26, 2012 at 02:57:45PM +0200, Jean Delvare wrote:
> > > Restoring the configuration register on device removal has the side
> > > effect of also resetting the hysteresis value. This is inconsistent as
> > > the other limits are not reset, only hysteresis. So, following the
> > > principle of least surprise, preserve the hysteresis value when
> > > restoring the configuration register.
> > >=20
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> >=20
> > Good catch. Applied.
>=20
> Doh, please drop it, the patch is buggy. I wrote | where I meant & and
> this hard-codes the hysteresis to -6=B0C at driver removal if the config
> register changed. I didn't notice during my testing because config
> doesn't change for me. Sorry for the noise.
>=20
.... and I didn't notice it wither, and had to look at the code for a while=
 to
find it. Doh as well.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Sep 2011 16:18:00 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110912181800.01e9f3de@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter, Durgadoss,

Sorry for the very late comment.

On Wed, 13 Jul 2011 13:48:11 -0700, Guenter Roeck wrote:
> On Tue, 2011-07-12 at 07:07 -0400, Durgadoss R wrote:=20
> > This patch adds the core and pkg support to coretemp.
> > These thresholds can be configured via the sysfs interfaces tempX_max
> > and tempX_max_hyst. An interrupt is generated when CPU temperature reac=
hes
> > or crosses above tempX_max OR drops below tempX_max_hyst.
> >=20
> > This patch is based on the documentation in IA Manual vol 3A, that can =
be
> > downloaded from here:
> > http://download.intel.com/design/processor/manuals/253668.pdf
> >=20
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
>=20
> Looks like it is working now, so I applied the patch to -next.

Working, really? That's not how it looks like from here.

On my Xeon E5520, the output looked like this before the patch:

coretemp-isa-0000
Core 0:       +61.0=B0C  (high =3D +87.0=B0C, crit =3D +97.0=B0C)
Core 1:       +56.0=B0C  (high =3D +87.0=B0C, crit =3D +97.0=B0C)
Core 2:       +57.0=B0C  (high =3D +87.0=B0C, crit =3D +97.0=B0C)
Core 3:       +56.0=B0C  (high =3D +87.0=B0C, crit =3D +97.0=B0C)

And now it looks like this :

coretemp-isa-0000
Core 0:       +61.0=B0C  (high =3D +97.0=B0C, hyst =3D  +0.0=B0C)
                       (crit =3D +97.0=B0C)
Core 1:       +57.0=B0C  (high =3D +97.0=B0C, hyst =3D  +0.0=B0C)
                       (crit =3D +97.0=B0C)
Core 2:       +60.0=B0C  (high =3D +97.0=B0C, hyst =3D  +0.0=B0C)
                       (crit =3D +97.0=B0C)
Core 3:       +56.0=B0C  (high =3D +97.0=B0C, hyst =3D  +0.0=B0C)
                       (crit =3D +97.0=B0C)

High =3D crit doesn't make much sense, and neither does hyst =3D 0.

Looking at the code, it seems that the hyst value (tmin) is simply
never read from the CPU. I wrote a fix, I'll send it shortly. After
properly initializing tmin, I get the following:

coretemp-isa-0000
Core 0:       +61.0=B0C  (high =3D +97.0=B0C, hyst =3D +97.0=B0C)
                       (crit =3D +97.0=B0C)
Core 1:       +57.0=B0C  (high =3D +97.0=B0C, hyst =3D +97.0=B0C)
                       (crit =3D +97.0=B0C)
Core 2:       +59.0=B0C  (high =3D +97.0=B0C, hyst =3D +97.0=B0C)
                       (crit =3D +97.0=B0C)
Core 3:       +56.0=B0C  (high =3D +97.0=B0C, hyst =3D +97.0=B0C)
                       (crit =3D +97.0=B0C)

I am still suspicious... Does this mean that the thermal interrupt
mechanism is disabled by default?

What happened to the old high limit value (87=B0C)? I don't know what
meaning it had physically but at least the value was reasonable.

How comes that the driver doesn't use THERM_INT_THRESHOLD0_ENABLE and
THERM_INT_THRESHOLD1_ENABLE? If the thresholds can be disabled, then
the driver should certainly handle these cases.

On my Core Duo T2600n the output looks like:

coretemp-isa-0000
Core 0:      +54.0=B0C  (high =3D +47.0=B0C, hyst =3D +64.0=B0C)  ALARM
                      (crit =3D +100.0=B0C)
Core 1:      +55.0=B0C  (high =3D +47.0=B0C, hyst =3D +64.0=B0C)  ALARM
                      (crit =3D +100.0=B0C)

High at 47=B0C by default seems unreasonable, and hyst > high even more
so. But at least the ALARM flags are consistent with these limits.

Lastly, on Core2 Duo E6400, I get this :

coretemp-isa-0000
Core 0:       +71.0=B0C  (high =3D +100.0=B0C, hyst =3D +100.0=B0C)
                       (crit =3D +100.0=B0C)
Core 1:       +69.0=B0C  (high =3D +100.0=B0C, hyst =3D +100.0=B0C)
                       (crit =3D +100.0=B0C)

So problem is the same as on my Xeon E5520: it looks like the
thresholds are disabled?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 01 May 2014 07:00:57 +0000
Subject: Re: [lm-sensors] [PATCH] Revert "hwmon: (coretemp) Refine TjMax detection"
Message-Id: <20140501090057.4e86c8b3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 30 Apr 2014 14:14:54 -0700, Guenter Roeck wrote:
> This reverts commit 9fb6c9c73b11bef65ba80a362547fd116c1e1c9d.
>=20
> Tjmax on some Intel CPUs is below 85 degrees C. One known example is
> L5630 with Tjmax of 71 degrees C. Also, the Intel IA32 System Programming

Looking at the coretemp driver documentation file, there are more Xeon
series processors which have TjMax below 85=B0C. 80=B0C and 70=B0C appear to
be common values.

> document states that the temperature target is in bits 23:16 of MSR 0x1a2
> (MSR_TEMPERATURE_TARGET), which that's 8 bits, not 7.
>=20
> So even if turbostst uses similar checks to validate Tjmax, there is no
> evidence that the checks are actually required. On the contrary, the chec=
ks
> are known to cause problems and therefore need to be removed.

Therefore I think turbostat needs to be fixed too. I'll send a patch
later today.

Also, a reference to the bugzilla report which is fixed by this revert
should be included in the commit message.

> Fixes: 9fb6c9c hwmon: (coretemp) Refine TjMax detection
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I'll add Cc: stable when pushing the patch.
>=20
>  drivers/hwmon/coretemp.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 6d02e3b..d76f0b7 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -365,12 +365,12 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id,=
 struct device *dev)
>  		if (cpu_has_tjmax(c))
>  			dev_warn(dev, "Unable to read TjMax from CPU %u\n", id);
>  	} else {
> -		val =3D (eax >> 16) & 0x7f;
> +		val =3D (eax >> 16) & 0xff;
>  		/*
>  		 * If the TjMax is not plausible, an assumption
>  		 * will be used
>  		 */
> -		if (val >=3D 85) {
> +		if (val) {
>  			dev_dbg(dev, "TjMax is %d degrees C\n", val);
>  			return val * 1000;
>  		}

Reviewed-by: Jean Delvare <jdelvare@suse.de>

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

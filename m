From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 31 May 2011 17:15:12 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Fix TjMax detection
Message-Id: <20110531191512.4c16f310@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306851320-7851-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1306851320-7851-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 31 May 2011 07:15:20 -0700, Guenter Roeck wrote:
> Commit a321cedb12904114e2ba5041a3673ca24deb09c9 excludes CPU models 0xe, =
0xf,
> and 0x16 from TjMax temperature adjustment, even though several of those =
CPUs
> are known to have TiMax other than 100 degrees C, and even though the cod=
e in
> adjust_tjmax() explicitly handles those CPUs and points to a Web document
> listing several of the affected CPU IDs.

Good catch. Tested on a Core Duo T2600 (model ID 0xe), your patch gets
rid of the "TjMax is assumed as 100 C!" warning message.

> Reinstate TjMax adjustment for CPUs with model ID 0xe, 0xf, and 0x16.

But then why not 0x1a as well? The documentation lists a number of
Nehalem-based processors with TjMax 90 or 105=B0C. It seems that
adjust_tjmax() would figure it out properly, so we should just call it?

What about 0x1e (Lynnfield)? It was already supported prior to
Carsten's changes. I don't know when MSR_IA32_TEMPERATURE_TARGET was
introduced, but again I see no reason why adjust_tjmax() wouldn't be
good for Lynnfield - at least as good as blindly assuming TjMax at
100=B0C.

BTW, I am curious why we read MSR_IA32_TEMPERATURE_TARGET on CPU models
which we know do _not_ have this MSR? This leads to a warning message
in the logs. It would seem more logical to call adjust_tjmax() directly
if MSR_IA32_TEMPERATURE_TARGET isn't supported.

> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Huaxu Wan <huaxu.wan@linux.intel.com>
> Cc: Carsten Emde <C.Emde@osadl.org>
> Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Yong Wang <yong.y.wang@linux.intel.com>
> Cc: Rudolf Marek <r.marek@assembler.cz>
> ---
> Reason for sending this as RFC is that I don't know if the original chang=
e to
> exclude the affected CPU IDs from adjustment was made on purpose or not. =
Please
> let me know if you recall the reasons for this exclusion.

If anybody knows, that would be Carsten, as he wrote the code. Me, as
the original commit description did NOT mention the change, AND we got
at least one complaint about the regression, I wouldn't hesitate to
apply your proposed fix. I even think it should go to stable@kernel.org.

So, this version or one covering more models, is:

Acked-by: Jean Delvare <khali@linux-fr.org>

>=20
>  drivers/hwmon/coretemp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index de3d246..897a257 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -308,12 +308,12 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id,=
 struct device *dev)
>  	 */
> =20
>  	switch (c->x86_model) {
> -	case 0xe:
> -	case 0xf:
> -	case 0x16:
>  	case 0x1a:
>  		dev_warn(dev, "TjMax is assumed as 100 C!\n");
>  		return 100000;
> +	case 0xe:
> +	case 0xf:
> +	case 0x16:		/* Core 2 CPUs */
>  	case 0x17:
>  	case 0x1c:		/* Atom CPUs */
>  		return adjust_tjmax(c, id, dev);


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

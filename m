From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 09 Oct 2008 07:46:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] abituguru3: enable reading from AUX3
Message-Id: <48EDB6DF.4080700@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1223485560-3806-2-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1223485560-3806-2-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Alistair John Strachan wrote:
> The table for the Abit AT8 32X was incorrectly missing an entry
> for the sixth ("AUX3") fan. Add this entry, exporting the fan
> reading to userspace.
> 
> Closes lm-sensors.org ticket #2339.
> 
> Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
> Tested-by: Daniel Exner <dex@dragonslave.de>

Looks good,

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: lm-sensors@lm-sensors.org
> 
> ---
> 
>  drivers/hwmon/abituguru3.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
> index d568c65..4545194 100644
> --- a/drivers/hwmon/abituguru3.c
> +++ b/drivers/hwmon/abituguru3.c
> @@ -303,6 +303,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
>  		{ "SYS Fan",		34, 2, 60, 1, 0 },
>  		{ "AUX1 Fan",		35, 2, 60, 1, 0 },
>  		{ "AUX2 Fan",		36, 2, 60, 1, 0 },
> +		{ "AUX3 Fan",		37, 2, 60, 1, 0 },
>  		{ NULL, 0, 0, 0, 0, 0 } }
>  	},
>  	{ 0x0012, NULL /* Abit AN8 32X, need DMI string */, {
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

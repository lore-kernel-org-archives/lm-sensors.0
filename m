From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jun 2008 16:18:50 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon (hwmon-vid): add 6-bit vid codes
Message-Id: <20080623181850.6968ffd0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48508DAE.8040401@fhmtech.com>
In-Reply-To: <48508DAE.8040401@fhmtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Jun 2008 12:06:26 -0400, Frank Myhr wrote:
> Jean,
> 
> Thanks for your comments. Sorry for my slow response, I was on vacation and
> then have been getting my head around quilt. Anyway, I think the below patch
> fixes the problems you noticed.

Time well spent, I'd say. quilt rocks.

> Signed-off-by: Frank Myhr <fmyhr@fhmtech.com>
> ---
> 
> Index: linux/drivers/hwmon/hwmon-vid.c
> =================================> --- linux.orig/drivers/hwmon/hwmon-vid.c	2008-06-23 10:27:37.000000000 -0400
> +++ linux/drivers/hwmon/hwmon-vid.c	2008-06-23 11:29:35.000000000 -0400
> @@ -37,18 +37,14 @@
>   * For VRD 10.0 and up, "VRD x.y Design Guide",
>   * available at http://developer.intel.com/.
>   *
> + * AMD NPT 0Fh (Athlon64 & Opteron), AMD Publication 32559,
> + * http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
> + * Table 71. VID Code Voltages
>   * AMD Opteron processors don't follow the Intel specifications.
>   * I'm going to "make up" 2.4 as the spec number for the Opterons.
>   * No good reason just a mnemonic for the 24x Opteron processor
>   * series.
>   *
> - * Opteron VID encoding is:
> - *    00000  =  1.550 V
> - *    00001  =  1.525 V
> - *     . . . .
> - *    11110  =  0.800 V
> - *    11111  =  0.000 V (off)
> - *
>   * The 17 specification is in fact Intel Mobile Voltage Positioning -
>   * (IMVP-II). You can find more information in the datasheet of Max1718
>   * http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2452
> @@ -98,9 +94,11 @@
>  		if (val < 0x02 || val > 0xb2)
>  			return 0;
>  		return((1600000 - (val - 2) * 6250 + 500) / 1000);
> -	case 24:                /* Opteron processor */
> -		val &= 0x1f;
> -		return(val = 0x1f ? 0 : 1550 - val * 25);
> +
> +	case 24:		/* AMD NPT 0Fh (Athlon64 & Opteron) */
> +		val &= 0x3f;
> +		return (val < 32) ? 1550 - 25 * val
> +			: 775 - (25 * (val - 31)) / 2;
> 
>  	case 91:		/* VRM 9.1 */
>  	case 90:		/* VRM 9.0 */

Looks good to me:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

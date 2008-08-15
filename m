From: Frank Myhr <fmyhr@fhmtech.com>
Date: Fri, 15 Aug 2008 12:00:13 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon-vid: Fix AMD K8 VID decoding
Message-Id: <48A56FCD.4030505@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080815105805.5d8231ce@hyperion.delvare>
In-Reply-To: <20080815105805.5d8231ce@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Your v3 patch looks good to me. A few comments below:


Jean Delvare wrote:
> Not all AMD K8 have 6 VID pins, contrary to what was assumed in
> commit 116d0486bdefc11f71e567cadf0c47f788b4dd06. This commit broke
> support of older CPU models which have only 5 VID pins:
> http://bugzilla.kernel.org/show_bug.cgi?id329
> 
> We need two entries in the hwmon-vid table, one for 5-bit VID models
> (K8 revision <= E) and one for 6-bit VID models (K8 revision >= F).
> This fixes bug #11329.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Acked-by: Frank Myhr <fmyhr@fhmtech.com>
> Tested-by: Jean-Luc Coulon <jean.luc.coulon@gmail.com>
> ---
>  drivers/hwmon/hwmon-vid.c |   36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> --- linux-2.6.27-rc3.orig/drivers/hwmon/hwmon-vid.c	2008-08-13 09:50:50.000000000 +0200
> +++ linux-2.6.27-rc3/drivers/hwmon/hwmon-vid.c	2008-08-15 09:48:17.000000000 +0200
> @@ -37,13 +37,21 @@
>   * For VRD 10.0 and up, "VRD x.y Design Guide",
>   * available at http://developer.intel.com/.
>   *
> - * AMD NPT 0Fh (Athlon64 & Opteron), AMD Publication 32559,
> + * AMD Athlon 64 and AMD Opteron Processors, AMD Publication 26094,
> + * http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26094.PDF
> + * Table 74. VID Code Voltages
> + * This corresponds to an arbitrary VRM code of 24 in the functions below.
> + * These CPU models (K8 revision <= E) have 5 VID pins. See also:
> + * Revision Guide for AMD Athlon 64 and AMD Opteron Processors, AMD Publication 25759,
> + * http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/25759.pdf
> + *
> + * AMD NPT Family 0Fh Processors, AMD Publication 32559,
>   * http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
>   * Table 71. VID Code Voltages
> - * AMD Opteron processors don't follow the Intel specifications.
> - * I'm going to "make up" 2.4 as the spec number for the Opterons.
> - * No good reason just a mnemonic for the 24x Opteron processor
> - * series.
> + * This corresponds to an arbitrary VRM code of 25 in the functions below.
> + * These CPU models (K8 revision >= F) have 6 VID pins. See also:
> + * Revision Guide for AMD NPT Family 0Fh Processors, AMD Publication 33610,
> + * http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/33610.pdf

Succinct explanation with refs, I like it!


> -	case 24:		/* AMD NPT 0Fh (Athlon64 & Opteron) */
> +	case 24:		/* Athlon64 & Opteron */
> +		val &= 0x1f;
> +		if (val = 0x1f)
> +			return 0;

Nice catch that all bits set is an error (voltage "off", impossible if code is
running) for the 5-vid-bit cpu's but not the 6-vid-bit ones in case 25


> +				/* fall through */
> +	case 25:		/* AMD NPT 0Fh */
>  		val &= 0x3f;
>  		return (val < 32) ? 1550 - 25 * val
>  			: 775 - (25 * (val - 31)) / 2;

The above formula is correct, and I'm the one who put it here in this form. But
in looking at AMD cpu specs yesterday I came across:

AMD 31116, BIOS and Kernel Developer's Guide (BKDG) For AMD Family 10h Processors
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/31116.PDF
section 2.4.1.5.2, p. 30

This gives the canonical formula for K10's, which happens to be the same as for
the 6-vid-pin K8's:

return (val >= 0x20) ? (7625 - 125 * (val - 0x20)) / 10
	: 1550 - 25 * val;

This gives the same result and is easier to compare with the AMD reference
above. Perhaps we should make this change, I'll leave it up to you.


Thanks,
Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jun 2008 08:47:48 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon (hwmon-vid): add 6-bit vid codes
Message-Id: <20080616104748.49b7ca34@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48508DAE.8040401@fhmtech.com>
In-Reply-To: <48508DAE.8040401@fhmtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frank,

On Wed, 11 Jun 2008 22:45:02 -0400, Frank Myhr wrote:
> AMD NPT 0Fh cpus use 6 bit VID codes. Successive codes with msb 0
> describe 25mV decrements, while those with msb 1 describe 12.5mV decrements.
> Existing hwmon-vid.c is correct only for codes with msb 0; this patch adds
> support for the codes with msb 1.
> 
> Ref:
> p 309, Table 71
> AMD Publication 32559, BIOS and Kernel Developer's Guide for AMD NPT Family 0Fh Processors
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf

Ah, excellent. I didn't know there was a public specification for the
Opteron VID encoding. And I didn't know that these were 6-bit VID
codes. Thanks for the pointer :)

> 
> Signed-off-by: Frank Myhr <fmyhr@fhmtech.com>
> ---
> 
> --- linux-2.6.26-rc5_before/drivers/hwmon/hwmon-vid.c   2008-06-11 18:09:26.000000000 -0400
> +++ linux-2.6.26-rc5_after/drivers/hwmon/hwmon-vid.c    2008-06-11 18:35:55.000000000 -0400
> @@ -37,17 +37,26 @@
>   * For VRD 10.0 and up, "VRD x.y Design Guide",
>   * available at http://developer.intel.com/.
>   *
> + * AMD NPT 0Fh (Athlon64 & Opteron), AMD Publication 32559,
> + * http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf

Might be a good idea to mention the name and number of the relevant
table? I'd expect these to be stable across document updates (unlike
the page number).

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
> + * AMD NPT 0Fh VID encoding is:
> + *     VID[5:0]    Voltage [V]  Delta [mV]
> + *     --------    -----------  ---------
> + *     00 0000         1.550
> + *     00 0001         1.525   -25
> + *     . . . .
> + *     01 1110         0.800
> + *     01 1111         0.775   -25
> + *     10 0000         0.7625  -12.5
> + *     10 0001         0.7500  -12.5
> + *     . . . .
> + *     11 1110         0.3875
> + *     11 1111         0.3750  -12.5

I don't think there's much point in duplicating the table which you
already referenced. It was there before only due to the lack of
reference document.

>   *
>   * The 17 specification is in fact Intel Mobile Voltage Positioning -
>   * (IMVP-II). You can find more information in the datasheet of Max1718
> @@ -98,9 +107,11 @@ int vid_from_reg(int val, u8 vrm)
>                 if (val < 0x02 || val > 0xb2)
>                         return 0;

Eeek. Your mailer converted all tabs to spaces, so you patch doesn't
apply. Please correct and resubmit.

>                 return((1600000 - (val - 2) * 6250 + 500) / 1000);
> -       case 24:                /* Opteron processor */
> -               val &= 0x1f;
> -               return(val = 0x1f ? 0 : 1550 - val * 25);
> +
> +       case 24:                /* AMD NPT 0Fh (Athlon64 & Opteron) */
> +               val &= 0x3f;
> +               return((val < 32) ? 1550 - 25 * val

Note that return is not a function, so it doesn't need parentheses
(scripts/checkpatch.pl should have told you.)

> +                       : 775 - (25 * (val - 31)) / 2);
> 
>         case 91:                /* VRM 9.1 */
>         case 90:                /* VRM 9.0 */

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

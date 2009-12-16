From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 16 Dec 2009 19:32:42 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] Need ADT7462_PIN29_SHIFT for
Message-Id: <20091216193242.GD10356@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AFEAE911EE22F64BACAB05ED86B4D4FC018DA313@EXVBE012-13.exch012.intermedia.net> <AFEAE911EE22F64BACAB05ED86B4D4FC018DA31C@EXVBE012-13.exch012.intermedia.net>
In-Reply-To: <AFEAE911EE22F64BACAB05ED86B4D4FC018DA31C@EXVBE012-13.exch012.intermedia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ray Copeland <ray.copeland@aprius.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Arvind Vasudev <arvind.vasudev@aprius.com>

On Wed, Dec 16, 2009 at 10:08:51AM -0800, Ray Copeland wrote:
> From: Ray Copeland <ray.copeland@aprius.com>
> Date: Wed, 16 Dec 2009
> Subject: [PATCH 2/2] Need ADT7462_PIN29_SHIFT for pin_cfg[3] linux-2.6.30 adt7462 hwmon driver
> 
> Description:
> 
> The driver uses the following expression (parentheses added for clarity) 
> to test if the +1.5V ICH/3GPIO voltages are configured:
> 
> if (((data->pin_cfg[3] >> ADT7462_PIN28_SHIFT) = ADT7462_PIN28_VOLT) &&
> !(data->pin_cfg[0] & ADT7462_VID_INPUT))
> 
> With "#define ADT7462_PIN28_SHIFT 6" this will never equate to "#define
> ADT7462_PIN28_VOLT 5" because that shifts in only the PIN28 +1.5V ICH value 
> and misses the PIN29 +1.5V 3GPIO value.  It is the combination of both these 
> values that equates to 5 if the voltages are configured. 
> 
> Note the logic is essentially correct in that both these voltages must
> be configured together, meaning you can't set one to +1.5V and have the 
> other be something else.  Also, I think the logic just got a little confused 
> thinking that pin 28 comes first (bit-position wise) in the pin_cfg[3], but 
> actually the order of bits from ms to ls is pin28/29 not pin 29/28.
> 
> Signed-off-by: Ray Copeland <ray.copeland@aprius.com>
> 
> Diff with changes vs. original adt7462.c 2.6.30 version:
> 
> --- adt7462.c	2009-12-15 15:57:47.000000000 -0800
> +++ adt7462.c.orig	2009-12-15 15:51:05.000000000 -0800
> @@ -97,7 +97,6 @@
>  #define		ADT7462_PIN24_SHIFT		6
>  #define		ADT7462_PIN26_VOLT_INPUT	0x08
>  #define		ADT7462_PIN25_VOLT_INPUT	0x20
> -#define		ADT7462_PIN29_SHIFT		4	/* cfg3 */
>  #define		ADT7462_PIN28_SHIFT		6	/* cfg3 */
>  #define		ADT7462_PIN28_VOLT		0x5
>  
> @@ -183,7 +182,7 @@
>   *
>   * Some, but not all, of these voltages have low/high limits.
>   */
> -#define ADT7462_VOLT_COUNT	13
> +#define ADT7462_VOLT_COUNT	12

I think this VOLT_COUNT adjustment only belongs in the first patch, and the
PIN29_SHIFT changes belong only in this second patch.

Also, I think this patch has been reversed accidentally as well.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

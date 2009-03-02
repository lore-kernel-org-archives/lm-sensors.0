From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 02 Mar 2009 23:04:26 +0000
Subject: Re: [lm-sensors] [PATCH] lm90: Support the MAX6648/6692 chips
Message-Id: <20090302150426.b22100c1.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090302210106.GD6550@plum>
In-Reply-To: <20090302210106.GD6550@plum>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: djwong@us.ibm.com
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, 2 Mar 2009 13:01:06 -0800
"Darrick J. Wong" <djwong@us.ibm.com> wrote:

> @@ -776,7 +776,12 @@ static int lm90_detect(struct i2c_client *new_client, int kind,
>  			 && (reg_config1 & 0x3f) = 0x00
>  			 && reg_convrate <= 0x07) {
>  				kind = max6646;
> -			}
> +			} else
> +			/* The MAX6648/6692 chips have a working man/chip id
> +			 * and the same register set as the 6657.
> +			 */
> +			if (chip_id = 0x59 && address = 0x4C)
> +				kind = max6657;
>  		}

gack, the indenting and layout there is totally busted.


--- a/drivers/hwmon/lm90.c~lm90-support-the-max6648-6692-chips-fix
+++ a/drivers/hwmon/lm90.c
@@ -776,12 +776,14 @@ static int lm90_detect(struct i2c_client
 			 && (reg_config1 & 0x3f) = 0x00
 			 && reg_convrate <= 0x07) {
 				kind = max6646;
-			} else
-			/* The MAX6648/6692 chips have a working man/chip id
-			 * and the same register set as the 6657.
-			 */
-			if (chip_id = 0x59 && address = 0x4C)
+			} else if (chip_id = 0x59 && address = 0x4C) {
+				/*
+				 * The MAX6648/6692 chips have a working
+				 * man/chip id and the same register set as the
+				 * 6657.
+				 */
 				kind = max6657;
+			}
 		}
 
 		if (kind <= 0) { /* identification failed */
_


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

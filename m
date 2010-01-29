From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 29 Jan 2010 18:26:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adt7462) Wrong ADT7462_VOLT_COUNT
Message-Id: <20100129182607.GF29604@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100129144652.62d0b210@hyperion.delvare>
In-Reply-To: <20100129144652.62d0b210@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 29, 2010 at 02:46:52PM +0100, Jean Delvare wrote:
> From: Ray Copeland <ray.copeland@aprius.com>
> Subject: hwmon: (adt7462) Wrong ADT7462_VOLT_COUNT
> 
> The #define ADT7462_VOLT_COUNT is wrong, it should be 13 not 12. All the 
> for loops that use this as a limit count are of the typical form, "for 
> (n = 0; n < ADT7462_VOLT_COUNT; n++)", so to loop through all voltages 
> w/o missing the last one it is necessary for the count to be one greater 
> than it is.  (Specifically, you will miss the +1.5V 3GPIO input with count 
> = 12 vs. 13.)
> 
> Signed-off-by: Ray Copeland <ray.copeland@aprius.com>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: "Darrick J. Wong" <djwong@us.ibm.com>
> Cc: stable@kernel.org

Oh yes, this patch.  I recall discussing this one earlier, so:
Acked-by: Darrick J. Wong <djwong@us.ibm.com>

--D

> ---
>  drivers/hwmon/adt7462.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.33-rc5.orig/drivers/hwmon/adt7462.c	2010-01-13 09:16:42.000000000 +0100
> +++ linux-2.6.33-rc5/drivers/hwmon/adt7462.c	2010-01-29 14:31:31.000000000 +0100
> @@ -179,7 +179,7 @@ static const unsigned short normal_i2c[]
>   *
>   * Some, but not all, of these voltages have low/high limits.
>   */
> -#define ADT7462_VOLT_COUNT	12
> +#define ADT7462_VOLT_COUNT	13
> 
>  #define ADT7462_VENDOR		0x41
>  #define ADT7462_DEVICE		0x62
> 
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

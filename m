From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 04 Mar 2008 17:13:41 +0000
Subject: Re: [lm-sensors] [RFC/PATCH] hwmon: fix common race conditions,
Message-Id: <20080304171341.GF9446@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080304145440.GE2892@jupiter.solarsys.private>
In-Reply-To: <20080304145440.GE2892@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 04, 2008 at 09:54:40AM -0500, Mark M. Hoffman wrote:

<snip>
> diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
> index 9587869..3807062 100644
> --- a/drivers/hwmon/adt7473.c
> +++ b/drivers/hwmon/adt7473.c
> @@ -422,11 +422,9 @@ static ssize_t show_volt(struct device *dev, struct device_attribute *devattr,
>   * number in the range -128 to 127, or as an unsigned number that must
>   * be offset by 64.
>   */
> -static int decode_temp(struct adt7473_data *data, u8 raw)
> +static int decode_temp(u8 twos_complement, u8 raw)
>  {
> -	if (data->temp_twos_complement)
> -		return (s8)raw;
> -	return raw - 64;
> +	return twos_complement ? (s8)raw : raw - 64;

Since this patch is to fix a bunch of race conditions, I think this chunk
would be better off as a separate cleanup patch.  That said, you're the
maintainer, so it's your call.... :)

I also suspect that ibmpex/i5k-amb will need similar cleanups.  I can
generate patches if you want, though if you're intent upon fixing all of
the drivers as one big push, let me know.

For the adt7470/adt7473 bits,
Acked-by: Darrick J. Wong <djwong@us.ibm.com>

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

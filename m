From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Jun 2013 07:41:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1021) Strengthen chip detection for LM84 and MAX1617
Message-Id: <20130606094106.314c54b3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370467996-27091-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1370467996-27091-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed,  5 Jun 2013 14:33:16 -0700, Guenter Roeck wrote:
> On a system with both MAX1617A and JC42 sensors, JC42 sensors can be misdetected
> as LM84. Strengthen detection sufficiently enough to avoid this misdetection at
> least in some cases. Code follows example in sensors-detect script.

Good idea.

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Still pretty weak detection. Any suggestions for improvements are welcome.

As I was comparing the code in sensors-detect with the detection code
in the adm1021 driver, I noticed another difference. In sensors-detect,
the ADM1021 is identified with ($rev & 0xf0) = 0x00, while this check
doesn't exist in adm1021_detect(). I think it should be added to avoid
other false positives.

Detection of the MAX1617 is weak by nature, I don't think there's much
we can do about it. Even the extra checks you picked from
sensors-detect are only heuristics and could theoretically lead to
missed detections. But I think the only alternative is to drop
detection of these chips altogether - which I'd rather avoid. Missed detections can always be fixed 

> 
>  drivers/hwmon/adm1021.c |   36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
> index 7e76922..8b342b8 100644
> --- a/drivers/hwmon/adm1021.c
> +++ b/drivers/hwmon/adm1021.c
> @@ -344,13 +344,35 @@ static int adm1021_detect(struct i2c_client *client,
>  		type_name = "gl523sm";
>  	else if (man_id = 0x54)
>  		type_name = "mc1066";
> -	/* LM84 Mfr ID in a different place, and it has more unused bits */
> -	else if (conv_rate = 0x00
> -		 && (config & 0x7F) = 0x00
> -		 && (status & 0xAB) = 0x00)
> -		type_name = "lm84";
> -	else
> -		type_name = "max1617";
> +	else {
> +		int lte, rte, lhi, rhi, llo;
> +
> +		/* extra checks for LM84 and MAX1617 to avoid misdetections */
> +
> +		lte = i2c_smbus_read_byte_data(client, 0x00);
> +		rte = i2c_smbus_read_byte_data(client, 0x01);
> +		lhi = i2c_smbus_read_byte_data(client, 0x05);
> +		rhi = i2c_smbus_read_byte_data(client, 0x07);
> +		llo = i2c_smbus_read_byte_data(client, 0x06);

The sensors-detect code also reads rlo from 0x08, why don't you? I
think we should have the exact same detection logic in sensors-detect
and the adm1021 driver. If you are worried by performance then you can
swap the order of the tests and check for negative temperatures first,
that can be done one or two registers at a time.

Also these registers have a name in the adm1021 driver, you could use
these names to improve code readability?

> +
> +		if (lte = rte && lte = lhi && lte = rhi && lte = llo)
> +			return -ENODEV;
> +		if ((lte & 0x80) || (rte & 0x80) || (lhi & 0x80)
> +		    || (rhi & 0x80))
> +			return -ENODEV;

The sensors-detect code has nice comments explaining the tests, please
include them here too.

You have omitted on set of tests: low limits over high limits. Is this
on purpose? If you think this test is bad then it should be removed
from sensors-detect. If not, please add it to adm1021_detect().

> +
> +		/*
> +		 * LM84 Mfr ID is in a different place,
> +		 * and it has more unused bits.
> +		 */
> +		if (conv_rate = 0x00
> +		    && (config & 0x7F) = 0x00
> +		    && (status & 0xAB) = 0x00) {
> +			type_name = "lm84";
> +		} else {
> +			type_name = "max1617";
> +		}
> +	}
>  
>  	pr_debug("Detected chip %s at adapter %d, address 0x%02x.\n",
>  		 type_name, i2c_adapter_id(adapter), client->addr);

Last note: sensors-detect claims that these tests are missing from the
adm1021 driver. As you are adding them now, that comment should be
removed or updated.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

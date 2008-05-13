From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 May 2008 13:21:58 +0000
Subject: Re: [lm-sensors] [PATCH 3/3 RESEND] hwmon (dme1737): add support
Message-Id: <20080513152158.734869ff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0805122141m5e31adc4w4984b89d5d759e08@mail.gmail.com>
In-Reply-To: <191fb4ca0805122141m5e31adc4w4984b89d5d759e08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Mon, 12 May 2008 21:41:05 -0700, Juerg Haefliger wrote:
> Add support for the SCH5027. The differences to the DME1737 are:
> - No support for programmable temp offsets
> - In auto mode, PWM outputs stay on min value if temp goes below low threshold
>   and can't be programmed to fully turn off
> - Different voltage scaling
> - No VID input
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
> 
> ---
> Incorporated suggestions from Jean Delvare.

Almost OK, I only have 2 remaining comments, the first of which I think
really needs to be addressed:

> -	kind = dme1737;
> -	name = "dme1737";
> +	if (kind = sch5027) {
> +		name = "sch5027";
> +	} else {
> +		name = "dme1737";
> +	}
>  	data->type = kind;

At this point data->type could be 0 (if the user passed a force
parameter). It _happens_ that right now your driver makes no explicit
test on data->type = dme1737 (nor != dme1737) and all the tests happen
to default to the dme1737 case so 0 and dme1737 will be treated the
same (as far as I can see at least), so it works, however this is
pretty fragile I think. A future code change could break this case and
you probably wouldn't notice. I'd rather see you set kind = dme1737 at
the same time you're setting name = "dme1737", to make sure that
data->type always has a correct value and this value in sync with the
device name.

> +	data->in_nominal = IN_NOMINAL(data->type);

This is common to the I2C and ISA cases so it could be moved to
dme1737_init_device() to avoid code redundancy.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 03 Mar 2011 19:12:03 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add support for LTC4151
Message-Id: <1299179523.18605.6.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <44705.79.160.13.2.1299179601.squirrel@webmail.s7.itpays.net>
In-Reply-To: <44705.79.160.13.2.1299179601.squirrel@webmail.s7.itpays.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Per,

On Thu, 2011-03-03 at 14:13 -0500, per.dalen@appeartv.com wrote:
> LTC4151 is High Voltage I2C Current and Voltage Monitor from Linear
> Technology.
> 
> Signed-off-by: Per Dalen <per.dalen@appeartv.com>
> 
Almost ok, except

[ ... ]

> +	case LTC4151_SENSE_H:
> +		/*
> +		 * 20uV resolution. Convert to current as measured with
> +		 * an 1 uOhm sense resistor, in mA.

	1 mOhm

No need to resubmit; I'll take care of that.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

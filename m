From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 19 Oct 2010 22:03:45 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <1287525825.9690.313.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
In-Reply-To: <1287330612-11256-1-git-send-email-simon@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

one more comment ...

On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
[ ... ]
> +static int __devinit
> +fan_alarm_init(struct gpio_fan_data *fan_data, struct gpio_fan_alarm *alarm)
> +{

__devinit and __devexit can cause problems if this driver is built into
the kernel, but the underlying i2c master driver is built as module.

So please remove __devinit and __devexit.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

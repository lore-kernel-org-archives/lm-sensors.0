From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 22 Feb 2012 17:46:20 +0000
Subject: Re: [lm-sensors] [PATCH V5] hwmon: Add MCP3021 ADC driver
Message-Id: <1329932780.23014.88.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329897332-18383-1-git-send-email-X.Xie@freescale.com>
In-Reply-To: <1329897332-18383-1-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-22 at 02:55 -0500, Xie Xiaobo wrote:
> Add I2C driver for MCP3021 that is an ADC chip from Microchip.
> The MCP3021 is a successive approximation A/D converter (ADC)
> with 10-bit resolution.
> The driver export the value of Vin to sysfs, the voltage unit is
> mV. Through the sysfs interface, lm-sensors tool can also display
> Vin voltage.
> 
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>

[ ... ]

> +
> +	if (reg < 0) {
> +		printk(KERN_ERR "%s encountered error %d\n", __func__, reg);

You should use dev_err() here.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

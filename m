From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 18 Sep 2010 15:04:29 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: LTC4261 Hardware monitoring driver
Message-Id: <20100918150429.GB27155@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284784361-18893-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284784361-18893-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 18, 2010 at 12:32:41AM -0400, Guenter Roeck wrote:
> This driver adds support for Linear Technology LTC4261 I2C Negative
> Voltage Hot Swap Controller.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
[...]

> +
> +/* chip registers */
> +#define	LTC4261_STATUS	0x00	/* readonly */
> +#define	LTC4261_FAULT	0x01
> +#define	LTC4261_ALERT	0x02
> +#define	LTC4261_CONTROL	0x03
> +#define	LTC4261_SENSE_H	0x04
> +#define	LTC4261_SENSE_L	0x05
> +#define	LTC4261_ADIN2_H	0x06
> +#define	LTC4261_ADIN2_L	0x07
> +#define	LTC4261_ADIN_H	0x08
> +#define	LTC4261_ADIN_L	0x09
> +

Wretched tab after define. Always hits me. I'll fix that
with the next version of the patch. No need to comment.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

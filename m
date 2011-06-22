From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 22 Jun 2011 19:15:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: LM95245 driver
Message-Id: <1308770149.8271.600.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308649953-2774-1-git-send-email-alexander.stein@systec-electronic.com>
In-Reply-To: <1308649953-2774-1-git-send-email-alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2011-06-21 at 05:52 -0400, Alexander Stein wrote:
> An hwmon driver for the National Semiconductor LM95245 dual temperature
> sensors chip.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Overall pretty well written, only I am a bit at loss why you try to deal
with the unsigned temperature registers. That adds a bit of complexity
to the driver. Given that the signed temperature value range is up to
127 degrees C, and that the chip is only rated up to 125 degrees C, the
added complexity doesn't seem to be worth it.

Can you elaborate ?

Other comments:

For the interval attribute, idea would be to write the value into the
conversion rate register. Your code does not match the interval with the
rate programmed into the chip (which is the idea), nor does it update
the rate if the interval is changed.

Chip address 0x29 is missing.

It would be nice if the driver would support limit, hysteresis, alarm,
and fault attributes.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

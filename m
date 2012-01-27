From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Jan 2012 21:35:29 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon/mc13xxx-adc: add support for the MC13892 PMIC
Message-Id: <20120127223529.35fe6561@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 27 Jan 2012 13:22:08 -0800, Guenter Roeck wrote:
> I have been asked about adding support for ADC channels 0, 1, 3, 4, as
> well as the non-GP usage of channels 5 to 7.

I'm interested in temperature sensors too, i.e. channels 5 and 7 if I'm
not mistaken.

> Does anyone happen to know/recall why those are not supported in the
> current driver ?

No idea, maybe just starting simple, or lack of interest.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

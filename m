From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 13 Aug 2009 14:16:31 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] [hwmon] add Freescale MC13783 adc
Message-Id: <20090813141631.GB23607@rakim.wolfsonmicro.main>
List-Id: <lm-sensors.vger.kernel.org>
References: <1250089531-10399-1-git-send-email-s.hauer@pengutronix.de>
 <1250089531-10399-2-git-send-email-s.hauer@pengutronix.de>
 <1250089531-10399-3-git-send-email-s.hauer@pengutronix.de>
 <1250089531-10399-4-git-send-email-s.hauer@pengutronix.de>
 <20090812164252.GE11227@sirena.org.uk>
 <20090813133747.GJ17992@pengutronix.de>
In-Reply-To: <20090813133747.GJ17992@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc.net>, Luotao Fu <l.fu@pengutronix.de>, lm-sensors@lm-sensors.org, Hans de Goede <hdegoede@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, Aug 13, 2009 at 03:37:47PM +0200, Sascha Hauer wrote:

> +0	Battery Voltage (BATT)				2.50 – 4.65V	-2.40V
> +1	Battery Current (BATT – BATTISNS)		-50 - 50 mV	x20
> +2	Application Supply (BP)				2.50 – 4.65V	-2.40V
> +3	Charger Voltage (CHRGRAW)			0 – 10V /	/5
> +							0 – 20V		/10
> +4	Charger Current (CHRGISNSP-CHRGISNSN)		-0.25V – 0.25V	X4
> +5	General Purpose ADIN5 / Battery Pack Thermistor	0 – 2.30V	No
> +6	General Purpose ADIN6 / Backup Voltage (LICELL)	0 – 2.30V /	No /
> +							1.50 – 3.50V	-1.20V
> +7	General Purpose ADIN7 / UID / Die Temperature	0 – 2.30V /	No /
> +							0 – 2.55V /	x0.9 / No

If you can report actual voltages it'd be desirable for the driver to do
the required conversions - it looks like you're just reporting the raw
ADC values?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

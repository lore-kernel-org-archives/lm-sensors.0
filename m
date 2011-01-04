From: Urs Fleisch <urs.fleisch@gmail.com>
Date: Tue, 04 Jan 2011 19:00:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: driver for Sensirion SHT21 humidity
Message-Id: <20110104200001.3328dae3.urs.fleisch@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101229134511.cc466ac0.urs.fleisch@gmail.com>
	<4D1DF097.1080200@cam.ac.uk>
	<20110103081448.f96c413e.urs.fleisch@gmail.com>
	<4D21ADCB.4070206@cam.ac.uk>
	<1294078159.9786.9.camel@groeck-laptop>
	<4D230ED0.8060008@cam.ac.uk>
	<20110104152837.GA32138@ericsson.com>
In-Reply-To: <20110104152837.GA32138@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>

> Uses I know of are indeed more general environment monitoring.
> Not seen one of these in conventional hardware monitoring but could be wrong.
> I guess, Urs will have a better idea of where these tend to be used?

Mobile phones could be a promising market for humidity sensors in a Linux system. Fujitsu already sells a mobile phone with built-in temperature and humidity sensors. So we hope to see also Linux-based mobile phones (e.g. Android, MeGoo) with a humidity sensor. Such a sensor could be used to monitor environmental conditions, but there could be other applications too, some of them may not make sense and others can not be foreseen. The humidity sensor could also be used to monitor the hardware of the phone, in this situation, hwmon makes sense. If a sensor can be used for various application, there is probably not one true category. There may be other sensors in hwmon, which can be used for applications other than hardware monitoring. I chose the hwmon directory because the sht15 was already there.

> Highly unusual way of detecting and returning errors.

If this is a problem, I can alter the code. I could also drop all user-register related attributes if they cause problems with the ABI.

Regards,
Urs

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

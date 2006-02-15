From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 15 Feb 2006 11:18:24 +0000
Subject: [lm-sensors] w83781d and empty /sys/class/hwmon
Message-Id: <7jqNfyvT.1140002304.9171290.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
In-Reply-To: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Victor

> Strange thing, in kernel 2.6.15.4 I have following modules loaded w83781d,
> hwmon_vid, hwmon, w83781d, i2c_isa, i2c_piix4, i2c_dev,
> i2c_core.

Hm, do you really have w83781d loaded twice? I hope not ;)

> But directory /sys/class/hwmon is empty, and sensors -s does not work!

Does the device show under /sys/bus/i2c/devices?

Does "sensors" (without -s) work?

--
Jean Delvare


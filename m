From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: ADM1032 driver
Message-Id: <20031103221310.2fca1c0e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

I just wanted to let you know that we have a driver for the ADM1032
since yesterday. Analog Devices kindly sent an evaluation board to me,
so I could add support for the chip to my lm90 driver and test it. It
works OK, at least for me, altough many extra features are not supported
yet. The main reason is that I believe there's no need to support them,
but I'll of course add the required code if you think there is a need.

To get the latest version of the i2c and lm_sensors packages, follow the
instructions here:
http://secure.netroedge.com/~lm78/download.html#cvs

The ADM1032 chipset is supported by the lm90 driver, which is part of
lm_sensors.

Please let me know how it works for you!

Regards,

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

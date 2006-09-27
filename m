From: ralf@boomerangsworld.de (Ralf Hoffmann)
Date: Wed, 27 Sep 2006 08:21:31 +0000
Subject: [lm-sensors] k8temp and it8716 support
Message-Id: <451A348B.80205@boomerangsworld.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I just want to drop a note that the kernel patches for it8716 and k8temp
work well so far on my GA-M55plus-S3G motherboard with an Athlon X2.
It's a 2.6.18 kernel and a lm-sensors SVN version from a few days ago
using the default configuration.

The sensor values look reasonable. One of the three temperatures of the
it8716 chip matches roughly the temperature from the k8temp driver.
Another value should be the system/chipset temperature but I have no
idea what the third is about (but it's not constant).

The voltages look okay but the min values are all zero.

Best Regards,

Ralf Hoffmann

-- 
Homepage: http://www.boomerangsworld.de
E-Mail: Ralf Hoffmann <ralf at boomerangsworld.de>
  English or German


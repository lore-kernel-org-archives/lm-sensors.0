From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Thu, 26 Jul 2007 21:18:31 +0000
Subject: [lm-sensors] lmsensors 2.x: how to hide entry from 2.4 driver that
Message-Id: <20070726231831.9f5c2ad1.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

The THMC50 driver for the 2.4 kernel has a feature called "die code". It does not exists in the 2.6 driver. How should I hide it so no message:

"ERROR: Can't get feature `die_code' data!"

is not displayed.

Another question is to how to hide one of tempX features if it does not exists (it depends on chip working mode). The chip name is the same for both modes.

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

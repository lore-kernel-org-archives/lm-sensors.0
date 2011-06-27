From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Mon, 27 Jun 2011 10:20:51 +0000
Subject: [lm-sensors] coretemp: Support for Intel Atom E6XX CPU
Message-Id: <201106271220.51953.alexander.stein@systec-electronic.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hello,

I have a patch (for v2.6.39) which adds support for Intel Atom E6XX 
(TunnelCreek) to coretemp. It's merely only adding x86_model 0x26.
But there are models (e.g. E660 and E660T) with different TjMax, namely 90 
degrees C and 110 degrees C. But these different model can't be detected by 
reading from hardware.
IMO there should be some support to adjust the temperature from userspace. 
Reading Documentation/hwmon/sysfs-interface only temp1_offset seems to be 
useable. But I think it is somewhat misleading (especially on multicores), 
because there must only be one offset.
What do you think about this?

Regards,
Alexander

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

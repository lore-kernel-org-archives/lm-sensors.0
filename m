From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 11 Oct 2010 23:47:57 +0000
Subject: [lm-sensors] Problem with detection or PMBus devices
Message-Id: <20101011234757.GA6245@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have been trying to add device detection for PMBus devices to sensors-detect.
It works fine for LTC2978.

Problem is that BMR45x chips do not support QUICK commands. As a result, detection
code fails early on.

Would it make sense to extend the detection code to also try other commands
(eg BYTE_DATA) if QUICK does not work, or would that be too risky ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

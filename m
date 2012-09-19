From: Matthew Monaco <matt@0x01b.net>
Date: Wed, 19 Sep 2012 06:04:25 +0000
Subject: [lm-sensors] i8k: non-standard fan control
Message-Id: <50596069.9030904@0x01b.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I am interested in extending the i8k module's hwmon support. This module (among
other things) allows the status of Dell laptop fans to be controlled. The fan
speed is controlled via an integer from 0 (off) to 2 (fast).

Is there any way to support these semantics through hwmon? I easily added a
fanN_status sysfs entry through hwmon that does the right thing. However the
_status doesn't follow all other naming conventions that I can find.

Best,
Matt

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

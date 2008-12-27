From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Sat, 27 Dec 2008 18:38:13 +0000
Subject: [lm-sensors] Sensors 3.0.3 on ASUS M2NPV-VM: No Alarms in sensors
Message-Id: <49567615.8000500@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have what I think is a working configuration for lm_sensors (I have another
question out asking for help with the configuration). However, with min/max
values set, I don't see any "ALARM" flags in the sensors output when a value
goes out of range.

When I was using sensors to monitor the health of my machine before (about
a year ago...), I was able to parse the sensors output looking for this
string to determine there was something which needed reporting.

Does this alarm depend on a motherboard/chip feature which mine does not
have, or is there something in the configuration I can set to enable these
alarms? In looking at the source, it seems it is a feature of the chip?

Note: I see that I can enable audible alarms using:

  set beep_enable 1

but I'm pretty sure I'm not talking about that.

I tested this by setting min/max RPM values for the chassis fan, then
slowing the fan down by hand.


Thanks,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

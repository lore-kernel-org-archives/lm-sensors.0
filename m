From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 12 Mar 2006 13:02:45 +0000
Subject: [lm-sensors] Updated new Abit uGuru (lm_sensors) driver please test!
Message-Id: <44141BF5.8040809@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

As feared there were some problems with the #pwm and #sensor detection.
Attached is a new version. Which also contains a fix for not compiling
on less then bleeding edge kernels.

Changes:
version 1.1.6:
-put the wait for alarm time in bank1 sensor type detect code for voltage
   sensor test back to 20ms, as according to the reporter only the temp test
   duration needs to be raised.
-except 0x40 (bit 6) being high as a valid fan sensor setting, I don't
   know what this bit does, but it is being reported high for fan1 on some
   motherboards. Currently this bit is only excepted for fan1, but that 
might
   change.
-use 77 (30%) as minimal allowed pwm%, but for pwm1 only.

Please test as usual, and many thanks!

Regards,

Hans


-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: abituguru.c.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060312/86942704/abituguru.c-0001.txt

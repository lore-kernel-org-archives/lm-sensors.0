From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 05 Oct 2007 08:09:11 +0000
Subject: [lm-sensors] Working on adt7475 driver
Message-Id: <4705F127.8010600@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just wanted to let everyone know that I've bought an asus m2n sli deluxe 
motherboard and that I now have a group of students working on writing a driver 
for the adt7475 as part of a Linux device driver course I'm teaching. They have 
gotten past the initial problems of learning kernel space thinking and leanring 
  to read datasheets, so I think they will succeed.

Depending on how much they like writing drivers they, or I myself, will submit 
this for review when its done.

I also have groups working on:
-watchdog support for the FSC hwmon IC's following the standard watchdog
  userspace ABI, for the new fschmd driver
-pwm support for the f71882fg driver
-interrupt support for the intel801 i2c adapter driver

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

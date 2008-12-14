From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 14 Dec 2008 16:26:50 +0000
Subject: [lm-sensors] PATCH: f71882fg: add f8000 support
Message-Id: <494533CA.7060305@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

ANd finally the patch actually adding the f8000 support.

Thanks & Regards,

Hans

p.s.

While doing this patch I noticed that for some reason the fan_attr array for 
the f71862fg is missing the attr for the 3th pwm output. I'll do a separate 
patch adding that. When that is done too, I'll mail the 2 f8000 testers you've 
send me mails about asking them to test the new f71882fg.c with f8000 support.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

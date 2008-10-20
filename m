From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 20 Oct 2008 09:27:16 +0000
Subject: [lm-sensors] PATCH: f71882fg add PWM support [0/2]
Message-Id: <48FC4EF4.1050907@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean (and all),

Recently Mark van Doesburg submitted an updated version of his PWM support for 
the f71882fg driver patch, with fixes for all my review remarks.

There were still some small issues left, as this patch has been in the queue 
way too long, and as the 2.6.28 merge window is upon us now, I've fixed the 
last few remaining issues myself.

Can you please put these 2 *reviewed* patches in your hwmon queue for Linus ?

Thanks!

PATCH: f71882fg-sensor_attr2.patch [1/2]
Convert f71882fg driver from SENSOR_ATTR to SENSOR_ATTR2 use, this is a
preparation patch for adding pwm support, which is broken out to make what
changes really in the pwm support patch clear.

PATCH: f71882fg-pwm-support.patch [2/2]
Add pwm support to the f71882fg driver.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

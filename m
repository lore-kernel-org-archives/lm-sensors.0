From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 19 Dec 2008 21:32:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add a driver for the ADT7475 thermal
Message-Id: <494C12E5.8000102@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080610194818.GA21150@cosmic.amd.com>
In-Reply-To: <20080610194818.GA21150@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

p.s.

This has been tested on my Asus M2N SLI deluxe motherboard


Hi Jean,

As Jordan did not get around to doing this and the 2.6.29 merge window is near
I've fixed the last few outstanding issues from my review(s) of his adt7475
I've done myself. Attached is a new version of the adt7475 with:
* all issues review found fixed
* converted to the new i2c driver style
* a few more registers needed reading in store methods
* corrected register to voltage conversion (more accurate)
* some style fixes
* locking around show functions where the value shown depends on more then
    1 reg.
* read limit registers only once every 60 seconds
* rename pwm_min and pwm_max to pwm_auto_pointX_pwm, as the
    control the scope between which the pwm gets changed in auto mode
* remove tempX_crit_alarm (only one crit alarm flag for all 3 channels)

I hope this is ok now to be queued for 2.6.29

Thanks & Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

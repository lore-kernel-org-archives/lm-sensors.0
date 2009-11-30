From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Nov 2009 21:35:31 +0000
Subject: [lm-sensors] ADT7476 support
Message-Id: <20091130223531.4ba08bf4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200711071645.05120.billf@thinklogical.com>
In-Reply-To: <200711071645.05120.billf@thinklogical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

You all have been showing interest in Linux ADT7476 support in the
past. Rejoice, I have just added support for that chip to the adt7475
driver. My current work is available for you to test if you are still
interested:

http://khali.linux-fr.org/devel/misc/adt7490/

This is a standalone driver, you'll need a proper build environment
then type "make" then load the driver.

If you prefer, I can also provide a patch for whatever kernel version
you're running.

Not all features are supported yet, in particular VID is missing, but
that should still be worth a try, most interesting things are already
there. Please report if you try it.

I am also interested in gathering more register dumps of ADT7476 chips.
You can obtain such a dump from your own chip using the i2c-dev driver
together with i2cdump from the i2c-tools package.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

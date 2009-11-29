From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 29 Nov 2009 19:55:04 +0000
Subject: [lm-sensors] ADT7490 support
Message-Id: <20091129205504.4c7cbc7b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
In-Reply-To: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Justin, James,

I have added support for the ADT7490 to the adt7475 driver. My current
work is available for you to test if you are still interested:

http://khali.linux-fr.org/devel/misc/adt7490/

This is a standalone driver, you'll need a proper build environment
then type "make" the load the driver.

If you prefer, I can also provide a patch for whatever kernel version
you're running.

There are still a few configuration cases that aren't properly
supported, I'll work on that later as my time permits.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [03/07] I2C: Fix incorrect sysfs file permissions in it87 and via686a
Message-Id: <20050427171617.GD3195@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050427171446.GA3195@kroah.com>
In-Reply-To: <20050427171446.GA3195@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, sensors@stimpy.netroedge.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>, Theodore Ts'o <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>, Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk


-stable review patch.  If anyone has any objections, please let us know.

------------------

The it87 and via686a hardware monitoring drivers each create a sysfs
file named "alarms" in R/W mode, while they should really create it in
read-only mode. Since we don't provide a store function for these files,
write attempts to these files will do something undefined (I guess) and
bad (I am sure). My own try resulted in a locked terminal (where I
attempted the write) and a 100% CPU load until next reboot.

As a side note, wouldn't it make sense to check, when creating sysfs
files, that readable files have a non-NULL show method, and writable
files have a non-NULL store method? I know drivers are not supposed to
do stupid things, but there is already a BUG_ON for several conditions
in sysfs_create_file, so maybe we could add two more?

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.12-rc1-bk5/drivers/i2c/chips/it87.c.orig	2005-04-02 18:09:59.000000000 +0200
+++ linux-2.6.12-rc1-bk5/drivers/i2c/chips/it87.c	2005-04-02 21:12:46.000000000 +0200
@@ -668,7 +668,7 @@
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
 }
-static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 static ssize_t
 show_vrm_reg(struct device *dev, char *buf)
--- linux-2.6.12-rc1-bk5/drivers/i2c/chips/via686a.c.orig	2005-04-02 18:22:48.000000000 +0200
+++ linux-2.6.12-rc1-bk5/drivers/i2c/chips/via686a.c	2005-04-02 21:12:55.000000000 +0200
@@ -574,7 +574,7 @@
 	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
 }
-static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /* The driver. I choose to use type i2c_driver, as at is identical to both
    smbus_driver and isa_driver, and clients could be of either kind */


-- 
Jean Delvare

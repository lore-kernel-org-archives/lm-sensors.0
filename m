From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Thu, 30 Jul 2015 16:18:52 +0000
Subject: [lm-sensors] [PATCH 27/27] i2c: (RFC, don't apply) report OF style modalias when probing using DT
Message-Id: <1438273132-20926-28-git-send-email-javier@osg.samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1438273132-20926-1-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgird>

An I2C driver that supports both OF and legacy platforms, will have
both a OF and I2C ID table. This means that when built as a module,
the aliases will be filled from both tables but currently always an
alias of the form i2c:<deviceId> is reported, e.g:

$ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
i2c:maxtouch

So if a device is probed by matching its compatible string, udev can
get a MODALIAS uevent env var that doesn't match with one of the valid
aliases so the module won't be auto-loaded.

This patch changes the I2C core to report a OF related MODALIAS uevent
(of:N*T*C) env var instead so the module can be auto-loaded and also
report the correct alias using sysfs:

$ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
of:NtrackpadT<NULL>Catmel,maxtouch

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>



---

 drivers/i2c/i2c-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 92dddfeb3f39..c0668c2ed9da 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -489,6 +489,10 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 	struct i2c_client	*client = to_i2c_client(dev);
 	int rc;
 
+	rc = of_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
 	rc = acpi_device_uevent_modalias(dev, env);
 	if (rc != -ENODEV)
 		return rc;
@@ -726,6 +730,10 @@ show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 	struct i2c_client *client = to_i2c_client(dev);
 	int len;
 
+	len = of_device_get_modalias(dev, buf, PAGE_SIZE - 1);
+	if (len != -ENODEV)
+		return len;
+
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
 	if (len != -ENODEV)
 		return len;
-- 
2.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

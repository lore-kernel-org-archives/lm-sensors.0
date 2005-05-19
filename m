From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040303180250.GA27296@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 29, 2004 at 12:33:28PM -0500, Mark Studebaker wrote:
> Greg, any luck with this?
> 
> Greg KH wrote:
> >On Fri, Feb 20, 2004 at 07:55:37PM -0500, Mark Studebaker wrote:
> >
> >>Exactly the same as what's in
> >>/sys/class/i2c-dev/i2c-x/device/i2c-y/name file now,
> >>for example
> >>
> >>	SMBus AMD756 adapter at 80e0    	
> >
> >
> >Ah, that would be nice.  I'll see if I can get that to work...

How about the following patch (only compile tested...)

thanks,

greg k-h

# I2C: show adapter name in i2c-dev class directory to make it easier for userspace tools.

diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Wed Mar  3 10:02:31 2004
+++ b/drivers/i2c/i2c-dev.c	Wed Mar  3 10:02:31 2004
@@ -124,6 +124,13 @@
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
+static ssize_t show_adapter_name(struct class_device *class_dev, char *buf)
+{
+	struct i2c_dev *i2c_dev = to_i2c_dev(class_dev);
+	return sprintf(buf, "%s\n", i2c_dev->adap->name);
+}
+static CLASS_DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
+
 static ssize_t i2cdev_read (struct file *file, char __user *buf, size_t count,
                             loff_t *offset)
 {
@@ -459,6 +466,7 @@
 	if (retval)
 		goto error;
 	class_device_create_file(&i2c_dev->class_dev, &class_device_attr_dev);
+	class_device_create_file(&i2c_dev->class_dev, &class_device_attr_name);
 	return 0;
 error:
 	return_i2c_dev(i2c_dev);

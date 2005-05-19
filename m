From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: [PATCH] sync i2c-dev numbers up with i2c adapter numbers
Message-Id: <20040303232755.GA1076@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here's a patch to keep these numbers in sync.

Now I need to figure out a simple way to allocate the i2c adapter
numbers in "next available" sequence.  I tried using the lib/idr.c code,
but you don't want to see the numbers that it generated...

Oh, we should probably also fix i2c-dev to handle the full range of
minors, now that we have an increased numberspace with 2.6.  Anyone want
to try making up that patch?

Any objections to the patch below?  Combine that with the 'name' file
for i2c-dev and we should have an easier way to find which i2c dev
device is assigned to which i2c-adapter, right?

Hm, I could always just put a direct symlink in there, to the proper
/sys/class/i2c-adapater/ directory.  Anyone think that is necessary?

thanks,

greg k-h


# I2C: keep i2c-dev numbers in sync with i2c adapter numbers
# 
# This makes userspace tools easier to figure out which i2c-dev device is
# assigned to which i2c adapter.
# 
# Yes, we can overflow the i2c dev array right now, but that would take a
# lot of i2c adapter modprobe/rmmod cycles.  That will be fixed up soon.

diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Wed Mar  3 15:24:21 2004
+++ b/drivers/i2c/i2c-dev.c	Wed Mar  3 15:24:21 2004
@@ -72,24 +72,18 @@
 struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev = NULL;
-	int i;
 
 	spin_lock(&i2c_dev_array_lock);
-	for (i = 0; i < I2C_MINORS; ++i) {
-		if ((i2c_dev_array[i]) &&
-		    (i2c_dev_array[i]->adap = adap)) {
-			i2c_dev = i2c_dev_array[i];
-			break;
-		}
-	}
+	if ((i2c_dev_array[adap->nr]) &&
+	    (i2c_dev_array[adap->nr]->adap = adap))
+		i2c_dev = i2c_dev_array[adap->nr];
 	spin_unlock(&i2c_dev_array_lock);
 	return i2c_dev;
 }
 
-static struct i2c_dev *get_free_i2c_dev(void)
+static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev;
-	unsigned int i;
 
 	i2c_dev = kmalloc(sizeof(*i2c_dev), GFP_KERNEL);
 	if (!i2c_dev)
@@ -97,15 +91,16 @@
 	memset(i2c_dev, 0x00, sizeof(*i2c_dev));
 
 	spin_lock(&i2c_dev_array_lock);
-	for (i = 0; i < I2C_MINORS; ++i) {
-		if (i2c_dev_array[i])
-			continue;
-		i2c_dev->minor = i;
-		i2c_dev_array[i] = i2c_dev;
+	if (i2c_dev_array[adap->nr]) {
 		spin_unlock(&i2c_dev_array_lock);
-		return i2c_dev;
+		dev_err(&adap->dev, "i2c-dev already has a device assigned to this adapter\n");
+		goto error;
 	}
+	i2c_dev->minor = adap->nr;
+	i2c_dev_array[adap->nr] = i2c_dev;
 	spin_unlock(&i2c_dev_array_lock);
+	return i2c_dev;
+error:
 	kfree(i2c_dev);
 	return ERR_PTR(-ENODEV);
 }
@@ -446,7 +441,7 @@
 	struct i2c_dev *i2c_dev;
 	int retval;
 
-	i2c_dev = get_free_i2c_dev();
+	i2c_dev = get_free_i2c_dev(adap);
 	if (IS_ERR(i2c_dev))
 		return PTR_ERR(i2c_dev);
 

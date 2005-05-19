From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: PATCH RFC fix adm1025 vid reporting
Message-Id: <6a3o319k8q774n0dgmj2q98u18rum7t2hs@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This trivial patch changes vid reporting for adm1025 to the 
standard cpu0_vid filename.  It leaves the older in1_ref file 
in, marked as deprecated for later removal so we do not pull 
the rug out from anybody.

My query is do we need to give notification of feature change 
or removal as some other kernel sections are doing?  Trying to 
tread very gently...

Compile tested, patch tested, but no run test :(  

Cheers,
Grant.

--- linux-2.6.11-mm4/drivers/i2c/chips/adm1025.c	2005-03-17 07:56:47.000000000 +1100
+++ linux-2.6.11-mm4x/drivers/i2c/chips/adm1025.c	2005-03-19 22:22:40.000000000 +1100
@@ -275,7 +275,8 @@
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL); /* deprecated */
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 static ssize_t show_vrm(struct device *dev, char *buf)
 {
@@ -425,7 +426,8 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	device_create_file(&new_client->dev, &dev_attr_in1_ref);
+	device_create_file(&new_client->dev, &dev_attr_in1_ref); /* deprecated */
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 
 	/* Pin 11 is either in4 (+12V) or VID4 */

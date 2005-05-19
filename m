From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Ticket #1851 - PATCH for adm1026.c, kernel 2.6.10-bk6
Message-Id: <20050103194355.GA11979@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D5D075.4000200@paradyne.com>
 <20050101001205.6b2a44d3.khali@linux-fr.org>
In-Reply-To: <20050101001205.6b2a44d3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>
Cc: greg@kroah.com, phil@netroedge.com, linux-kernel@vger.kernel.org

On Sat, Jan 01, 2005 at 12:12:05AM +0100, Jean Delvare wrote:
> > anybody see how to get a divide by zero in 2.6 adm1026 set_fan_1_min()
> > ??? It looks fine to me...
> > 
> > <http://secure.netroedge.com/~lm78/readticket.cgi?ticket51>
> 
> Easy. Try setting fan1_min or fan1_div before ever *reading* from the
> sysfs files. The update fonction not having been called, fan_div[0] is
> equal to 0.
> 
> Justin, can you confirm and provide a patch to fix the issue?

Sorry for the slow response.  Real World vacation time intervened.

Yes, I confirmed the reported problem.  The patch below should fix it...
It should also fix any other values-not-initialized- to-hardware-defaults 
issues.

Signed-off-by: Justin Thiessen <jthiessen@penguincomputing.com>

----------------

--- linux-2.6.10/drivers/i2c/chips/adm1026.c.orig	2005-01-02 15:21:58.000000000 -0800
+++ linux-2.6.10/drivers/i2c/chips/adm1026.c	2005-01-02 16:09:52.000000000 -0800
@@ -1752,6 +1752,10 @@ int adm1026_detect(struct i2c_adapter *a
 	device_create_file(&new_client->dev, &dev_attr_temp2_auto_point2_pwm);
 	device_create_file(&new_client->dev, &dev_attr_temp3_auto_point2_pwm);
 	device_create_file(&new_client->dev, &dev_attr_analog_out);
+
+	/* Make sure hardware defaults are read into data structure */
+	adm1026_update_device(&new_client->dev);
+
 	return 0;
 
 	/* Error out and cleanup code */


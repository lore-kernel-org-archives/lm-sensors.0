From: "Jan Beulich" <JBeulich@suse.com>
Date: Fri, 23 Sep 2011 10:32:49 +0000
Subject: [lm-sensors] [PATCH] coretemp: avoid leaving around dangling pointer
Message-Id: <4E7C7C710200007800057854@nat28.tlf.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Storing the struct temp_data pointer allocated from create_core_data()
before passing the last 'goto exit_free' has the potential of leaving
around a pointer to freed memory. As there's no need for the pointer to
be stored before calling create_core_attrs(), simply move the storing
past that call.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@kernel.org 

---
 drivers/hwmon/coretemp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 3.1-rc7-coretemp.orig/drivers/hwmon/coretemp.c
+++ 3.1-rc7-coretemp/drivers/hwmon/coretemp.c
@@ -609,13 +609,14 @@ static int create_core_data(struct platf
 				  THERM_SHIFT_THRESHOLD1) * 1000;
 	}
 
-	pdata->core_data[attr_no] = tdata;
 
 	/* Create sysfs interfaces */
 	err = create_core_attrs(tdata, &pdev->dev, attr_no);
 	if (err)
 		goto exit_free;
 
+	pdata->core_data[attr_no] = tdata;
+
 	return 0;
 exit_free:
 	kfree(tdata);




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

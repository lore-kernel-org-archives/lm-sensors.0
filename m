From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] More i2c driver changes for 2.5.65
Message-Id: <1048295086481@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10482950852454@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1191, 2003/03/21 16:00:39-08:00, greg@kroah.com

i2c: add struct device to i2c_client structure

Not quite ready to hook it up to the driver core yet.


 include/linux/i2c.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Fri Mar 21 16:53:17 2003
+++ b/include/linux/i2c.h	Fri Mar 21 16:53:17 2003
@@ -170,8 +170,9 @@
 	void *data;			/* for the clients		*/
 	int usage_count;		/* How many accesses currently  */
 					/* to the client		*/
+	struct device dev;		/* the device structure		*/
 };
-
+#define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
 /*
  * The following structs are for those who like to implement new bus drivers:

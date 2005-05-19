From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [PATCH] i2c driver changes for 2.5.69
Message-Id: <1052267615977@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1052267615252@kroah.com>
References: <10522676142536@kroah.com>
In-Reply-To: <10522676142536@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1042.48.2, 2003/04/25 16:11:23-07:00, greg@kroah.com

[PATCH] i2c: fix oops on startup of it87 driver.


 drivers/i2c/chips/it87.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue May  6 17:25:00 2003
+++ b/drivers/i2c/chips/it87.c	Tue May  6 17:25:00 2003
@@ -585,6 +585,8 @@
 		err = -ENOMEM;
 		goto ERROR1;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+				 sizeof(struct it87_data));
 
 	data = (struct it87_data *) (new_client + 1);
 	if (is_isa)


From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:37 +0000
Subject: [lm-sensors] [PATCH] I2C: Fix up debug build error for previous i2c
Message-Id: <113658525775@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Fix up debug build error for previous i2c structure changes

Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
Signed-off-by: Jean Delvare <khali at linux-fr.org>

---
commit e1c489b0e4fbb1687f8227fe78b4769c123768c1
tree 406a079669c46f5978621a80fe95056dd0b93730
parent d45d204f0c3daa01a393dfe81415573f9459506a
author Greg Kroah-Hartman <gregkh at suse.de> Wed, 30 Nov 2005 16:35:09 -0800
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:24 -0800

 drivers/i2c/busses/i2c-isa.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
index 9f93fb8..9f2ffef 100644
--- a/drivers/i2c/busses/i2c-isa.c
+++ b/drivers/i2c/busses/i2c-isa.c
@@ -98,7 +98,7 @@ int i2c_isa_add_driver(struct i2c_driver
 	res = driver_register(&driver->driver);
 	if (res)
 		return res;
-	dev_dbg(&isa_adapter.dev, "Driver %s registered\n", driver->name);
+	dev_dbg(&isa_adapter.dev, "Driver %s registered\n", driver->driver.name);
 
 	/* Now look for clients */
 	driver->attach_adapter(&isa_adapter);
@@ -129,7 +129,7 @@ int i2c_isa_del_driver(struct i2c_driver
 
 	/* Get the driver off the core list */
 	driver_unregister(&driver->driver);
-	dev_dbg(&isa_adapter.dev, "Driver %s unregistered\n", driver->name);
+	dev_dbg(&isa_adapter.dev, "Driver %s unregistered\n", driver->driver.name);
 
 	return 0;
 }
@@ -174,7 +174,7 @@ static void __exit i2c_isa_exit(void)
 	list_for_each_safe(item, _n, &isa_adapter.clients) {
 		client = list_entry(item, struct i2c_client, list);
 		dev_err(&isa_adapter.dev, "Driver %s still has an active "
-			"ISA client at 0x%x\n", client->driver->name,
+			"ISA client at 0x%x\n", client->driver->driver.name,
 			client->addr);
 	}
 	if (client != NULL)



From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 10 Jun 2005 06:26:11 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050610042539.GD23717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Mark M. Hoffman <mhoffman@lightlink.com> [2005-06-04 23:41:37 -0400]:
> It would be easy enough to do hwmon1, hwmon2, etc. just like the usb_host
> class does.  Everyone OK with that?

* Jean Delvare <khali@linux-fr.org> [2005-06-04 18:24:28 +0200]:
> > Last, it would be nice if the IDs were reused on driver cycling, just
> > like the i2c bus IDs are. You should be able to pick the code in i2c-dev
> > and reuse it in the hwmon class.

* Mark M. Hoffman <mhoffman@lightlink.com> [2005-06-04 23:41:37 -0400]:
> It would be nice... I'll look into it.

Actually, the bus IDs are assigned in i2c-core.  The i2c-dev ID is just a
copy of that.  The mechanism for the ID recycling is from lib/idr.c.

AFAICT, the ID recycling is a mere side-effect of that (idr.c) modules's
real purpose.  The way it's used in i2c-core.c feels like bloat to me.  
I'm not certain I want to duplicate that in hwmon.c.  Opinions?

* * * * *

Well, i2c_get_adapter() could actually use i2c_adapter_idr properly:
(untested, not signed off, may eet ur branes, /me needs sleep)

Index: linux-2.6.12-rc6-mm1/drivers/i2c/i2c-core.c
=================================--- linux-2.6.12-rc6-mm1.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.12-rc6-mm1/drivers/i2c/i2c-core.c
@@ -156,7 +156,7 @@ int i2c_add_adapter(struct i2c_adapter *
 		goto out_unlock;
 	}
 
-	res = idr_get_new(&i2c_adapter_idr, NULL, &id);
+	res = idr_get_new(&i2c_adapter_idr, adap, &id);
 	if (res < 0) {
 		if (res = -EAGAIN)
 			res = -ENOMEM;
@@ -765,20 +765,15 @@ int i2c_adapter_id(struct i2c_adapter *a
 
 struct i2c_adapter* i2c_get_adapter(int id)
 {
-	struct list_head   *item;
 	struct i2c_adapter *adapter;
 	
 	down(&core_lists);
-	list_for_each(item,&adapters) {
-		adapter = list_entry(item, struct i2c_adapter, list);
-		if (id = adapter->nr &&
-		    try_module_get(adapter->owner)) {
-			up(&core_lists);
-			return adapter;
-		}
-	}
+	adapter = (struct i2c_adapter *)idr_find(&i2c_adapter_idr, id);
+	if (adapter && !try_module_get(adapter->owner))
+		adapter = NULL;
+
 	up(&core_lists);
-	return NULL;
+	return adapter;
 }
 
 void i2c_put_adapter(struct i2c_adapter *adap)

-- 
Mark M. Hoffman
mhoffman@lightlink.com


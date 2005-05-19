From: perrye@linuxmail.org (Perry Gilfillan)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: i2c sub system
Message-Id: <4025D1B5.3090205@linuxmail.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I've a couple of questions regarding the i2c sub system.  The work I'm 
doing is on the 2.4.23 kernel.  For some background,  I've been updating 
the v3tv.sourceforge.net project to work with the i2c 2.8.2 api. 
Previously v3tv used it's own versions of tvmixer, msp3400, and tuner, 
as well a vpx322x module.  With a few trivial patches to the kernel 
version of the first three, v3tv now uses the kernel modules.  I've 
written a new vpx3224 module, based on the vpx3220 found in the 2.6 
kernel.  I've also stripped the i2c adapter that was part of the v3tv 
module, and am now using the i2c-voodoo3 module in the kernel.

Since v3tv no longer provides the i2c adapter, I need to get a pointer 
to the i2c-voodoo3 adapter.  One option would be to use a dummy driver. 
  From my perspective the more efficient method would be to have 
i2c_get_adapter available.

The first question, is this patch a good thing?  It adds i2c_get_adapter 
and i2c_put_adapter, based on those found in 2.6.  If this patch would 
not fly with the 2.4 maintainers, would my only option for getting the 
i2c_adapter structure pointer be to use a dummy i2c driver in the v3tv 
module?

The second question is regarding i2c-voodoo3.  It's still somewhat vauge 
to me the distinction between the i2c and smbus protocols. i2c-voodoo3 
uses i2c-algo-bit, which returns functionality I2C_FUNC_SMBUS_EMUL, as 
well as I2C_FUNC_10BIT_ADDR and I2C_FUNC_PROTOCOL_MANGLING. The 
i2c_adapter->id is assigned I2C_HW_B_VOO.  Would I2C_HW_SMBUS_VOODOO3 be 
more appropriate?

Looking at the 2.6 version of i2c-voodoo3, i2c_adapter->id is not 
assigned at all.  Neither is class.  There are versions of the Voodoo3 
that provide just a bt869 tv-out interface, and others that also provide 
tv-in.  Would it be appropriate to have class assigned 
I2C_ADAP_CLASS_TV_ANALOG only for the tv-in version, or also for the 
tv-out only version.

This latest lightweight version of v3tv can be found at 
http://gilfillan.org:8000/v3tv-free/

The vpx3224 module I've worked up is at 
http://gilfillan.org:8000/vpx3224/  I've not recieved any feedback on 
this at all.  If any one can spare the time to look at it, I'd be 
grateful.  I'll give a few more days, then go ahead and present it to 
lkml for comment.

Thanks for your time,

Perry

--- linux-2.4.23-stock/drivers/i2c/i2c-core.c   2003-12-28 
11:28:52.000000000 -0600
+++ linux-2.4.23/drivers/i2c/i2c-core.c 2004-02-07 19:58:17.000000000 -0600
@@ -180,6 +180,32 @@ int i2c_del_adapter(struct i2c_adapter *
         return res;
  }

+struct i2c_adapter* i2c_get_adapter(unsigned int id)
+{
+        int i;
+        struct i2c_adapter *adapter;
+
+       down(&core_lists);
+        for (i = 0; i < I2C_ADAP_MAX; i++) {
+                if (NULL = adapters[i])
+                        continue;
+
+                adapter = adapters[i];
+                if (id = adapter->id) {
+                        __MOD_INC_USE_COUNT(adapter->owner);
+                       up(&core_lists);
+                        return adapter;
+                }
+        }
+       up(&core_lists);
+        return NULL;
+}
+
+void i2c_put_adapter(struct i2c_adapter *adap)
+{
+        __MOD_DEC_USE_COUNT(adap->owner);
+
+}

  /* -----
   * What follows is the "upwards" interface: commands for talking to 
clients,
@@ -1423,6 +1449,8 @@ int __init i2c_init_all(void)

  EXPORT_SYMBOL(i2c_add_adapter);
  EXPORT_SYMBOL(i2c_del_adapter);
+EXPORT_SYMBOL(i2c_get_adapter);
+EXPORT_SYMBOL(i2c_put_adapter);
  EXPORT_SYMBOL(i2c_add_driver);
  EXPORT_SYMBOL(i2c_del_driver);
  EXPORT_SYMBOL(i2c_attach_client);
--- linux-2.4.23-stock/include/linux/i2c.h      2003-12-28 
23:43:00.000000000 -0600
+++ linux-2.4.23/include/linux/i2c.h    2004-02-07 19:55:34.000000000 -0600
@@ -284,6 +284,9 @@
  extern int i2c_add_adapter(struct i2c_adapter *);
  extern int i2c_del_adapter(struct i2c_adapter *);

+extern struct i2c_adapter* i2c_get_adapter(unsigned int id);
+extern void i2c_put_adapter(struct i2c_adapter *adap);
+
  extern int i2c_add_driver(struct i2c_driver *);
  extern int i2c_del_driver(struct i2c_driver *);



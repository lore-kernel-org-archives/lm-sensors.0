From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC PATCH Documentation/i2c/porting-clients
Message-Id: <q6o64114808tamt4m46j5lkjendhjit4p8@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Small doc patch to remind porters about update locking.

Signed-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.12-rc1-mm2/Documentation/i2c/porting-clients	2005-03-23 06:34:20.000000000 +1100
+++ linux-2.6.12-rc1-mm2x/Documentation/i2c/porting-clients	2005-03-25 11:50:38.000000000 +1100
@@ -98,6 +98,9 @@
 * [Update] Don't access client->data directly, use
   i2c_get_clientdata(client) instead.
 
+  Make sure the driver takes the data->update_lock while performing each 
+  update, see lm85.c set_fan_min() for an example of how this is done.
+
 * [Interface] Init function should not print anything. Make sure
   there is a MODULE_LICENSE() line, at the bottom of the file
   (after MODULE_AUTHOR() and MODULE_DESCRIPTION(), in this order).

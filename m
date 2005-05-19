From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: [PATCH 2.6] I2C: Kill outdated defines in i2c.h
Message-Id: <20050320185846.0b3bde3b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Some defines in i2c.h (I2C_CLIENT_MODPARM and friends) are now useless.
They should have been removed when the i2c client parameters were
converted from MODULE_PARAM to module_parm_array, but where not. This
patch removes them now.

Additionally, it moves the definition of I2C_CLIENT_MAX_OPTS next to
where it is used rather than 220 lines before, which is preferable IMHO.

As a side note, I think that there is a bug in the way these options are
handled. The i2c code looks for I2C_CLIENT_END as a list terminator, but
if the maximum number of parameters are actually provided, no terminator
will be left. It's rather unlikely to happen because nobody will
probably ever provide that many parameters, but this should probably be
fixed. I'll address this issue later, since I plan to completely rewrite
the way these parameters are handled anyway.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc1/include/linux/i2c.h.orig	2005-03-19 19:23:51.000000000 +0100
+++ linux-2.6.12-rc1/include/linux/i2c.h	2005-03-20 12:26:34.000000000 +0100
@@ -306,9 +306,6 @@
 #define ANY_I2C_BUS		0xffff
 #define ANY_I2C_ISA_BUS		9191
 
-/* The length of the option lists */
-#define I2C_CLIENT_MAX_OPTS 48
-
 
 /* ----- functions exported by i2c.o */
 
@@ -526,6 +523,9 @@
 #define I2C_MAJOR	89		/* Device major number		*/
 
 /* These defines are used for probing i2c client addresses */
+/* The length of the option lists */
+#define I2C_CLIENT_MAX_OPTS 48
+
 /* Default fill of many variables */
 #define I2C_CLIENT_DEFAULTS {I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
                           I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
@@ -544,19 +544,12 @@
                           I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
                           I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END}
 
-/* This is ugly. We need to evaluate I2C_CLIENT_MAX_OPTS before it is 
-   stringified */
-#define I2C_CLIENT_MODPARM_AUX1(x) "1-" #x "h"
-#define I2C_CLIENT_MODPARM_AUX(x) I2C_CLIENT_MODPARM_AUX1(x)
-#define I2C_CLIENT_MODPARM I2C_CLIENT_MODPARM_AUX(I2C_CLIENT_MAX_OPTS)
-
 /* I2C_CLIENT_MODULE_PARM creates a module parameter, and puts it in the
    module header */
 
 #define I2C_CLIENT_MODULE_PARM(var,desc) \
   static unsigned short var[I2C_CLIENT_MAX_OPTS] = I2C_CLIENT_DEFAULTS; \
   static unsigned int var##_num; \
-  /*MODULE_PARM(var,I2C_CLIENT_MODPARM);*/ \
   module_param_array(var, short, &var##_num, 0); \
   MODULE_PARM_DESC(var,desc)
 


-- 
Jean Delvare

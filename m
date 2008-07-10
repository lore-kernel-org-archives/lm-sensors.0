From: Ben Hutchings <bhutchings@solarflare.com>
Date: Thu, 10 Jul 2008 19:09:42 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] lm90: Changes to support sfc hardware
Message-Id: <20080710190940.GF19302@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1215701481.git.bhutchings@solarflare.com>
In-Reply-To: <cover.1215701481.git.bhutchings@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Ben,
> 
> On Thu, 10 Jul 2008 15:58:26 +0100, Ben Hutchings wrote:
> > These patches apply on top of the testing branch of hwmon-2.6.git plus
> > Jean Delvare's patch series <http://jdelvare.pck.nerim.net/sensors/lm90/>.
> > 
> > Jean, I expect you may want to do the 3rd patch differently.
> 
> In fact I already have a patch ready:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/hwmon-lm90-convert-to-new-style.patch
> 
> But it depends on i2c-core changes which will go in kernel 2.6.27:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-core-add-detection-capability-to-new-style-drivers.patch
> 
> If you look in http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
> you'll see that I have a lot of conversion patches ready for hwmon
> drivers (including the lm87 driver.) These will go to Linus through my
> i2c tree, because I don't want to burden Mark with them and technically
> they only affect the i2c interface of the drivers. But OTOH I have to
> make sure that they don't collide with patches Mark will send to Linus
> at about the same moment.
[...]

I applied those to a git branch, followed by your lm90 series.  I found a
conflict between these two:

hwmon-lm90-convert-to-new-style.patch
hwmon-lm90-06-support-adt7461-in-extended-mode.patch

Since the private data structure is no longer allocated in lm90_detect(),
the initialisation of data->flags needs to move to lm90_init_client().

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index b1858e2..c502587 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -657,9 +657,6 @@ static int lm90_detect(struct i2c_client *new_client, int kind,
 			 && (reg_config1 & 0x1B) = 0x00
 			 && reg_convrate <= 0x0A) {
 				kind = adt7461;
-				/* Check Temperature Range Select */
-				if (reg_config1 & 0x04)
-					data->flags |= LM90_FLAG_ADT7461_EXT;
 			}
 		} else
 		if (man_id = 0x4D) { /* Maxim */
@@ -796,6 +793,10 @@ static void lm90_init_client(struct i2c_client *client)
 	}
 	config_orig = config;
 
+	/* Check Temperature Range Select */
+	if (config & 0x04)
+		data->flags |= LM90_FLAG_ADT7461_EXT;
+
 	/*
 	 * Put MAX6680/MAX8881 into extended resolution (bit 0x10,
 	 * 0.125 degree resolution) and range (0x08, extend range
--- END ---

It's probably best if you combine this with the latter patch.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

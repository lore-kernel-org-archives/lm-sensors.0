From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 10 Dec 2005 16:01:00 +0000
Subject: [lm-sensors] [PATCH] hwmon: Allow sensor attribute arrays
Message-Id: <439AFBBC.2000501@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Jim,
>
>Some times ago, you proposed a change to include/linux/hwmon-sysfs.h
>that would have made it easier to declare arrays of struct
>sensor_device_attribute. Back then we gave it up because other
>important changes to the pc87360 driver (which was your first target
>for that patch) needed to be done first, but I think it is now the
>right time to think of that patch again.
>
>I have made some cosmetic cleanups to it, and here it is again. I need
>it for a driver of mine. Could you please confirm you're still OK with
>it, and maybe propose a patch for the pc87360 driver?
>
>  
>
Brilliant!, erm Ack.
 (Im not sure if theres a formal procedure for this,
since youve already got my Signed-off-by;)

I'll rework my semi-recycled patch (sent separately) and resend.
BTW, Id not seen this msg until you responded to mine.
It must be an obvious zeitgeist if even I picked up on it ;)

>The size benefit when converting my own driver to use arrays of
>attributes is pretty impressive (from 12.0 kB down to 9.4kB in memory).
>The pc87360 driver should benefit at least as much and probably even
>more (in absolute amount of spared memory).
>
>Thanks.
>
>* * * * *
>
>This patch refactors SENSOR_DEVICE_ATTR macro.  First it creates a new
>macro SENSOR_ATTR() which expands to an initialization expression, then
>it uses that in SENSOR_DEVICE_ATTR, which declares and initializes a
>struct sensor_device_attribute.
>
>IOW, SENSOR_ATTR() imitates __ATTR() in include/linux/device.h.
>
>Signed-off-by: Jim Cromie <jim.cromie at gmail.com>
>Signed-off-by: Jean Delvare <khali at linux-fr.org>
>---
> include/linux/hwmon-sysfs.h |   12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
>--- linux-2.6.15-rc2.orig/include/linux/hwmon-sysfs.h	2005-10-28 17:20:54.000000000 +0200
>+++ linux-2.6.15-rc2/include/linux/hwmon-sysfs.h	2005-11-21 21:44:14.000000000 +0100
>@@ -27,11 +27,13 @@
> #define to_sensor_dev_attr(_dev_attr) \
> 	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
> 
>-#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
>-struct sensor_device_attribute sensor_dev_attr_##_name = {	\
>-	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
>-	.index =	_index,					\
>-}
>+#define SENSOR_ATTR(_name, _mode, _show, _store, _index)	\
>+	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
>+	  .index = _index }
>+
>+#define SENSOR_DEVICE_ATTR(_name, _mode, _show, _store, _index)	\
>+struct sensor_device_attribute sensor_dev_attr_##_name		\
>+	= SENSOR_ATTR(_name, _mode, _show, _store, _index)
> 
> struct sensor_device_attribute_2 {
> 	struct device_attribute dev_attr;
>
>
>  
>



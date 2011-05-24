From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 24 May 2011 20:44:27 +0000
Subject: Re: [lm-sensors] [PATCH 2/5] hwmon: (asus_atk0110) Initialize sysfs
Message-Id: <20110524204427.GA23867@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306267814-31505-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1306267814-31505-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 24, 2011 at 01:10:11PM -0700, Guenter Roeck wrote:
> Initialize dynamically allocated sysfs attributes before device_create_file()
> call to suppress lockdep_init_map() warning if lockdep debugging is enabled.

Hum, I think this has already been fixed by a30dcb4f, the initialization
is done in atk_create_files.
I like your patch better though...

What about this:

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index b5e8920..dcb78a7 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -268,6 +268,7 @@ static struct device_attribute atk_name_attr  static void atk_init_attribute(struct device_attribute *attr, char *name,
 		sysfs_show_func show)
 {
+	sysfs_attr_init(&attr->attr);
 	attr->attr.name = name;
 	attr->attr.mode = 0444;
 	attr->show = show;
@@ -1188,19 +1189,15 @@ static int atk_create_files(struct atk_data *data)
 	int err;
 
 	list_for_each_entry(s, &data->sensor_list, list) {
-		sysfs_attr_init(&s->input_attr.attr);
 		err = device_create_file(data->hwmon_dev, &s->input_attr);
 		if (err)
 			return err;
-		sysfs_attr_init(&s->label_attr.attr);
 		err = device_create_file(data->hwmon_dev, &s->label_attr);
 		if (err)
 			return err;
-		sysfs_attr_init(&s->limit1_attr.attr);
 		err = device_create_file(data->hwmon_dev, &s->limit1_attr);
 		if (err)
 			return err;
-		sysfs_attr_init(&s->limit2_attr.attr);
 		err = device_create_file(data->hwmon_dev, &s->limit2_attr);
 		if (err)
 			return err;

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

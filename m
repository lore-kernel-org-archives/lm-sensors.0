From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <25381867050427234469cbf2a6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 4/26/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> If void is added directly to the attribute structure that means that same
> attribute can not be shared between several instances of the same device
> -> unexpected. So far all attributes could be statically created.

Dmitry: would you mind explaining this a bit more? Also is there
anywhere else you would suggest adding the callback specific void *
to? Perhaps creating some new structure(s) to track driver specific
data for each device?
 
On 4/26/05, Greg KH <greg@kroah.com> wrote:
> Care to show how a driver would use this change?
>
> And the void * shouldn't be called ptr, use what other structures call
> their void pointers, "data", "private", etc.

Attached is an updated patch (yes ptr is rather redundant...) and also
a quickly coded diff between my bmcsensors driver with and without
this patch. Note that a real bmcsensors update would also change the
sdrd[] array into a linked list and allow a potentially unlimited
number of sensors to be seen, since this patch also allows an
unlimited number of sysfs entries to be created at runtime, not
feasible with static callbacks.

This also significantly reduces the module's size, comparing both
modules running on my bmc with 17 sensors:

--------bmcsensors-devdyncallback lsmod -------
Module                  Size  Used by
bmcsensors             24996  0
-------------------bmcsensors lsmod--------------------
Module                  Size  Used by
bmcsensors             75940  0

In the hardware sensors driver class bmcsensors is rather an extreme -
none of the other hwmon drivers have to deal with an unlimited number
of sensors, but many do deal with more than a few and would no doubt
save some code complexity and module size if they took advantage of
this patch.

I hope my code speaks louder than my words ;-)

Thanks,
Yani
-------------- next part --------------
diff -uprN -X dontdiff linux-2.6.12-rc3/drivers/base/core.c linux-2.6.12-rc3-devdyncallback/drivers/base/core.c
--- linux-2.6.12-rc3/drivers/base/core.c	2005-04-26 22:03:23.000000000 -0400
+++ linux-2.6.12-rc3-devdyncallback/drivers/base/core.c	2005-04-27 01:01:21.000000000 -0400
@@ -41,7 +41,7 @@ dev_attr_show(struct kobject * kobj, str
 	ssize_t ret = 0;
 
 	if (dev_attr->show)
-		ret = dev_attr->show(dev, buf);
+		ret = dev_attr->show(dev, buf, dev_attr->data);
 	return ret;
 }
 
@@ -54,7 +54,7 @@ dev_attr_store(struct kobject * kobj, st
 	ssize_t ret = 0;
 
 	if (dev_attr->store)
-		ret = dev_attr->store(dev, buf, count);
+		ret = dev_attr->store(dev, buf, count, dev_attr->data);
 	return ret;
 }
 
diff -uprN -X dontdiff linux-2.6.12-rc3/include/linux/device.h linux-2.6.12-rc3-devdyncallback/include/linux/device.h
--- linux-2.6.12-rc3/include/linux/device.h	2005-04-26 22:03:32.000000000 -0400
+++ linux-2.6.12-rc3-devdyncallback/include/linux/device.h	2005-04-27 22:09:23.000000000 -0400
@@ -335,8 +335,13 @@ extern void driver_attach(struct device_
 
 struct device_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct device * dev, char * buf);
-	ssize_t (*store)(struct device * dev, const char * buf, size_t count);
+	ssize_t (*show)(struct device * dev, char * buf, void * data);
+	ssize_t (*store)(struct device * dev, const char * buf, size_t count, void * data);
+	/* 
+	 * void pointer can be used by driver to identify sysfs entry 
+	 * for 'dynamic' callbacks.
+	 */
+	void * data;
 };
 
 #define DEVICE_ATTR(_name,_mode,_show,_store) \




-------------- next part --------------
--- linux-2.6.11.7-bmcsensors/drivers/i2c/chips/bmcsensors.c	2005-04-28 01:46:17.000000000 -0400
+++ linux-2.6.11.7-devdyncallback-bmcsensors/drivers/i2c/chips/bmcsensors.c	2005-04-28 01:25:18.000000000 -0400
@@ -328,1334 +328,67 @@ static void bmcsensors_select_thresholds
 
 /************* sysfs callback functions *********/
 
-static ssize_t show_sensor(struct device *dev, char *buf, int id)
+static ssize_t show_sensor(struct device *dev, char *buf, void *data)
 {
+	struct sdrdata *sdrd = ((struct sdrdata *)data);
 	bmcsensors_update_client(&bmc_client);
 	return snprintf(buf, 20, "%ld\n",
-			conv_val(sdrd[id].reading, &sdrd[id]));
+			conv_val(sdrd->reading, sdrd));
 }
 
-/* Yes this is a kludge, but with the device.h defined callbacks we don't seem
- * to have any choice at this time, see: 
- *
- * http://archives.andrew.net.au/lm-sensors/msg29942.html
- *
- * for a discussion of the problem. If you have a board with more than 100
- * sensors define more callbacks, add them to the array, and increase the
- * MAX_SDR_ENTRIES to the new limit.
- */
-/* macro to define a callback for sensor #id */
-#define show_sensor_id(id) \
-static ssize_t show_sensor_##id (struct device *dev, char *buf) \
-{ \
-	return show_sensor(dev,buf,id); \
-}
-
-/* define callbacks for 100 sensors */
-show_sensor_id(0);
-show_sensor_id(1);
-show_sensor_id(2);
-show_sensor_id(3);
-show_sensor_id(4);
-show_sensor_id(5);
-show_sensor_id(6);
-show_sensor_id(7);
-show_sensor_id(8);
-show_sensor_id(9);
-show_sensor_id(10);
-show_sensor_id(11);
-show_sensor_id(12);
-show_sensor_id(13);
-show_sensor_id(14);
-show_sensor_id(15);
-show_sensor_id(16);
-show_sensor_id(17);
-show_sensor_id(18);
-show_sensor_id(19);
-show_sensor_id(20);
-show_sensor_id(21);
-show_sensor_id(22);
-show_sensor_id(23);
-show_sensor_id(24);
-show_sensor_id(25);
-show_sensor_id(26);
-show_sensor_id(27);
-show_sensor_id(28);
-show_sensor_id(29);
-show_sensor_id(30);
-show_sensor_id(31);
-show_sensor_id(32);
-show_sensor_id(33);
-show_sensor_id(34);
-show_sensor_id(35);
-show_sensor_id(36);
-show_sensor_id(37);
-show_sensor_id(38);
-show_sensor_id(39);
-show_sensor_id(40);
-show_sensor_id(41);
-show_sensor_id(42);
-show_sensor_id(43);
-show_sensor_id(44);
-show_sensor_id(45);
-show_sensor_id(46);
-show_sensor_id(47);
-show_sensor_id(48);
-show_sensor_id(49);
-show_sensor_id(50);
-show_sensor_id(51);
-show_sensor_id(52);
-show_sensor_id(53);
-show_sensor_id(54);
-show_sensor_id(55);
-show_sensor_id(56);
-show_sensor_id(57);
-show_sensor_id(58);
-show_sensor_id(59);
-show_sensor_id(60);
-show_sensor_id(61);
-show_sensor_id(62);
-show_sensor_id(63);
-show_sensor_id(64);
-show_sensor_id(65);
-show_sensor_id(66);
-show_sensor_id(67);
-show_sensor_id(68);
-show_sensor_id(69);
-show_sensor_id(70);
-show_sensor_id(71);
-show_sensor_id(72);
-show_sensor_id(73);
-show_sensor_id(74);
-show_sensor_id(75);
-show_sensor_id(76);
-show_sensor_id(77);
-show_sensor_id(78);
-show_sensor_id(79);
-show_sensor_id(80);
-show_sensor_id(81);
-show_sensor_id(82);
-show_sensor_id(83);
-show_sensor_id(84);
-show_sensor_id(85);
-show_sensor_id(86);
-show_sensor_id(87);
-show_sensor_id(88);
-show_sensor_id(89);
-show_sensor_id(90);
-show_sensor_id(91);
-show_sensor_id(92);
-show_sensor_id(93);
-show_sensor_id(94);
-show_sensor_id(95);
-show_sensor_id(96);
-show_sensor_id(97);
-show_sensor_id(98);
-show_sensor_id(99);
-
-/* add the defined callbacks to a lookup table */
-static show_callback show_fcn[] = {
-	show_sensor_0,
-	show_sensor_1,
-	show_sensor_2,
-	show_sensor_3,
-	show_sensor_4,
-	show_sensor_5,
-	show_sensor_6,
-	show_sensor_7,
-	show_sensor_8,
-	show_sensor_9,
-	show_sensor_10,
-	show_sensor_11,
-	show_sensor_12,
-	show_sensor_13,
-	show_sensor_14,
-	show_sensor_15,
-	show_sensor_16,
-	show_sensor_17,
-	show_sensor_18,
-	show_sensor_19,
-	show_sensor_20,
-	show_sensor_21,
-	show_sensor_22,
-	show_sensor_23,
-	show_sensor_24,
-	show_sensor_25,
-	show_sensor_26,
-	show_sensor_27,
-	show_sensor_28,
-	show_sensor_29,
-	show_sensor_30,
-	show_sensor_31,
-	show_sensor_32,
-	show_sensor_33,
-	show_sensor_34,
-	show_sensor_35,
-	show_sensor_36,
-	show_sensor_37,
-	show_sensor_38,
-	show_sensor_39,
-	show_sensor_40,
-	show_sensor_41,
-	show_sensor_42,
-	show_sensor_43,
-	show_sensor_44,
-	show_sensor_45,
-	show_sensor_46,
-	show_sensor_47,
-	show_sensor_48,
-	show_sensor_49,
-	show_sensor_50,
-	show_sensor_51,
-	show_sensor_52,
-	show_sensor_53,
-	show_sensor_54,
-	show_sensor_55,
-	show_sensor_56,
-	show_sensor_57,
-	show_sensor_58,
-	show_sensor_59,
-	show_sensor_60,
-	show_sensor_61,
-	show_sensor_62,
-	show_sensor_63,
-	show_sensor_64,
-	show_sensor_65,
-	show_sensor_66,
-	show_sensor_67,
-	show_sensor_68,
-	show_sensor_69,
-	show_sensor_70,
-	show_sensor_71,
-	show_sensor_72,
-	show_sensor_73,
-	show_sensor_74,
-	show_sensor_75,
-	show_sensor_76,
-	show_sensor_77,
-	show_sensor_78,
-	show_sensor_79,
-	show_sensor_80,
-	show_sensor_81,
-	show_sensor_82,
-	show_sensor_83,
-	show_sensor_84,
-	show_sensor_85,
-	show_sensor_86,
-	show_sensor_87,
-	show_sensor_88,
-	show_sensor_89,
-	show_sensor_90,
-	show_sensor_91,
-	show_sensor_92,
-	show_sensor_93,
-	show_sensor_94,
-	show_sensor_95,
-	show_sensor_96,
-	show_sensor_97,
-	show_sensor_98,
-	show_sensor_99,
-};
-
-static ssize_t show_sensor_max(struct device *dev, char *buf, int id)
+static ssize_t show_sensor_max(struct device *dev, char *buf, void *data)
 {
 	long max = 0;
+	struct sdrdata *sdrd = ((struct sdrdata *)data);
 
-	if (sdrd[id].lim1 >= 0)
-		max = conv_val(sdrd[id].limits[sdrd[id].lim1], &sdrd[id]);
+	if (sdrd->lim1 >= 0)
+		max = conv_val(sdrd->limits[sdrd->lim1], sdrd);
 	return snprintf(buf, 20, "%ld\n", max);
 }
 
-#define show_sensor_max_id(id) \
-static ssize_t show_sensor_max_##id (struct device *dev, char *buf) \
-{\
-    return show_sensor_max(dev, buf, id); \
-}
-
-show_sensor_max_id(0);
-show_sensor_max_id(1);
-show_sensor_max_id(2);
-show_sensor_max_id(3);
-show_sensor_max_id(4);
-show_sensor_max_id(5);
-show_sensor_max_id(6);
-show_sensor_max_id(7);
-show_sensor_max_id(8);
-show_sensor_max_id(9);
-show_sensor_max_id(10);
-show_sensor_max_id(11);
-show_sensor_max_id(12);
-show_sensor_max_id(13);
-show_sensor_max_id(14);
-show_sensor_max_id(15);
-show_sensor_max_id(16);
-show_sensor_max_id(17);
-show_sensor_max_id(18);
-show_sensor_max_id(19);
-show_sensor_max_id(20);
-show_sensor_max_id(21);
-show_sensor_max_id(22);
-show_sensor_max_id(23);
-show_sensor_max_id(24);
-show_sensor_max_id(25);
-show_sensor_max_id(26);
-show_sensor_max_id(27);
-show_sensor_max_id(28);
-show_sensor_max_id(29);
-show_sensor_max_id(30);
-show_sensor_max_id(31);
-show_sensor_max_id(32);
-show_sensor_max_id(33);
-show_sensor_max_id(34);
-show_sensor_max_id(35);
-show_sensor_max_id(36);
-show_sensor_max_id(37);
-show_sensor_max_id(38);
-show_sensor_max_id(39);
-show_sensor_max_id(40);
-show_sensor_max_id(41);
-show_sensor_max_id(42);
-show_sensor_max_id(43);
-show_sensor_max_id(44);
-show_sensor_max_id(45);
-show_sensor_max_id(46);
-show_sensor_max_id(47);
-show_sensor_max_id(48);
-show_sensor_max_id(49);
-show_sensor_max_id(50);
-show_sensor_max_id(51);
-show_sensor_max_id(52);
-show_sensor_max_id(53);
-show_sensor_max_id(54);
-show_sensor_max_id(55);
-show_sensor_max_id(56);
-show_sensor_max_id(57);
-show_sensor_max_id(58);
-show_sensor_max_id(59);
-show_sensor_max_id(60);
-show_sensor_max_id(61);
-show_sensor_max_id(62);
-show_sensor_max_id(63);
-show_sensor_max_id(64);
-show_sensor_max_id(65);
-show_sensor_max_id(66);
-show_sensor_max_id(67);
-show_sensor_max_id(68);
-show_sensor_max_id(69);
-show_sensor_max_id(70);
-show_sensor_max_id(71);
-show_sensor_max_id(72);
-show_sensor_max_id(73);
-show_sensor_max_id(74);
-show_sensor_max_id(75);
-show_sensor_max_id(76);
-show_sensor_max_id(77);
-show_sensor_max_id(78);
-show_sensor_max_id(79);
-show_sensor_max_id(80);
-show_sensor_max_id(81);
-show_sensor_max_id(82);
-show_sensor_max_id(83);
-show_sensor_max_id(84);
-show_sensor_max_id(85);
-show_sensor_max_id(86);
-show_sensor_max_id(87);
-show_sensor_max_id(88);
-show_sensor_max_id(89);
-show_sensor_max_id(90);
-show_sensor_max_id(91);
-show_sensor_max_id(92);
-show_sensor_max_id(93);
-show_sensor_max_id(94);
-show_sensor_max_id(95);
-show_sensor_max_id(96);
-show_sensor_max_id(97);
-show_sensor_max_id(98);
-show_sensor_max_id(99);
-
-static show_callback show_max_fcn[] = {
-	show_sensor_max_0,
-	show_sensor_max_1,
-	show_sensor_max_2,
-	show_sensor_max_3,
-	show_sensor_max_4,
-	show_sensor_max_5,
-	show_sensor_max_6,
-	show_sensor_max_7,
-	show_sensor_max_8,
-	show_sensor_max_9,
-	show_sensor_max_10,
-	show_sensor_max_11,
-	show_sensor_max_12,
-	show_sensor_max_13,
-	show_sensor_max_14,
-	show_sensor_max_15,
-	show_sensor_max_16,
-	show_sensor_max_17,
-	show_sensor_max_18,
-	show_sensor_max_19,
-	show_sensor_max_20,
-	show_sensor_max_21,
-	show_sensor_max_22,
-	show_sensor_max_23,
-	show_sensor_max_24,
-	show_sensor_max_25,
-	show_sensor_max_26,
-	show_sensor_max_27,
-	show_sensor_max_28,
-	show_sensor_max_29,
-	show_sensor_max_30,
-	show_sensor_max_31,
-	show_sensor_max_32,
-	show_sensor_max_33,
-	show_sensor_max_34,
-	show_sensor_max_35,
-	show_sensor_max_36,
-	show_sensor_max_37,
-	show_sensor_max_38,
-	show_sensor_max_39,
-	show_sensor_max_40,
-	show_sensor_max_41,
-	show_sensor_max_42,
-	show_sensor_max_43,
-	show_sensor_max_44,
-	show_sensor_max_45,
-	show_sensor_max_46,
-	show_sensor_max_47,
-	show_sensor_max_48,
-	show_sensor_max_49,
-	show_sensor_max_50,
-	show_sensor_max_51,
-	show_sensor_max_52,
-	show_sensor_max_53,
-	show_sensor_max_54,
-	show_sensor_max_55,
-	show_sensor_max_56,
-	show_sensor_max_57,
-	show_sensor_max_58,
-	show_sensor_max_59,
-	show_sensor_max_60,
-	show_sensor_max_61,
-	show_sensor_max_62,
-	show_sensor_max_63,
-	show_sensor_max_64,
-	show_sensor_max_65,
-	show_sensor_max_66,
-	show_sensor_max_67,
-	show_sensor_max_68,
-	show_sensor_max_69,
-	show_sensor_max_70,
-	show_sensor_max_71,
-	show_sensor_max_72,
-	show_sensor_max_73,
-	show_sensor_max_74,
-	show_sensor_max_75,
-	show_sensor_max_76,
-	show_sensor_max_77,
-	show_sensor_max_78,
-	show_sensor_max_79,
-	show_sensor_max_80,
-	show_sensor_max_81,
-	show_sensor_max_82,
-	show_sensor_max_83,
-	show_sensor_max_84,
-	show_sensor_max_85,
-	show_sensor_max_86,
-	show_sensor_max_87,
-	show_sensor_max_88,
-	show_sensor_max_89,
-	show_sensor_max_90,
-	show_sensor_max_91,
-	show_sensor_max_92,
-	show_sensor_max_93,
-	show_sensor_max_94,
-	show_sensor_max_95,
-	show_sensor_max_96,
-	show_sensor_max_97,
-	show_sensor_max_98,
-	show_sensor_max_99,
-};
-
-static ssize_t show_sensor_min(struct device *dev, char *buf, int id)
+static ssize_t show_sensor_min(struct device *dev, char *buf, void *data)
 {
 	long min = 0;
+	struct sdrdata *sdrd = ((struct sdrdata *)data);
 
-	if (sdrd[id].lim2 >= 0)
-		min = conv_val(sdrd[id].limits[sdrd[id].lim2], &sdrd[id]);
+	if (sdrd->lim2 >= 0)
+		min = conv_val(sdrd->limits[sdrd->lim2], sdrd);
 	return snprintf(buf, 20, "%ld\n", min);
 };
 
-#define show_sensor_min_id(id) \
-static ssize_t show_sensor_min_##id (struct device *dev, char *buf) \
-{ \
-	return show_sensor_min(dev,buf,id); \
-};
-
-show_sensor_min_id(0);
-show_sensor_min_id(1);
-show_sensor_min_id(2);
-show_sensor_min_id(3);
-show_sensor_min_id(4);
-show_sensor_min_id(5);
-show_sensor_min_id(6);
-show_sensor_min_id(7);
-show_sensor_min_id(8);
-show_sensor_min_id(9);
-show_sensor_min_id(10);
-show_sensor_min_id(11);
-show_sensor_min_id(12);
-show_sensor_min_id(13);
-show_sensor_min_id(14);
-show_sensor_min_id(15);
-show_sensor_min_id(16);
-show_sensor_min_id(17);
-show_sensor_min_id(18);
-show_sensor_min_id(19);
-show_sensor_min_id(20);
-show_sensor_min_id(21);
-show_sensor_min_id(22);
-show_sensor_min_id(23);
-show_sensor_min_id(24);
-show_sensor_min_id(25);
-show_sensor_min_id(26);
-show_sensor_min_id(27);
-show_sensor_min_id(28);
-show_sensor_min_id(29);
-show_sensor_min_id(30);
-show_sensor_min_id(31);
-show_sensor_min_id(32);
-show_sensor_min_id(33);
-show_sensor_min_id(34);
-show_sensor_min_id(35);
-show_sensor_min_id(36);
-show_sensor_min_id(37);
-show_sensor_min_id(38);
-show_sensor_min_id(39);
-show_sensor_min_id(40);
-show_sensor_min_id(41);
-show_sensor_min_id(42);
-show_sensor_min_id(43);
-show_sensor_min_id(44);
-show_sensor_min_id(45);
-show_sensor_min_id(46);
-show_sensor_min_id(47);
-show_sensor_min_id(48);
-show_sensor_min_id(49);
-show_sensor_min_id(50);
-show_sensor_min_id(51);
-show_sensor_min_id(52);
-show_sensor_min_id(53);
-show_sensor_min_id(54);
-show_sensor_min_id(55);
-show_sensor_min_id(56);
-show_sensor_min_id(57);
-show_sensor_min_id(58);
-show_sensor_min_id(59);
-show_sensor_min_id(60);
-show_sensor_min_id(61);
-show_sensor_min_id(62);
-show_sensor_min_id(63);
-show_sensor_min_id(64);
-show_sensor_min_id(65);
-show_sensor_min_id(66);
-show_sensor_min_id(67);
-show_sensor_min_id(68);
-show_sensor_min_id(69);
-show_sensor_min_id(70);
-show_sensor_min_id(71);
-show_sensor_min_id(72);
-show_sensor_min_id(73);
-show_sensor_min_id(74);
-show_sensor_min_id(75);
-show_sensor_min_id(76);
-show_sensor_min_id(77);
-show_sensor_min_id(78);
-show_sensor_min_id(79);
-show_sensor_min_id(80);
-show_sensor_min_id(81);
-show_sensor_min_id(82);
-show_sensor_min_id(83);
-show_sensor_min_id(84);
-show_sensor_min_id(85);
-show_sensor_min_id(86);
-show_sensor_min_id(87);
-show_sensor_min_id(88);
-show_sensor_min_id(89);
-show_sensor_min_id(90);
-show_sensor_min_id(91);
-show_sensor_min_id(92);
-show_sensor_min_id(93);
-show_sensor_min_id(94);
-show_sensor_min_id(95);
-show_sensor_min_id(96);
-show_sensor_min_id(97);
-show_sensor_min_id(98);
-show_sensor_min_id(99);
-
-static show_callback show_min_fcn[] = {
-	show_sensor_min_0,
-	show_sensor_min_1,
-	show_sensor_min_2,
-	show_sensor_min_3,
-	show_sensor_min_4,
-	show_sensor_min_5,
-	show_sensor_min_6,
-	show_sensor_min_7,
-	show_sensor_min_8,
-	show_sensor_min_9,
-	show_sensor_min_10,
-	show_sensor_min_11,
-	show_sensor_min_12,
-	show_sensor_min_13,
-	show_sensor_min_14,
-	show_sensor_min_15,
-	show_sensor_min_16,
-	show_sensor_min_17,
-	show_sensor_min_18,
-	show_sensor_min_19,
-	show_sensor_min_20,
-	show_sensor_min_21,
-	show_sensor_min_22,
-	show_sensor_min_23,
-	show_sensor_min_24,
-	show_sensor_min_25,
-	show_sensor_min_26,
-	show_sensor_min_27,
-	show_sensor_min_28,
-	show_sensor_min_29,
-	show_sensor_min_30,
-	show_sensor_min_31,
-	show_sensor_min_32,
-	show_sensor_min_33,
-	show_sensor_min_34,
-	show_sensor_min_35,
-	show_sensor_min_36,
-	show_sensor_min_37,
-	show_sensor_min_38,
-	show_sensor_min_39,
-	show_sensor_min_40,
-	show_sensor_min_41,
-	show_sensor_min_42,
-	show_sensor_min_43,
-	show_sensor_min_44,
-	show_sensor_min_45,
-	show_sensor_min_46,
-	show_sensor_min_47,
-	show_sensor_min_48,
-	show_sensor_min_49,
-	show_sensor_min_50,
-	show_sensor_min_51,
-	show_sensor_min_52,
-	show_sensor_min_53,
-	show_sensor_min_54,
-	show_sensor_min_55,
-	show_sensor_min_56,
-	show_sensor_min_57,
-	show_sensor_min_58,
-	show_sensor_min_59,
-	show_sensor_min_60,
-	show_sensor_min_61,
-	show_sensor_min_62,
-	show_sensor_min_63,
-	show_sensor_min_64,
-	show_sensor_min_65,
-	show_sensor_min_66,
-	show_sensor_min_67,
-	show_sensor_min_68,
-	show_sensor_min_69,
-	show_sensor_min_70,
-	show_sensor_min_71,
-	show_sensor_min_72,
-	show_sensor_min_73,
-	show_sensor_min_74,
-	show_sensor_min_75,
-	show_sensor_min_76,
-	show_sensor_min_77,
-	show_sensor_min_78,
-	show_sensor_min_79,
-	show_sensor_min_80,
-	show_sensor_min_81,
-	show_sensor_min_82,
-	show_sensor_min_83,
-	show_sensor_min_84,
-	show_sensor_min_85,
-	show_sensor_min_86,
-	show_sensor_min_87,
-	show_sensor_min_88,
-	show_sensor_min_89,
-	show_sensor_min_90,
-	show_sensor_min_91,
-	show_sensor_min_92,
-	show_sensor_min_93,
-	show_sensor_min_94,
-	show_sensor_min_95,
-	show_sensor_min_96,
-	show_sensor_min_97,
-	show_sensor_min_98,
-	show_sensor_min_99,
-};
-
-
-static ssize_t show_sensor_label(struct device *dev, char *buf, int i)
+static ssize_t show_sensor_label(struct device *dev, char *buf, void *data)
 {
+	struct sdrdata *sdrd = ((struct sdrdata *)data);
 	u8 label[SDR_MAX_UNPACKED_ID_LENGTH];
-	ipmi_sprintf(label, sdrd[i].id, sdrd[i].string_type, sdrd[i].id_length);
+	ipmi_sprintf(label, sdrd->id, sdrd->string_type, sdrd->id_length);
 	return snprintf(buf, 20, "%s\n", label);
 };
 
-#define show_sensor_label_id(i) \
-static ssize_t show_sensor_label_##i (struct device *dev, char *buf) \
-{ \
-    return show_sensor_label(dev,buf,i);\
-};
-
-show_sensor_label_id(0);
-show_sensor_label_id(1);
-show_sensor_label_id(2);
-show_sensor_label_id(3);
-show_sensor_label_id(4);
-show_sensor_label_id(5);
-show_sensor_label_id(6);
-show_sensor_label_id(7);
-show_sensor_label_id(8);
-show_sensor_label_id(9);
-show_sensor_label_id(10);
-show_sensor_label_id(11);
-show_sensor_label_id(12);
-show_sensor_label_id(13);
-show_sensor_label_id(14);
-show_sensor_label_id(15);
-show_sensor_label_id(16);
-show_sensor_label_id(17);
-show_sensor_label_id(18);
-show_sensor_label_id(19);
-show_sensor_label_id(20);
-show_sensor_label_id(21);
-show_sensor_label_id(22);
-show_sensor_label_id(23);
-show_sensor_label_id(24);
-show_sensor_label_id(25);
-show_sensor_label_id(26);
-show_sensor_label_id(27);
-show_sensor_label_id(28);
-show_sensor_label_id(29);
-show_sensor_label_id(30);
-show_sensor_label_id(31);
-show_sensor_label_id(32);
-show_sensor_label_id(33);
-show_sensor_label_id(34);
-show_sensor_label_id(35);
-show_sensor_label_id(36);
-show_sensor_label_id(37);
-show_sensor_label_id(38);
-show_sensor_label_id(39);
-show_sensor_label_id(40);
-show_sensor_label_id(41);
-show_sensor_label_id(42);
-show_sensor_label_id(43);
-show_sensor_label_id(44);
-show_sensor_label_id(45);
-show_sensor_label_id(46);
-show_sensor_label_id(47);
-show_sensor_label_id(48);
-show_sensor_label_id(49);
-show_sensor_label_id(50);
-show_sensor_label_id(51);
-show_sensor_label_id(52);
-show_sensor_label_id(53);
-show_sensor_label_id(54);
-show_sensor_label_id(55);
-show_sensor_label_id(56);
-show_sensor_label_id(57);
-show_sensor_label_id(58);
-show_sensor_label_id(59);
-show_sensor_label_id(60);
-show_sensor_label_id(61);
-show_sensor_label_id(62);
-show_sensor_label_id(63);
-show_sensor_label_id(64);
-show_sensor_label_id(65);
-show_sensor_label_id(66);
-show_sensor_label_id(67);
-show_sensor_label_id(68);
-show_sensor_label_id(69);
-show_sensor_label_id(70);
-show_sensor_label_id(71);
-show_sensor_label_id(72);
-show_sensor_label_id(73);
-show_sensor_label_id(74);
-show_sensor_label_id(75);
-show_sensor_label_id(76);
-show_sensor_label_id(77);
-show_sensor_label_id(78);
-show_sensor_label_id(79);
-show_sensor_label_id(80);
-show_sensor_label_id(81);
-show_sensor_label_id(82);
-show_sensor_label_id(83);
-show_sensor_label_id(84);
-show_sensor_label_id(85);
-show_sensor_label_id(86);
-show_sensor_label_id(87);
-show_sensor_label_id(88);
-show_sensor_label_id(89);
-show_sensor_label_id(90);
-show_sensor_label_id(91);
-show_sensor_label_id(92);
-show_sensor_label_id(93);
-show_sensor_label_id(94);
-show_sensor_label_id(95);
-show_sensor_label_id(96);
-show_sensor_label_id(97);
-show_sensor_label_id(98);
-show_sensor_label_id(99);
-
-static show_callback show_label_fcn[] = {
-	show_sensor_label_0,
-	show_sensor_label_1,
-	show_sensor_label_2,
-	show_sensor_label_3,
-	show_sensor_label_4,
-	show_sensor_label_5,
-	show_sensor_label_6,
-	show_sensor_label_7,
-	show_sensor_label_8,
-	show_sensor_label_9,
-	show_sensor_label_10,
-	show_sensor_label_11,
-	show_sensor_label_12,
-	show_sensor_label_13,
-	show_sensor_label_14,
-	show_sensor_label_15,
-	show_sensor_label_16,
-	show_sensor_label_17,
-	show_sensor_label_18,
-	show_sensor_label_19,
-	show_sensor_label_20,
-	show_sensor_label_21,
-	show_sensor_label_22,
-	show_sensor_label_23,
-	show_sensor_label_24,
-	show_sensor_label_25,
-	show_sensor_label_26,
-	show_sensor_label_27,
-	show_sensor_label_28,
-	show_sensor_label_29,
-	show_sensor_label_30,
-	show_sensor_label_31,
-	show_sensor_label_32,
-	show_sensor_label_33,
-	show_sensor_label_34,
-	show_sensor_label_35,
-	show_sensor_label_36,
-	show_sensor_label_37,
-	show_sensor_label_38,
-	show_sensor_label_39,
-	show_sensor_label_40,
-	show_sensor_label_41,
-	show_sensor_label_42,
-	show_sensor_label_43,
-	show_sensor_label_44,
-	show_sensor_label_45,
-	show_sensor_label_46,
-	show_sensor_label_47,
-	show_sensor_label_48,
-	show_sensor_label_49,
-	show_sensor_label_50,
-	show_sensor_label_51,
-	show_sensor_label_52,
-	show_sensor_label_53,
-	show_sensor_label_54,
-	show_sensor_label_55,
-	show_sensor_label_56,
-	show_sensor_label_57,
-	show_sensor_label_58,
-	show_sensor_label_59,
-	show_sensor_label_60,
-	show_sensor_label_61,
-	show_sensor_label_62,
-	show_sensor_label_63,
-	show_sensor_label_64,
-	show_sensor_label_65,
-	show_sensor_label_66,
-	show_sensor_label_67,
-	show_sensor_label_68,
-	show_sensor_label_69,
-	show_sensor_label_70,
-	show_sensor_label_71,
-	show_sensor_label_72,
-	show_sensor_label_73,
-	show_sensor_label_74,
-	show_sensor_label_75,
-	show_sensor_label_76,
-	show_sensor_label_77,
-	show_sensor_label_78,
-	show_sensor_label_79,
-	show_sensor_label_80,
-	show_sensor_label_81,
-	show_sensor_label_82,
-	show_sensor_label_83,
-	show_sensor_label_84,
-	show_sensor_label_85,
-	show_sensor_label_86,
-	show_sensor_label_87,
-	show_sensor_label_88,
-	show_sensor_label_89,
-	show_sensor_label_90,
-	show_sensor_label_91,
-	show_sensor_label_92,
-	show_sensor_label_93,
-	show_sensor_label_94,
-	show_sensor_label_95,
-	show_sensor_label_96,
-	show_sensor_label_97,
-	show_sensor_label_98,
-	show_sensor_label_99,
-};
-
-static ssize_t store_max(struct device *dev, const char *buf, size_t count,
-			 int id)
+static ssize_t store_sensor_max(struct device *dev, const char *buf, size_t count,
+			 void *data)
 {
+	struct sdrdata *sdrd = ((struct sdrdata *)data);
 	long val = simple_strtoul(buf, NULL, 10);
 #ifdef DEBUG
-	printk(KERN_INFO "bmcsensors.o: set max on sensor #%d to %ld", id, val);
+	printk(KERN_INFO "bmcsensors.o: set max on sensor #%d to %ld", sdrd->id, val);
 #endif
-	bmcsensors_set_sensor_threshold(sdrd[id].number, val, sdrd[id].lim1);
+	bmcsensors_set_sensor_threshold(sdrd->number, val, sdrd->lim1);
 	return count;
 };
 
-#define store_max_id(i) \
-static ssize_t store_max_##i (struct device *dev, const char *buf, size_t count) \
-{ \
-    return store_max(dev,buf,count, i);\
-};
-
-store_max_id(0);
-store_max_id(1);
-store_max_id(2);
-store_max_id(3);
-store_max_id(4);
-store_max_id(5);
-store_max_id(6);
-store_max_id(7);
-store_max_id(8);
-store_max_id(9);
-store_max_id(10);
-store_max_id(11);
-store_max_id(12);
-store_max_id(13);
-store_max_id(14);
-store_max_id(15);
-store_max_id(16);
-store_max_id(17);
-store_max_id(18);
-store_max_id(19);
-store_max_id(20);
-store_max_id(21);
-store_max_id(22);
-store_max_id(23);
-store_max_id(24);
-store_max_id(25);
-store_max_id(26);
-store_max_id(27);
-store_max_id(28);
-store_max_id(29);
-store_max_id(30);
-store_max_id(31);
-store_max_id(32);
-store_max_id(33);
-store_max_id(34);
-store_max_id(35);
-store_max_id(36);
-store_max_id(37);
-store_max_id(38);
-store_max_id(39);
-store_max_id(40);
-store_max_id(41);
-store_max_id(42);
-store_max_id(43);
-store_max_id(44);
-store_max_id(45);
-store_max_id(46);
-store_max_id(47);
-store_max_id(48);
-store_max_id(49);
-store_max_id(50);
-store_max_id(51);
-store_max_id(52);
-store_max_id(53);
-store_max_id(54);
-store_max_id(55);
-store_max_id(56);
-store_max_id(57);
-store_max_id(58);
-store_max_id(59);
-store_max_id(60);
-store_max_id(61);
-store_max_id(62);
-store_max_id(63);
-store_max_id(64);
-store_max_id(65);
-store_max_id(66);
-store_max_id(67);
-store_max_id(68);
-store_max_id(69);
-store_max_id(70);
-store_max_id(71);
-store_max_id(72);
-store_max_id(73);
-store_max_id(74);
-store_max_id(75);
-store_max_id(76);
-store_max_id(77);
-store_max_id(78);
-store_max_id(79);
-store_max_id(80);
-store_max_id(81);
-store_max_id(82);
-store_max_id(83);
-store_max_id(84);
-store_max_id(85);
-store_max_id(86);
-store_max_id(87);
-store_max_id(88);
-store_max_id(89);
-store_max_id(90);
-store_max_id(91);
-store_max_id(92);
-store_max_id(93);
-store_max_id(94);
-store_max_id(95);
-store_max_id(96);
-store_max_id(97);
-store_max_id(98);
-store_max_id(99);
-
-static store_callback store_max_fcn[] = {
-	store_max_0,
-	store_max_1,
-	store_max_2,
-	store_max_3,
-	store_max_4,
-	store_max_5,
-	store_max_6,
-	store_max_7,
-	store_max_8,
-	store_max_9,
-	store_max_10,
-	store_max_11,
-	store_max_12,
-	store_max_13,
-	store_max_14,
-	store_max_15,
-	store_max_16,
-	store_max_17,
-	store_max_18,
-	store_max_19,
-	store_max_20,
-	store_max_21,
-	store_max_22,
-	store_max_23,
-	store_max_24,
-	store_max_25,
-	store_max_26,
-	store_max_27,
-	store_max_28,
-	store_max_29,
-	store_max_30,
-	store_max_31,
-	store_max_32,
-	store_max_33,
-	store_max_34,
-	store_max_35,
-	store_max_36,
-	store_max_37,
-	store_max_38,
-	store_max_39,
-	store_max_40,
-	store_max_41,
-	store_max_42,
-	store_max_43,
-	store_max_44,
-	store_max_45,
-	store_max_46,
-	store_max_47,
-	store_max_48,
-	store_max_49,
-	store_max_50,
-	store_max_51,
-	store_max_52,
-	store_max_53,
-	store_max_54,
-	store_max_55,
-	store_max_56,
-	store_max_57,
-	store_max_58,
-	store_max_59,
-	store_max_60,
-	store_max_61,
-	store_max_62,
-	store_max_63,
-	store_max_64,
-	store_max_65,
-	store_max_66,
-	store_max_67,
-	store_max_68,
-	store_max_69,
-	store_max_70,
-	store_max_71,
-	store_max_72,
-	store_max_73,
-	store_max_74,
-	store_max_75,
-	store_max_76,
-	store_max_77,
-	store_max_78,
-	store_max_79,
-	store_max_80,
-	store_max_81,
-	store_max_82,
-	store_max_83,
-	store_max_84,
-	store_max_85,
-	store_max_86,
-	store_max_87,
-	store_max_88,
-	store_max_89,
-	store_max_90,
-	store_max_91,
-	store_max_92,
-	store_max_93,
-	store_max_94,
-	store_max_95,
-	store_max_96,
-	store_max_97,
-	store_max_98,
-	store_max_99,
-};
-
-static ssize_t store_min(struct device *dev, const char *buf, size_t count,
-			 int id)
+static ssize_t store_sensor_min(struct device *dev, const char *buf, size_t count,
+			 void *data)
 {
+	struct sdrdata *sdrd = ((struct sdrdata *)data);
 	long val = simple_strtoul(buf, NULL, 10);
 #ifdef DEBUG
-	printk(KERN_INFO "bmcsensors.o: set min on sensor #%d to %ld", id, val);
+	printk(KERN_INFO "bmcsensors.o: set min on sensor #%d to %ld", sdrd->id, val);
 #endif
-	bmcsensors_set_sensor_threshold(sdrd[id].number, val, sdrd[id].lim2);
+	bmcsensors_set_sensor_threshold(sdrd->number, val, sdrd->lim2);
 	return count;
 };
 
-#define store_min_id(i) \
-static ssize_t store_min_##i (struct device *dev, const char *buf, size_t count) \
-{ \
-    return store_min(dev,buf,count, i);\
-};
-
-store_min_id(0);
-store_min_id(1);
-store_min_id(2);
-store_min_id(3);
-store_min_id(4);
-store_min_id(5);
-store_min_id(6);
-store_min_id(7);
-store_min_id(8);
-store_min_id(9);
-store_min_id(10);
-store_min_id(11);
-store_min_id(12);
-store_min_id(13);
-store_min_id(14);
-store_min_id(15);
-store_min_id(16);
-store_min_id(17);
-store_min_id(18);
-store_min_id(19);
-store_min_id(20);
-store_min_id(21);
-store_min_id(22);
-store_min_id(23);
-store_min_id(24);
-store_min_id(25);
-store_min_id(26);
-store_min_id(27);
-store_min_id(28);
-store_min_id(29);
-store_min_id(30);
-store_min_id(31);
-store_min_id(32);
-store_min_id(33);
-store_min_id(34);
-store_min_id(35);
-store_min_id(36);
-store_min_id(37);
-store_min_id(38);
-store_min_id(39);
-store_min_id(40);
-store_min_id(41);
-store_min_id(42);
-store_min_id(43);
-store_min_id(44);
-store_min_id(45);
-store_min_id(46);
-store_min_id(47);
-store_min_id(48);
-store_min_id(49);
-store_min_id(50);
-store_min_id(51);
-store_min_id(52);
-store_min_id(53);
-store_min_id(54);
-store_min_id(55);
-store_min_id(56);
-store_min_id(57);
-store_min_id(58);
-store_min_id(59);
-store_min_id(60);
-store_min_id(61);
-store_min_id(62);
-store_min_id(63);
-store_min_id(64);
-store_min_id(65);
-store_min_id(66);
-store_min_id(67);
-store_min_id(68);
-store_min_id(69);
-store_min_id(70);
-store_min_id(71);
-store_min_id(72);
-store_min_id(73);
-store_min_id(74);
-store_min_id(75);
-store_min_id(76);
-store_min_id(77);
-store_min_id(78);
-store_min_id(79);
-store_min_id(80);
-store_min_id(81);
-store_min_id(82);
-store_min_id(83);
-store_min_id(84);
-store_min_id(85);
-store_min_id(86);
-store_min_id(87);
-store_min_id(88);
-store_min_id(89);
-store_min_id(90);
-store_min_id(91);
-store_min_id(92);
-store_min_id(93);
-store_min_id(94);
-store_min_id(95);
-store_min_id(96);
-store_min_id(97);
-store_min_id(98);
-store_min_id(99);
-
-static store_callback store_min_fcn[] = {
-	store_min_0,
-	store_min_1,
-	store_min_2,
-	store_min_3,
-	store_min_4,
-	store_min_5,
-	store_min_6,
-	store_min_7,
-	store_min_8,
-	store_min_9,
-	store_min_10,
-	store_min_11,
-	store_min_12,
-	store_min_13,
-	store_min_14,
-	store_min_15,
-	store_min_16,
-	store_min_17,
-	store_min_18,
-	store_min_19,
-	store_min_20,
-	store_min_21,
-	store_min_22,
-	store_min_23,
-	store_min_24,
-	store_min_25,
-	store_min_26,
-	store_min_27,
-	store_min_28,
-	store_min_29,
-	store_min_30,
-	store_min_31,
-	store_min_32,
-	store_min_33,
-	store_min_34,
-	store_min_35,
-	store_min_36,
-	store_min_37,
-	store_min_38,
-	store_min_39,
-	store_min_40,
-	store_min_41,
-	store_min_42,
-	store_min_43,
-	store_min_44,
-	store_min_45,
-	store_min_46,
-	store_min_47,
-	store_min_48,
-	store_min_49,
-	store_min_50,
-	store_min_51,
-	store_min_52,
-	store_min_53,
-	store_min_54,
-	store_min_55,
-	store_min_56,
-	store_min_57,
-	store_min_58,
-	store_min_59,
-	store_min_60,
-	store_min_61,
-	store_min_62,
-	store_min_63,
-	store_min_64,
-	store_min_65,
-	store_min_66,
-	store_min_67,
-	store_min_68,
-	store_min_69,
-	store_min_70,
-	store_min_71,
-	store_min_72,
-	store_min_73,
-	store_min_74,
-	store_min_75,
-	store_min_76,
-	store_min_77,
-	store_min_78,
-	store_min_79,
-	store_min_80,
-	store_min_81,
-	store_min_82,
-	store_min_83,
-	store_min_84,
-	store_min_85,
-	store_min_86,
-	store_min_87,
-	store_min_88,
-	store_min_89,
-	store_min_90,
-	store_min_91,
-	store_min_92,
-	store_min_93,
-	store_min_94,
-	store_min_95,
-	store_min_96,
-	store_min_97,
-	store_min_98,
-	store_min_99,
-};
-
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *data)
 {
 	bmcsensors_update_client(&bmc_client);
 	return snprintf(buf, 20, "%d\n", bmc_data.alarms);
@@ -1703,6 +436,8 @@ static void bmcsensors_build_sysfs()
 			    (struct device_attribute *)
 			    kmalloc(sizeof(struct device_attribute),
 				    GFP_KERNEL);
+			sysfs_attribute_label->data = &sdrd[i];
+			
 			if (sysfs_attribute_label = NULL
 			    || sensor_label = NULL) {
 				printk(KERN_INFO
@@ -1777,15 +512,17 @@ static void bmcsensors_build_sysfs()
 		sysfs_attribute->attr.name = sensor_name;
 		sysfs_attribute->attr.mode = S_IRUGO;
 		sysfs_attribute->attr.owner = THIS_MODULE;
-		sysfs_attribute->show = show_fcn[i];
+		sysfs_attribute->show = show_sensor;
 		sysfs_attribute->store = NULL;
-
+		sysfs_attribute->data = &sdrd[i];
+		
 		sysfs_attribute_min->attr.name = sensor_minname;
 		sysfs_attribute_min->attr.owner = THIS_MODULE;
-		sysfs_attribute_min->show = show_min_fcn[i];
+		sysfs_attribute_min->show = show_sensor_min;
+		sysfs_attribute_min->data = &sdrd[i];
 
 		if (sdrd[i].lim2_write) {
-			sysfs_attribute_min->store = store_min_fcn[i];
+			sysfs_attribute_min->store = store_sensor_min;
 			sysfs_attribute_min->attr.mode = S_IWUSR | S_IRUGO;
 		} else {
 			sysfs_attribute_min->store = NULL;
@@ -1793,12 +530,12 @@ static void bmcsensors_build_sysfs()
 		}
 
 		sysfs_attribute_max->attr.name = sensor_maxname;
-
 		sysfs_attribute_max->attr.owner = THIS_MODULE;
-		sysfs_attribute_max->show = show_max_fcn[i];
+		sysfs_attribute_max->show = show_sensor_max;
+		sysfs_attribute_max->data = &sdrd[i];
 
 		if (sdrd[i].lim1_write) {
-			sysfs_attribute_max->store = store_max_fcn[i];
+			sysfs_attribute_max->store = store_sensor_max;
 			sysfs_attribute_max->attr.mode = S_IWUSR | S_IRUGO;
 		} else {
 			sysfs_attribute_max->store = NULL;
@@ -1809,7 +546,7 @@ static void bmcsensors_build_sysfs()
 			sysfs_attribute_label->attr.name = sensor_label;
 			sysfs_attribute_label->attr.mode = S_IRUGO;
 			sysfs_attribute_label->attr.owner = THIS_MODULE;
-			sysfs_attribute_label->show = show_label_fcn[i];
+			sysfs_attribute_label->show = show_sensor_label;
 			sysfs_attribute_label->store = NULL;
 		}
 




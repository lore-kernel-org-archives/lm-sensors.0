From: jim.cromie@gmail.com (Jim Cromie)
Date: Sun, 27 Aug 2006 18:34:30 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks
Message-Id: <44F1E5B6.1080105@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

once again with the email-harvesting / communication/coordination.

<quoting Jean, I think>

BTW, do you have any plan to convert the asb100 driver to use the
"dynamic" sysfs callbacks? This would kill some more macros, and shrink
the driver size even more.


The approx list of 'opportunities' here is:

[jimc at harpo ac-2]$ grep -rl '##' drivers/hwmon/*.c
drivers/hwmon/abituguru.c
drivers/hwmon/adm1021.c
drivers/hwmon/adm1025.c
drivers/hwmon/adm1026.c	 - patch on hold, needs tester.
drivers/hwmon/adm1031.c
drivers/hwmon/adm9240.c
drivers/hwmon/asb100.c
drivers/hwmon/ds1621.c
drivers/hwmon/fscher.c
drivers/hwmon/fscpos.c
drivers/hwmon/gl518sm.c
drivers/hwmon/gl520sm.c
drivers/hwmon/it87.c
drivers/hwmon/lm75.c
drivers/hwmon/lm77.c
drivers/hwmon/lm78.c
drivers/hwmon/lm80.c
drivers/hwmon/lm85.c
drivers/hwmon/lm87.c
drivers/hwmon/lm92.c
drivers/hwmon/max1619.c
drivers/hwmon/sis5595.c
drivers/hwmon/smsc47b397.c
drivers/hwmon/smsc47m192.c
drivers/hwmon/smsc47m1.c
drivers/hwmon/via686a.c
drivers/hwmon/vt8231.c
drivers/hwmon/w83627ehf.c
drivers/hwmon/w83627hf.c
drivers/hwmon/w83781d.c
drivers/hwmon/w83791d.c
drivers/hwmon/w83792d.c



"dynamic" sysfs callbacks is :


current code base has lots of macros which are essentially
static inline functions, but which are 'parameterized' by
'inserting' an ##offset## into the function name, and 'invoking'
the macro repeatedly for multiple instances of a sensor.

an example should clarify. (from w83781d.c, chosen arbitrarily)

    341 static ssize_t store_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, const
    341 char *buf, size_t count) \
    342 { \
    343         return store_in_##reg (dev, buf, count, offset); \
    344 } \
    345 static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_in_##reg##offset, store_regs_in_##reg##offset);
    346
    347 #define sysfs_in_offsets(offset) \
    348 sysfs_in_offset(offset); \
    349 sysfs_in_reg_offset(min, offset); \
    350 sysfs_in_reg_offset(max, offset);
    351
    352 sysfs_in_offsets(0);
    353 sysfs_in_offsets(1);
    354 sysfs_in_offsets(2);
    355 sysfs_in_offsets(3);
    356 sysfs_in_offsets(4);
    357 sysfs_in_offsets(5);
    358 sysfs_in_offsets(6);
    359 sysfs_in_offsets(7);
    360 sysfs_in_offsets(8);

Once these macros are expanded and compiled, we get a multitude
of nearly identical routines.

[jimc at harpo hwmon]$ nm  -S w83781d.o | grep store_regs_
00001461 00000011 t store_regs_beep_enable
00001472 00000011 t store_regs_beep_mask
00002971 00000011 t store_regs_fan_div_1
00002982 00000011 t store_regs_fan_div_2
00002993 00000011 t store_regs_fan_div_3
00000589 00000011 t store_regs_fan_min1
0000059a 00000011 t store_regs_fan_min2
000005ab 00000011 t store_regs_fan_min3
00000428 00000011 t store_regs_in_max0
00000439 00000011 t store_regs_in_max1
0000044a 00000011 t store_regs_in_max2
0000045b 00000011 t store_regs_in_max3
0000046c 00000011 t store_regs_in_max4
0000047d 00000011 t store_regs_in_max5
0000048e 00000011 t store_regs_in_max6
0000049f 00000011 t store_regs_in_max7
000004b0 00000011 t store_regs_in_max8
000002f6 00000011 t store_regs_in_min0
00000307 00000011 t store_regs_in_min1
00000318 00000011 t store_regs_in_min2
00000329 00000011 t store_regs_in_min3
0000033a 00000011 t store_regs_in_min4
0000034b 00000011 t store_regs_in_min5
0000035c 00000011 t store_regs_in_min6
0000036d 00000011 t store_regs_in_min7
0000037e 00000011 t store_regs_in_min8


The macros can be converted to proper static inlines,
and parameterized properly so that 1 func does the job for all 8
inputs above.

static ssize_t show_fan_min(struct device *dev, struct device_attribute *devattr, char *buf)
{

	/*THIS IS THE KEY*/
        struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	int index = attr->index;

        struct pc87360_data *data = pc87360_update_device(dev);
        return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[index],
                       FAN_DIV_FROM_REG(data->fan_status[index])));
}

static struct sensor_device_attribute fan_min[] = {
        SENSOR_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 0),
        SENSOR_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 1),
        SENSOR_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 2),
};


There are 2 things going on here.

1 - the function back-casts from a base-type to another that 
aggregates another parameter (index), which is then available
to distinguish which of many (fan) sensors is being requested.

2 - the SENSOR_ATTR initializes the index field (0,1,2 above)
So when the function is called, it can use that index.




*Deeper 'dynamic's are possible*

The above folds multiple callbacks on 1 dimension (index)
to reduce code footprint, but more are possible.



following 2 steps above:

1. function now relys on being passed a struct sensor_device_attribute_2
which has 2 additional parameters; index, and nr.  This example uses
2nd parameter to distinguish which attribute of the sensor is being
requested (index still chooses 1 of N sensors)
 
static ssize_t show_fan(struct device *dev, struct device_attribute *devattr, char *buf)
{
        struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
        int idx = attr->index;
        int func = attr->nr;
        struct pc87360_data *data = pc87360_update_device(dev);
        unsigned res = -1;

        switch(func) {
        case FN_FAN_INPUT:
                res = FAN_FROM_REG(data->fan[idx],
                                   FAN_DIV_FROM_REG(data->fan_status[idx]));
                break;
        case FN_FAN_MIN:
                res = FAN_FROM_REG(data->fan_min[idx],
                                   FAN_DIV_FROM_REG(data->fan_status[idx]));
                break;
        case FN_FAN_STATUS:
                res = FAN_STATUS_FROM_REG(data->fan_status[idx]);
                break;
        case FN_FAN_DIV:
                res = FAN_DIV_FROM_REG(data->fan_status[idx]);
                break;
        default:
                printk(KERN_ERR "unknown attr fetch\n");
        }
        return sprintf(buf, "%u\n", res);
}


2.  declare attributes like so.
Note that show_fan is the callback for both fan_input[]s, and fan_status[]s,
as well as the others (DIV,MIN) above.

static struct sensor_device_attribute_2 fan_input[] = {
        SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, FN_FAN_INPUT, 0),
        SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, FN_FAN_INPUT, 1),
        SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, FN_FAN_INPUT, 2),
};
static struct sensor_device_attribute_2 fan_status[] = {
        SENSOR_ATTR_2(fan1_status, S_IRUGO, show_fan, NULL, FN_FAN_STATUS, 0),
        SENSOR_ATTR_2(fan2_status, S_IRUGO, show_fan, NULL, FN_FAN_STATUS, 1),
        SENSOR_ATTR_2(fan3_status, S_IRUGO, show_fan, NULL, FN_FAN_STATUS, 2),
};


NB - show, set routines can never be combined, due to different fn-signatures.
NB - technique saves ~ 9% object code on 1 driver.


This "2-D dynamic callback" approach is not widely used,
currently only done in:
	w83792d.c, abituguru.c.
patches which use it:
	vt1211.c - going in soon I believe (congrats Juerg)
	pc87360.c - 
	- unreviewed, patch 3/3 has some annoying screwups in the attr mapping,
	- as visible above (DIV vs fan_status, will recheck/redo)
	case FN_FAN_DIV:
                res = FAN_DIV_FROM_REG(data->fan_status[idx]);







From: "David C. Rankin" <drankinatty@suddenlinkmail.com>
Date: Mon, 20 Oct 2008 03:46:50 +0000
Subject: [lm-sensors] f71882fg-* How do you set temp limits for max_hyst and
Message-Id: <48FBFF2A.608@suddenlinkmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sensor Devs,

	I have an MSI K9N2 SLI Platinum board that has the f71882fg- chip. I am unable
to set the tempX_max_hyst and tempX_crit_hyst temperature limits with
sensors-3.0.2-4.1. Attempting to set the values results in the normal error
messages on sensors -s:

Error: Line 70: Unknown feature name
Error: Line 71: Unknown feature name
f71882fg-isa-0a00: No such subfeature known

	I google and found an old kernel.org message related to the data structure:

+struct f71882fg_data {
+       unsigned short addr;
+       struct class_device *class_dev;
+
+       struct mutex update_lock;
+       char valid;                     /* !=0 if following fields are valid */
+       unsigned long last_updated;     /* In jiffies */
+       unsigned long last_limits;      /* In jiffies */
+
+       /* Register Values */
+       u8      in[9];
+       u8      in1_max;
+       u8      in_status;
+       u8      in_beep;
+       u16     fan[4];
+       u8      fan_status;
+       u8      fan_beep;
+       u8      temp[3];
+       u8      temp_ovt[3];
+       u8      temp_high[3];
+       u8      temp_hyst[3];
+       u8      temp_type[3];
+       u8      temp_status;
+       u8      temp_beep;
+       u8      temp_diode_open;
+};
+
+static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg);
+static u16 f71882fg_read16(struct f71882fg_data *data, u8 reg);
+static void f71882fg_write8(struct f71882fg_data *data, u8 reg, u8 val);
+
+/* Sysfs in*/
+static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
+       char *buf);
+static ssize_t show_in_max(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t store_in_max(struct device *dev, struct device_attribute
+       *devattr, const char *buf, size_t count);
+static ssize_t show_in_beep(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t store_in_beep(struct device *dev, struct device_attribute
+       *devattr, const char *buf, size_t count);
+static ssize_t show_in_alarm(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+/* Sysfs Fan */
+static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
+       char *buf);
+static ssize_t show_fan_beep(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t store_fan_beep(struct device *dev, struct device_attribute
+       *devattr, const char *buf, size_t count);
+static ssize_t show_fan_alarm(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+/* Sysfs Temp */
+static ssize_t show_temp(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t show_temp_max(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t store_temp_max(struct device *dev, struct device_attribute
+       *devattr, const char *buf, size_t count);
+static ssize_t show_temp_max_hyst(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t store_temp_max_hyst(struct device *dev, struct device_attribute
+       *devattr, const char *buf, size_t count);
+static ssize_t show_temp_crit(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t store_temp_crit(struct device *dev, struct device_attribute
+       *devattr, const char *buf, size_t count);
+static ssize_t show_temp_crit_hyst(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t show_temp_type(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t show_temp_beep(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t store_temp_beep(struct device *dev, struct device_attribute
+       *devattr, const char *buf, size_t count);
+static ssize_t show_temp_alarm(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+static ssize_t show_temp_fault(struct device *dev, struct device_attribute
+       *devattr, char *buf);
+/* Sysfs misc */
+static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
+       char *buf);

	That suggest that I should be able to configure the limits with something like:

# Set CPU and System temp limits

    set temp1_max_hyst 50
    set temp1_max 55
    set temp1_crit_hyst 56
    set temp1_crit 60
    set temp2_max_hyst 50
    set temp2_max 55
    set temp2_crit_hyst 56
    set temp2_crit 60

	However, all of the _hyst settings result in the errors explained above. So,
how do you set the hyst limits with this chipset?

	If you need additional information, please just ask and I'll be glad to
provide it. Also, I tried enabling temp3 and that resulted in a wild value of
127 deg.C which is way off-scale high. Any ideas what this sensor does?

Thanks.

-- 
David C. Rankin, J.D., P.E.
Rankin Law Firm, PLLC
www.rankinlawfirm.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

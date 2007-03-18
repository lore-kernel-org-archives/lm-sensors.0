From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 18 Mar 2007 14:16:30 +0000
Subject: [lm-sensors] http://www.lm-sensors.org/ticket/2188
Message-Id: <45FD49BE.2000904@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703150941v6af08f75k7f8ef5dea70d8264@mail.gmail.com>
In-Reply-To: <191fb4ca0703150941v6af08f75k7f8ef5dea70d8264@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> Hans,
> 
> Yes, the deal is on.
> Do you have a datasheet you could share?
> Unfortunately I can't share the datasheet for the DME1737, I'm under NDA.
> 

Ok, so here is my review of your driver:

General remarks:
- i2x writes / read status never gets checked anywhere, I dunno if this is done
   in other lm_sensors drivers similary, but IMHO these things should be
   checked!

---

+/* temperature input */
+static int TEMP_FROM_REG(int reg, int res)
+{
+	return (((reg & (1 << (res - 1))) ? reg - (1 << res) : reg) *
+		1000 / (1 << (res - 8)));
+}
+
+static int TEMP_TO_REG(int val, int res)
+{
+	int temp = val * (1 << (res - 8)) / 1000;
+	return SENSORS_LIMIT((temp < 0) ? temp + (1 << res) : temp,
+			     0, (1 << res) - 1 );
+}

Wouldn't it be better readable / clearer when instead of:
"x * 1000 / (1 << (res - 8))" you write "(x * 1000) >> (res - 8)" ?
And the same for TEMP_TO_REG, instead of: "val * (1 << (res - 8)) / 1000",
write: "(val << (res - 8)) / 1000" ?

Then its clear (to me) at once that you're changing a 8.x bits fixed resolution
value to a res bits resolution value and vica versa.

---

+static int TEMP_HYST_FROM_REG(int reg, int ix) {
+	return ((((ix = 1) ? reg : reg >> 4) & 0x0f) * 1000);
+}
+
+static int TEMP_HYST_TO_REG(int val, int ix, int reg)
+{
+	int hyst = SENSORS_LIMIT(val, 0, 15);
+	return ((ix = 1) ? (reg & 0xf0) | hyst : (reg & 0x0f) | (hyst << 4));
+}

This doesn't seem consistent, when getting a hyst from the reg you multiply it
by 1000 making it ready for sysfs, but when storing it to the reg, you don't
divide it by 1000 (which should be done before the limit, or the limit should
be adjusted)

Actually when using TEMP_HYST_TO_REG here:
+	case SYS_TEMP_AUTO_POINT1_TEMP_HYST:
+		data->zone_hyst[ix = 2] = TEMP_HYST_TO_REG(
+					TEMP_FROM_REG(data->zone_low[ix], 8) -
+					val, ix, dme1737_read(client,
+					DME1737_REG_ZONE_HYST(ix = 2)));
+		dme1737_write(client, DME1737_REG_ZONE_HYST(ix = 2),
+			      data->zone_hyst[ix = 2]);
+		break;

You don't divide the temp past to TEMP_HYST_TO_REG by 1000, so its not
inconsistent its actually a bug (fix please).

---

Please add a comment that the pwm_freq registers hold the pwm freq in the lower 
nibble and the temp_range for the speed control in the higher nibble, without 
such a comment, this code looks rather strange:
+	case SYS_TEMP_AUTO_POINT2_TEMP:
+		res = TEMP_FROM_REG(data->zone_low[ix], 8) +
+		      TEMP_RANGE_FROM_REG(data->pwm_freq[ix]);
+		break;

---

+	case SYS_TEMP_AUTO_POINT2_TEMP:
+		data->pwm_freq[ix] = TEMP_RANGE_TO_REG(val -
+					TEMP_FROM_REG(data->zone_low[ix], 8),
+					dme1737_read(client,
+					DME1737_REG_PWM_FREQ(ix)));

Why do you use the cached temp here, but not the cached pwm_freq reg contents?? 
Notice that you do this in several places.

---

+#define SYS_PWM				0
+#define SYS_PWM_FREQ			2
+#define SYS_PWM_ENABLE			3
+#define SYS_PWM_RAMP_RATE		4
+#define SYS_PWM_AUTO_CHANNELS_TEMP	5
+#define SYS_PWM_AUTO_POINT1_PWM		6
+#define SYS_PWM_AUTO_POINT2_PWM		7

Why is 1 not used in this "enum" ?

---

Wouldn't it be cleaner to instead of:
+#define SENSOR_ATTR_FAN_1TO4(ix) \
+	SENSOR_ATTR_2(fan##ix##_type, S_IRUGO | S_IWUSR, \
+		show_fan, set_fan, SYS_FAN_TYPE, ix-1)
write:
+#define SENSOR_ATTR_FAN_1TO4(ix) \
+       SENSOR_ATTR_FAN(ix) \
+	SENSOR_ATTR_2(fan##ix##_type, S_IRUGO | S_IWUSR, \
+		show_fan, set_fan, SYS_FAN_TYPE, ix-1)

And idem for 5to6, and the instead of:
+	/* fans */
+	SENSOR_ATTR_FAN(1),
+	SENSOR_ATTR_FAN(2),
+	SENSOR_ATTR_FAN(3),
+	SENSOR_ATTR_FAN(4),
+	SENSOR_ATTR_FAN(5),
+	SENSOR_ATTR_FAN(6),
+	/* fan[1-4] unique attrs */
+	SENSOR_ATTR_FAN_1TO4(1),
+	SENSOR_ATTR_FAN_1TO4(2),
+	SENSOR_ATTR_FAN_1TO4(3),
+	SENSOR_ATTR_FAN_1TO4(4),
+	/* fan[5-6] unique attrs */
+	SENSOR_ATTR_FAN_5TO6(5),
+	SENSOR_ATTR_FAN_5TO6(6),

write:
+	/* fans */
+	SENSOR_ATTR_FAN_1TO4(1),
+	SENSOR_ATTR_FAN_1TO4(2),
+	SENSOR_ATTR_FAN_1TO4(3),
+	SENSOR_ATTR_FAN_1TO4(4),
+	SENSOR_ATTR_FAN_5TO6(5),
+	SENSOR_ATTR_FAN_5TO6(6),



Well thats it all in all it looks like a clean driver to me.

Regards,

Hans


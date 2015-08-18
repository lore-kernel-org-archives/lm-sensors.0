From: Frank Schaefer <kelledin@gmail.com>
Date: Tue, 18 Aug 2015 06:38:40 +0000
Subject: [lm-sensors] [PATCH] add Enermax DigiFanless HID/hwmon driver
Message-Id: <20150818013840.7b949f7d3207e7d5088f6337@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, linux-input@vger.kernel.org

This driver adds support for the monitoring logic in the Enermax DigiFanless
550W (EDF550AWN) power supply.  It spans the HID and hwmon subsystems, so I
decided it needs review from both maintainer teams.  (I'm still aiming for it
to filter through the hwmon linux-staging repo).

Signed-off-by: Frank Schaefer <kelledin@gmail.com>
---
 Documentation/hwmon/zdpms | 107 ++++++
 drivers/hid/Kconfig       |  16 +
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-core.c    |   1 +
 drivers/hid/hid-ids.h     |   1 +
 drivers/hid/hid-zdpms.c   | 828 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 954 insertions(+)
 create mode 100644 Documentation/hwmon/zdpms
 create mode 100644 drivers/hid/hid-zdpms.c

diff --git a/Documentation/hwmon/zdpms b/Documentation/hwmon/zdpms
new file mode 100644
index 0000000..98a4cdc
--- /dev/null
+++ b/Documentation/hwmon/zdpms
@@ -0,0 +1,107 @@
+Kernel driver hid-zdpms
+===========+
+Supported chips:
+  * Enermax DigiFanless 550W PIC (Microchip PIC32MX230F064D)
+    Prefix: 'zdpms'
+    Addresses scanned: USB HID space
+    Datasheet: Still not published
+
+Authors:
+        Frank Schaefer <kelledin@gmail.com>
+
+Module Parameters
+-----------------
+
+zdpms_timeout=timeout   Set the ZDPMS transaction timeout in milliseconds
+                        (default 100 ms).  This is clamped to a minimum of 20
+                        milliseconds, because accuracy is spotty with anything
+                        less.
+                        Example: 'modprobe hid-zdpms zdpms_timeoutP0'
+zdpms_12v_config=<int>  Set the 12V rail configuration (1 for single rail, 2
+                        for dual rail).  By default the rail configuration is
+                        left untouched.
+                        Example: 'modprobe hid-zdpms zdpms_12v_config=2'
+
+Description
+-----------
+
+The Enermax DigiFanless 550W power supply has an integrated Microchip
+32-bit peripheral interface controller (PIC), running a specialized
+application to monitor internal power-supply sensors and handle some
+incidental user-controllable configuration (mainly the 12V rail
+configuration).  This controller application communicates with the host
+via USB raw Human Interface Device (HID) protocol, using a custom OEM
+usage table and failing to disclose the required report descriptors via
+standard HID enumeration.  This controller is the foundation of the
+Enermax Zero-Delay Power Monitoring System (ZDPMS), which is apparently
+supported by Enermax only through a proprietary Windows application.
+
+The Microchip PIC application implements voltage and current sensors for
+all internal DC rails (12V1, 12V2, 5V, and 3.3V), an internal temperature
+sensor, and an AC input voltage sensor, all of which we are able to query.
+There are also supposedly shutdown thresholds for overvoltage protection
+and overtemp protection, but as near as i can tell, they are hardcoded and
+firmly out of software's reach.
+
+Sensor values are reported by the PIC in an odd format similar to (but
+not quite identical to) IEEE 754 half-precision floating-point.  They
+seem to have a 5-bit exponent and no sign field, and the leading '1' bit
+implicit in IEEE 754 mantissa fields is apparently explicit here.  The
+exponent also appears to be a fixed value for each sensor, implying that
+each sensor has its own fixed range and precision.  The apparent lack of
+a sign bit implies that all sensor readings are lower-bounded at zero.
+
+Voltage sensors (also known as IN sensors) report their values in volts;
+current sensors (known as CURR sensors) report their values in amperes.
+The only known temperature sensor reports its value in degrees Celcius.
+Applications such as the Enermax OEM application are supposedly expected
+to calculate watts in software using the information supplied in voltage
+and amperage sensors (although we currently lack enough sensor readings
+to calculate all AC input properties).
+
+Supposedly, if any sensor reading crosses its hardcoded alarm threshold,
+the power supply will shut down, presumably powering down the embedded
+Microchip PIC as well (although we have yet to confirm this empirically).
+So any software alarms are probably superfluous.
+
+It is unknown how often the Microchip PIC will measure internal sensor
+readings, although the "zero delay" terminology implies that it is near
+instantaneous (which seems appropriate for overvoltage protection).
+The driver queries the PIC every time userland reads a sensor token via
+sysfs but does no internal monitoring of its own.
+
+Known Issues
+------------
+
+This driver identifies the Enermax PIC controller application by USB
+vendor and product ID.  Unfortunately, it is specifically advertising a
+Microchip vendor ID rather than an Enermax vendor ID, and the product ID
+is an otherwise unknown value.  Even worse, it does not advertise any
+vendor, product, or serial number string through HID enumeration, so I
+have some concerns about how well Enermax has ensured uniqueness of
+enumerated IDs. There's also an open question as to whether Enermax has
+incorporated similar technology in any of their other power supplies, how
+those other products enumerate via HID, and how the driver will respond
+upon seeing one of these other devices.
+
+Also, since pretty much all my knowledge of this hardware is based on
+dissecting USB traffic generated by the Enermax OEM application, I'm not
+entirely certain of some aspects, such as the sensor-reading format.  For
+example, I've never seen either of the two high bits of the exponent unset,
+or the high bit of the mantissa set--so for all I know, these bits may not
+mean what I think they mean.
+
+Furthermore, although the OEM application is able to determine the apparent
+power usage (volt-amperes), the actual power usage (watts), and the power
+factor for the AC inputs, I haven't learned how it determines any of those
+values.
+
+Finally, there is a possibility that upon non-fatal "alarm" conditions,
+the controller may notify the host via an unexpected HID event.  I have no
+idea what this will look like, and if there's a host-initiated query or
+command in flight, any such unexpected event may interfere with the expected
+response.  To figure out how to deal with this (or even see what it looks
+like without vendor documentation), it may be necessary to construct a
+benchtop load setup specifically to trigger such alarm conditions.  This is
+difficult and somewhat dangerous, for obvious reasons.
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index cc4c664..de01050 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -849,6 +849,22 @@ config HID_XINMO
 	standard. Currently only supports the Xin-Mo Dual Arcade. Say Y here
 	if you have a Xin-Mo Dual Arcade controller.
 
+config HID_ZDPMS
+	tristate "Enermax ZDPMS support (EXPERIMENTAL)"
+	depends on HID && HWMON
+	default n
+	---help---
+	Support for monitoring sensors and software-configurable settings
+	embedded in the Enermax DigiFanless 550W power supply.  This driver
+	registers as a hwmon driver to expose these sensors for use by
+	libsensors-based applications.
+
+	This driver is largely based on dissecting captures of USB traffic
+	generated by the Enermax ZDPMS OEM Windows application.  At least
+	two sensors are not supported (yet), and it's uncertain how this
+	driver will behave in the presence of other Enermax products with
+	similar (but not quite identical) functionality.
+
 config HID_ZEROPLUS
 	tristate "Zeroplus based game controller support"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 2f8a41d..dd538dd 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
 obj-$(CONFIG_HID_TWINHAN)	+= hid-twinhan.o
 obj-$(CONFIG_HID_UCLOGIC)	+= hid-uclogic.o
 obj-$(CONFIG_HID_XINMO)		+= hid-xinmo.o
+obj-$(CONFIG_HID_ZDPMS)		+= hid-zdpms.o
 obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
 obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e6fce23..5d4062b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1895,6 +1895,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD_BOOTLOADER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_ZDPMS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b3b225b..a9eedea 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -650,6 +650,7 @@
 #define USB_DEVICE_ID_PICOLCD		0xc002
 #define USB_DEVICE_ID_PICOLCD_BOOTLOADER	0xf002
 #define USB_DEVICE_ID_PICK16F1454	0x0042
+#define USB_DEVICE_ID_ZDPMS		0xf590
 
 #define USB_VENDOR_ID_MICROSOFT		0x045e
 #define USB_DEVICE_ID_SIDEWINDER_GV	0x003b
diff --git a/drivers/hid/hid-zdpms.c b/drivers/hid/hid-zdpms.c
new file mode 100644
index 0000000..905ef6a
--- /dev/null
+++ b/drivers/hid/hid-zdpms.c
@@ -0,0 +1,828 @@
+/*
+ *  Linux HID/hwmon driver for Enermax ZDPMS controller
+ *
+ *  Copyright (c) 2015 Frank Schaefer <kelledin@gmail.com>
+ *
+ *  The name "Enermax" (and possibly "DigiFanless" and "ZDPMS") are trademark
+ *  Enermax Inc (http://www.enermax.com/).
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/hid.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/mutex.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/atomic.h>
+#include "hid-ids.h"
+
+#define ZDPMS_VERSION  "0.1.1"
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Enermax ZDPMS controller");
+MODULE_AUTHOR("Frank Schaefer <kelledin@gmail.com>");
+MODULE_VERSION(ZDPMS_VERSION);
+
+static const struct hid_device_id zdpms_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_ZDPMS) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, zdpms_devices);
+
+static int zdpms_timeout = 100;
+module_param(zdpms_timeout, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(zdpms_timeout,
+		 "Transaction timeout in milliseconds (minimum 20)");
+
+static int zdpms_12v_config;
+module_param(zdpms_12v_config, int, S_IRUGO);
+MODULE_PARM_DESC(zdpms_12v_config,
+		 "Set 12V rail configuration (1: single rail, 2: dual rail)");
+
+enum {
+	/* Raw size for HID messages, excluding the URB header */
+	ZDPMS_MSG_SIZE = 64,
+
+	/*
+	 * No idea what these mean, but they are part of the initialization
+	 * sequence used by the Enermax ZDPMS OEM application, with the
+	 * single byte value 0x5 passed to each one.  I suspect they set
+	 * something, I just don't know what.
+	 */
+	ZDPMS_INIT1 = 0x25,
+	ZDPMS_INIT2 = 0x24,
+	ZDPMS_INIT3 = 0x23,
+
+	/*
+	 * 12V rail configuration setting.  Passing byte value 0x1 sets
+	 * single-rail mode, while passing byte value 0x2 sets dual-rail
+	 * mode.  Some PSU models may support more values for more rail
+	 * configurations, but this is what we get on our one sample.
+	 */
+	ZDPMS_12V_CONFIG = 0x26,
+
+	/* Sensor values, as near as we can tell. */
+	ZDPMS_SENSOR_MIN = 0x27,      /* Minimum sensor value */
+	ZDPMS_AC_V = 0x27,            /* AC input voltage level */
+	ZDPMS_DC_12V1 = 0x28,         /*
+				       * One of the 12V rail voltage levels
+				       * (probably 12V1)
+				       */
+	ZDPMS_DC_5V = 0x29,           /* DC 5V rail voltage level */
+	ZDPMS_DC_3V = 0x2a,           /* DC 3.3V rail voltage level */
+	ZDPMS_DC_12V2 = 0x2b,         /*
+				       * One of the 21V rail voltage levels.
+				       * (probably 12V1)
+				       */
+	ZDPMS_DC_12V1_CURRENT = 0x2c, /* 12V1 current level in amperes */
+	ZDPMS_DC_5V_CURRENT = 0x2d,   /* 5V current level in amperes */
+	ZDPMS_DC_3V_CURRENT = 0x2e,   /* 3.3V current level in amperes */
+	ZDPMS_DC_12V2_CURRENT = 0x2f, /* 12V2 current level in amperes */
+	ZDPMS_TEMP = 0x30,            /* PSU temperature in degrees Celcius */
+	ZDPMS_SENSOR_MAX = 0x30,      /* Maximum sensor value */
+
+	ZDPMS_MODEL_NUMBER = 0x32,    /*
+				       * PSU model number string length
+				       * (variable length)
+				       */
+
+	/* Message types (a.k.a. HID report IDs) that we've seen. */
+	ZDPMS_SET_CONFIG = 0x82,      /* Used for setting configuration. */
+	ZDPMS_READ_SENSOR = 0x83,     /* Used for reading values. */
+	ZDPMS_WTF_1 = 0x90,           /* No idea at all.  Doesn't get a valid
+				       * response.
+				      */
+	ZDPMS_WTF_2 = 0x91,           /* As above, no idea at all. */
+};
+
+static const char * const zdpms_labels[] = {
+	"AC input voltage",
+	"DC 12V1",
+	"DC 5V",
+	"DC 3.3V",
+	"DC 12V2",
+	"DC 12V1 current",
+	"DC 5V current",
+	"DC 3.3V current",
+	"DC 12V2 current",
+	"PSU temp",
+};
+
+struct zdpms_device {
+	/* The hid_device we belong to. */
+	struct hid_device *hdev;
+
+	/* The hwmon device pointer. */
+	struct device *hwmon_dev;
+
+	/* The wait queue used to track transaction replies. */
+	wait_queue_head_t io_wait;
+
+	/*
+	 * The atomic condition variable to indicate that a message is
+	 * received.
+	 */
+	atomic_t msg_received;
+
+	/*
+	 * The last data read by the raw event handler.  This is expected to be
+	 * a command or query response (up to ZDPMS_MSG_SIZE bytes), and to the
+	 * best of my knowledge, only one pending command or query is supported
+	 * at any time.
+	 */
+	uint8_t data[ZDPMS_MSG_SIZE];
+	unsigned int sz;
+
+	/*
+	 * The ZDPMS model number (i.e. "EDF550AWN" for the Enermax DigiFanless
+	 * 550W).  We don't expect this to be more than 32 bytes.
+	 */
+	char model[32];
+
+	/*
+	 * Transaction lock mutex.  This keeps us from launching a second
+	 * command/query while one is still pending.
+	 */
+	struct mutex io_lock;
+
+};
+
+/**
+ * Perform a command/response or query/response exchange with an Enermax
+ * ZDPMS controller.  The command is launched immediately through the
+ * controller's interrupt endpoint; the response is copied back for the
+ * caller to perform further analysis.  A minimum response timeout
+ * (maintained in the zdpms_timeout variable) is implicit to avoid
+ * potential deadlocks.  No validation is performed on the response
+ * content.
+ *
+ * Note that commands, queries, and responses are generally zero padded to
+ * ZDPMS_MSG_SIZE bytes.  The first byte of any message must be the report
+ * ID (typically either ZDPMS_SET_CONFIG or ZDPMS_READ_SENSOR); the second
+ * byte is supposed to be the length of the message payload, minus the first
+ * two bytes and any zero padding.  For successful commands, the ZDPMS
+ * controller appears to copy the report ID to the end of the message; for
+ * unsupported commands, the controller appears to set the length byte to
+ * 0xFF in the response.
+ *
+ * @param hdev
+ *     The hid_device to which we're sending the command/query
+ *
+ * @param msg
+ *     The command/query to send to the ZDPMS controller, starting with the
+ *     report ID and message-length byte
+ *
+ * @param sz
+ *     The size of the command/query in bytes, including the report ID and
+ *     message-length byte
+ *
+ * @param resp
+ *     A user-supplied buffer to store the response.  This MUST be at least
+ *     ZDPMS_MSG_SIZE bytes in order to avoid potential buffer overflows.
+ *
+ * @return
+ *     Returns the number of bytes read on success (usually ZDPMS_MSG_SIZE),
+ *     or a negative errno value on failure.
+ */
+static int zdpms_xchg(struct hid_device *hdev,
+			  const uint8_t *data,
+			   unsigned int  sz,
+				uint8_t *resp)
+{
+	uint8_t msg[ZDPMS_MSG_SIZE];
+	struct zdpms_device *dev;
+	unsigned long last_jiffy;
+	int ret;
+
+	dev = hid_get_drvdata(hdev);
+
+	/* Copy the message and clear any padding. */
+	memcpy(msg, data, sz);
+
+	if (sz < sizeof(msg))
+		memset(msg + sz, 0, sizeof(msg) - sz);
+
+	mutex_lock(&(dev->io_lock));
+
+	/*
+	 * Send the command/query.  We use hid_hw_output_report() specifically
+	 * because it will send the raw message to an interrupt endpoint.
+	 * NOTE: No return type (WTF really?).  If it fails, we'll supposedly
+	 * find out when we time out waiting for the response...
+	 */
+	hid_hw_output_report(hdev, msg, sizeof(msg));
+
+	/*
+	 * Clamp the timeout to 20ms.  Any smaller and it's dicey to represent
+	 * it in jiffies...
+	 */
+	if (zdpms_timeout < 20)
+		zdpms_timeout = 20;
+
+	/*
+	 * We track the last allowable jiffy, in order to avoid our timeout
+	 * getting mistakenly prolonged by a signal storm or similar event.
+	 */
+	last_jiffy = jiffies + msecs_to_jiffies(zdpms_timeout);
+
+	do {
+		ret = wait_event_interruptible_timeout(
+				dev->io_wait,
+				atomic_read(&(dev->msg_received)),
+				last_jiffy - jiffies);
+
+		if (ret = -ERESTARTSYS)
+			/* Interrupted by a signal.  Keep trying... */
+			continue;
+
+		if (ret < 0)
+			/* Unspecified error.  Punt! */
+			goto fail_mutex_locked;
+
+		if (ret = 0) {
+			/* Timed out! */
+			ret = -ETIMEDOUT;
+			goto fail_mutex_locked;
+		}
+
+		if (ret > 0)
+			/* Message is received. */
+			break;
+	} while (time_before(jiffies, last_jiffy));
+
+	/*
+	 * Now see about copying the received data to the user-supplied buffer.
+	 */
+	memcpy(resp, dev->data, dev->sz);
+	ret = dev->sz;
+	atomic_set(&(dev->msg_received), 0);
+
+fail_mutex_locked:
+	mutex_unlock(&(dev->io_lock));
+	return ret;
+}
+
+/**
+ * Sets a specific ZDPMS configuration item.  Currently-known configuration
+ * commands only take a one-byte configuration value.  Response validation
+ * is performed.
+ *
+ * @param hdev
+ *     Pointer to the hid_device structure to configure
+ *
+ * @param cmd
+ *     Device setting to configure
+ *
+ * @param val
+ *     Configuration setting to apply
+ *
+ * @return
+ *     Returns the size of the return message on success, or a negative
+ *     errno value on failure
+ */
+static int zdpms_set(struct hid_device *hdev, uint8_t cmd, uint8_t val)
+{
+	uint8_t msg[8], resp[ZDPMS_MSG_SIZE];
+	int result;
+
+	msg[0] = ZDPMS_SET_CONFIG;
+	msg[1] = 0x03; /* 3-byte message */
+	msg[2] = 0x40; /* no idea what this is supposed to mean */
+	msg[3] = cmd;  /* Command value */
+	msg[4] = val;
+
+	result = zdpms_xchg(hdev, msg, 5, resp);
+
+	if (result < 0)
+		return result;
+
+	if (result < 6)
+		return -EMSGSIZE;
+
+	if (resp[1] = 0xff)
+		/* Unsupported command? */
+		return -EINVAL;
+
+	if (resp[0] != msg[0] || resp[1] != 4 || resp[2] != msg[2] ||
+	    resp[3] != msg[3] || resp[4] != msg[4] || resp[5] != resp[0])
+		return -EPROTO;
+
+	return result;
+}
+
+/**
+ * Reads the ASCII model number string from the ZDPMS controller and stores it
+ * in the caller-supplied buffer and appends a NULL terminator if possible.  If
+ * the buffer is not large enough to hold the entire string, it will be
+ * truncated to fit (but no NULL terminator will be added).
+ *
+ * @param hdev
+ *     The hid_device we're attempting to query
+ *
+ * @param buf
+ *     The caller-supplied buffer to store the model number string
+ *
+ * @param sz
+ *     The maximum buffer size (in bytes)
+ *
+ * @return
+ *     Returns the length of the model-number string in bytes (not counting
+ *     the NULL terminator), or a negative errno value on failure.  The
+ *     returned string length may be larger than the supplied buffer size.
+ *
+ */
+static int zdpms_read_model(struct hid_device *hdev, char *buf, size_t sz)
+{
+	uint8_t msg[8], resp[ZDPMS_MSG_SIZE];
+	int result;
+
+	msg[0] = ZDPMS_READ_SENSOR;
+	msg[1] = 0x2; /* 2-byte message */
+	msg[2] = 0x40; /* nope, still no idea what this is for. */
+	msg[3] = ZDPMS_MODEL_NUMBER;
+	result = zdpms_xchg(hdev, msg, 4, resp);
+
+	if (result < 0)
+		return result;
+
+	if (result < 6)
+		return -EMSGSIZE;
+
+	if (resp[1] = 0xff)
+		return -EINVAL;
+
+	if (resp[1] + 2 > ZDPMS_MSG_SIZE || resp[0] != msg[0] ||
+	    resp[2] != msg[2] || resp[3] != msg[3] ||
+	    resp[resp[1]+1] != resp[0])
+		return -EPROTO;
+
+	result = resp[1] - 3;
+
+	if (result < sz) {
+		/*
+		 * Good news, we can fit the entire model name in the supplied
+		 * buffer, complete with a NULL terminator.
+		 */
+		memcpy(buf, resp + 4, result);
+		buf[result] = '\0';
+	} else
+		/* Whoops, we can only fit in part of it. */
+		memcpy(buf, resp + 4, sz);
+
+	return result;
+}
+
+/**
+ * Query a sensor reading from a ZDPMS controller.  This reading is reported
+ * in millivolts, milliamperes, or millidegrees Celcius, in order to conform
+ * with the Linux hwmon subsystem expectations.
+ *
+ * @param hdev
+ *     The hid_device we're attempting to query
+ *
+ * @param sensor
+ *     The sensor index we're attempting to query
+ *
+ * @return
+ *     Returns the sensor value (currently always >=0) on success, or a
+ *     negative errno value on failure.
+ *
+ */
+static int zdpms_read_sensor(struct hid_device *hdev, uint8_t sensor)
+{
+	uint8_t msg[8], resp[ZDPMS_MSG_SIZE];
+	int result;
+	uint32_t val;
+	unsigned int exponent;
+
+	msg[0] = ZDPMS_READ_SENSOR;
+	msg[1] = 0x2; /* 2-byte message */
+	msg[2] = 0x40; /* no idea what this is supposed to mean */
+	msg[3] = sensor; /* Sensor value */
+	result = zdpms_xchg(hdev, msg, 4, resp);
+
+	if (result < 4)
+		return result;
+
+	if (result < 7)
+		return -EMSGSIZE;
+
+	if (resp[1] = 0xff)
+		/* Nonexistent sensor? */
+		return -ENODEV;
+
+	if (resp[0] != msg[0] || resp[1] != 5 || resp[2] != msg[2] ||
+	    resp[3] != msg[3] || resp[6] != resp[0])
+		return -EPROTO;
+
+	/*
+	 * The sensor value is encoded as little-endian quasi-IEEE 754, in
+	 * bytes 4 and 5.
+	 */
+	val = ((resp[5] & 7) << 8) | resp[4];
+	exponent = resp[5] >> 3;
+
+	/*
+	 * All hwmon sensors we support are supposed to be reported in
+	 * milliunits (millivolts, millidegrees Celcius, or milliamperes).
+	 * Given that the maximum possible value for the mantissa is 2^11
+	 * (2048), we'll remain well within 32-bit integer range even after
+	 * applying this multiplier.
+	 */
+	val *= 1000;
+
+	/*
+	 * Apply the exponent shift *after* applying the units multiplier, so we
+	 * preserve as much accuracy as possible.
+	 */
+	val >>= (32 - exponent);
+	return val;
+}
+
+/**
+ * Callback for reporting ZDPMS sensor labels via sysfs, in accordance with
+ * standard hwmon conventions.
+ *
+ * @param dev
+ *     hwmon device pointer.  The corresponding zdpms_device structure is
+ *     referenced by the dev_get_drvdata() result and contains a pointer to
+ *     the associated hid_device structure of the ZDPMS controller.
+ *
+ * @param attr
+ *     sysfs device attribute pointer.  The corresponding sensor device
+ *     attribute can be deduced from this and supplies the desired ZDPMS
+ *     sensor ID.
+ *
+ * @param buf
+ *     buffer for storing a string representation of the sensor reading.
+ *
+ * @return
+ *     Returns the size of the string representation stored in the buffer,
+ *     not including the NULL terminator, or a negative errno value on
+ *     failure.
+ *
+ */
+static ssize_t zdpms_show_label(struct device *dev,
+		      struct device_attribute *attr,
+					 char *buf)
+{
+	struct sensor_device_attribute *sens_attr;
+	struct zdpms_device            *zdev;
+	struct hid_device              *hdev;
+	unsigned int                    idx;
+
+	sens_attr = to_sensor_dev_attr(attr);
+	zdev = dev_get_drvdata(dev);
+	hdev = zdev->hdev;
+	idx = sens_attr->index;
+
+	/* We use a straight sequential array as a lookup table. */
+	idx -= ZDPMS_SENSOR_MIN;
+
+	return sprintf(buf, "%s\n", zdpms_labels[idx]);
+}
+
+/**
+ * Callback for reporting ZDPMS sensor values via sysfs, in accordance with
+ * standard hwmon conventions.
+ *
+ * @param dev
+ *     hwmon device pointer.  The corresponding zdpms_device structure is
+ *     referenced by the dev_get_drvdata() result and contains a pointer to
+ *     the associated hid_device structure of the ZDPMS controller.
+ *
+ * @param attr
+ *     sysfs device attribute pointer.  The corresponding sensor device
+ *     attribute can be deduced from this and supplies the desired ZDPMS
+ *     sensor ID.
+ *
+ * @param buf
+ *     buffer for storing a string representation of the sensor reading.
+ *
+ * @return
+ *     Returns the size of the string representation stored in the buffer,
+ *     not including the NULL terminator, or a negative errno value on
+ *     failure.
+ *
+ */
+static ssize_t zdpms_show_sensor(struct device *dev,
+		       struct device_attribute *attr,
+					  char *buf)
+{
+	struct sensor_device_attribute *sens_attr;
+	struct zdpms_device            *zdev;
+	struct hid_device              *hdev;
+	unsigned int                    idx;
+	int                             val;
+
+	sens_attr = to_sensor_dev_attr(attr);
+	zdev = dev_get_drvdata(dev);
+	hdev = zdev->hdev;
+	idx = sens_attr->index;
+	val = zdpms_read_sensor(hdev, idx);
+
+	if (val < 0)
+		return val;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+/**
+ * Callback for reporting raw HID events from a ZDPMS controller.  ZDPMS
+ * controllers generally only send HID events in response to commands or
+ * queries sent to their interrupt endpoints; generally only one such
+ * command or query is expected to be pending at any time.
+ *
+ * @param hdev
+ *     Pointer to the HID device (ZDPMS controller) responsible for this
+ *     HID event
+ *
+ * @param report
+ *     Pointer to the HID report structure for this event.  This is
+ *     generally ignored, since we prefer to parse raw messages.
+ *
+ * @param data
+ *     Pointer to the HID data payload from this event (not including any
+ *     headers such as the USB Request Block (URB)
+ *
+ * @param sz
+ *     Size of the HID data payload from this event (usually ZDPMS_MSG_SIZE
+ *     bytes).
+ *
+ * @return
+ *     In accordance with the kernel HID API, returns 0 when the event has
+ *     been successfully parsed, or -1 if a parse error occurs.
+ *
+ */
+static int zdpms_raw_event(struct hid_device *hdev,
+			   struct hid_report *report,
+					  u8 *data,
+					 int  sz)
+{
+	struct zdpms_device *dev;
+
+	dev = hid_get_drvdata(hdev);
+
+	/*
+	 * We shouldn't receive any messages larger than ZDPMS_MSG_SIZE bytes.
+	 * If we do, we need to clip it so it fits in our buffer.
+	 */
+	if (sz > ZDPMS_MSG_SIZE) {
+		hid_warn(hdev,
+			 "truncated oversize %d-byte event message!\n",
+			 sz);
+
+		sz = ZDPMS_MSG_SIZE;
+	}
+
+	memcpy(dev->data, data, sz);
+	dev->sz = sz;
+
+	if (atomic_inc_return(&(dev->msg_received)) > 1)
+		/*
+		 * This implies we already had a message pending, and we just
+		 * overwrote it.  D'oh!
+		 */
+		hid_warn(hdev, "overwriting unacknowledged message\n");
+
+	/* Now wake up anyone waiting on a transaction to complete. */
+	wake_up_interruptible(&(dev->io_wait));
+	return 0;
+}
+
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, zdpms_show_sensor, NULL,
+			  ZDPMS_DC_12V1);
+static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, zdpms_show_label, NULL,
+			  ZDPMS_DC_12V1);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, zdpms_show_sensor, NULL,
+			  ZDPMS_DC_5V);
+static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, zdpms_show_label, NULL,
+			  ZDPMS_DC_5V);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, zdpms_show_sensor, NULL,
+			  ZDPMS_DC_3V);
+static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, zdpms_show_label, NULL,
+			  ZDPMS_DC_3V);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, zdpms_show_sensor, NULL,
+			  ZDPMS_DC_12V2);
+static SENSOR_DEVICE_ATTR(in4_label, S_IRUGO, zdpms_show_label, NULL,
+			  ZDPMS_DC_12V2);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, zdpms_show_sensor, NULL,
+			  ZDPMS_AC_V);
+static SENSOR_DEVICE_ATTR(in5_label, S_IRUGO, zdpms_show_label, NULL,
+			  ZDPMS_AC_V);
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, zdpms_show_sensor, NULL,
+			  ZDPMS_DC_12V1_CURRENT);
+static SENSOR_DEVICE_ATTR(curr1_label, S_IRUGO, zdpms_show_label, NULL,
+			  ZDPMS_DC_12V1_CURRENT);
+static SENSOR_DEVICE_ATTR(curr2_input, S_IRUGO, zdpms_show_sensor, NULL,
+			  ZDPMS_DC_5V_CURRENT);
+static SENSOR_DEVICE_ATTR(curr2_label, S_IRUGO, zdpms_show_label, NULL,
+			  ZDPMS_DC_5V_CURRENT);
+static SENSOR_DEVICE_ATTR(curr3_input, S_IRUGO, zdpms_show_sensor, NULL,
+			  ZDPMS_DC_3V_CURRENT);
+static SENSOR_DEVICE_ATTR(curr3_label, S_IRUGO, zdpms_show_label, NULL,
+			  ZDPMS_DC_3V_CURRENT);
+static SENSOR_DEVICE_ATTR(curr4_input, S_IRUGO, zdpms_show_sensor, NULL,
+			  ZDPMS_DC_12V2_CURRENT);
+static SENSOR_DEVICE_ATTR(curr4_label, S_IRUGO, zdpms_show_label, NULL,
+			  ZDPMS_DC_12V2_CURRENT);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, zdpms_show_sensor, NULL,
+			  ZDPMS_TEMP);
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, zdpms_show_label, NULL,
+			  ZDPMS_TEMP);
+
+static struct attribute *zdpms_attrs[] = {
+	&sensor_dev_attr_in1_label.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_label.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_label.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_label.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in5_label.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_label.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr2_label.dev_attr.attr,
+	&sensor_dev_attr_curr2_input.dev_attr.attr,
+	&sensor_dev_attr_curr3_label.dev_attr.attr,
+	&sensor_dev_attr_curr3_input.dev_attr.attr,
+	&sensor_dev_attr_curr4_label.dev_attr.attr,
+	&sensor_dev_attr_curr4_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(zdpms);
+
+static int zdpms_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct zdpms_device *dev;
+	int ret;
+
+	ret = hid_parse(hdev);
+
+	if (ret < 0) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+
+	if (ret < 0) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_open(hdev);
+
+	if (ret < 0) {
+		hid_err(hdev, "hw open failed\n");
+		goto fail_hid_started;
+	}
+
+	ret = hid_hw_power(hdev, PM_HINT_FULLON);
+
+	if (ret < 0) {
+		hid_err(hdev, "power management error: %d\n", ret);
+		goto fail_hid_open;
+	}
+
+	dev = devm_kzalloc(&(hdev->dev),
+			   sizeof(struct zdpms_device),
+			   GFP_KERNEL);
+
+	if (dev = NULL) {
+		ret = -ENOMEM;
+		goto fail_hid_power_on;
+	}
+
+	/* Initialize the private device data structure. */
+	dev->hdev = hdev;
+	init_waitqueue_head(&(dev->io_wait));
+	atomic_set(&(dev->msg_received), 0);
+	mutex_init(&(dev->io_lock));
+	hid_set_drvdata(hdev, dev);
+
+	/* Allow event processing during probe. */
+	hid_device_io_start(hdev);
+
+	/* Perform the initialization sequence */
+	ret = zdpms_set(hdev, ZDPMS_INIT1, 0x5);
+
+	if (ret >= 0) {
+		ret = zdpms_set(hdev, ZDPMS_INIT2, 0x5);
+
+		if (ret >= 0)
+			ret = zdpms_set(hdev, ZDPMS_INIT3, 0x5);
+	}
+
+	if (ret < 0) {
+		hid_err(hdev,
+			"Primary initialization sequence FAILED (error %d)\n",
+			ret);
+
+		goto fail_io_started;
+	}
+
+	if (zdpms_12v_config > 0 && zdpms_12v_config < 3) {
+		hid_info(hdev, "Setting 12V %s-rail configuration...",
+			 zdpms_12v_config = 1 ? "single" : "dual");
+
+		ret = zdpms_set(hdev, ZDPMS_12V_CONFIG, zdpms_12v_config);
+
+		if (ret < 0) {
+			hid_err(hdev,
+				"12V rail configuration FAILED (error %d)\n",
+				ret);
+
+			goto fail_io_started;
+		}
+	}
+
+	ret = zdpms_read_model(hdev, dev->model, sizeof(dev->model));
+
+	if (ret < 0) {
+		hid_err(hdev, "Model number query FAILED (error %d)\n", ret);
+		goto fail_io_started;
+	}
+
+	if (ret >= sizeof(dev->model)) {
+		hid_warn(hdev,
+			 "model number truncated to %ld bytes (full size %d bytes)\n",
+			 sizeof(dev->model) - 1, ret);
+
+		dev->model[sizeof(dev->model) - 1] = '\0';
+	} else
+		dev->model[ret] = '\0';
+
+	hid_info(hdev, "Detected model number: %s\n", dev->model);
+
+	/* Undo hid_device_io_start(). */
+	hid_device_io_stop(hdev);
+
+	/* Now register this as an hwmon device. */
+	dev->hwmon_dev = devm_hwmon_device_register_with_groups(&(hdev->dev),
+								"zdpms",
+								dev,
+								zdpms_groups);
+
+	ret = PTR_ERR_OR_ZERO(dev->hwmon_dev);
+
+	if (ret < 0) {
+		hid_err(hdev, "hwmon device registration FAILED (error %d)\n",
+			ret);
+
+		goto fail_data_alloced;
+	}
+
+	return 0;
+
+fail_io_started:
+	hid_device_io_stop(hdev);
+fail_data_alloced:
+	hid_set_drvdata(hdev, NULL);
+	devm_kfree(&(hdev->dev), dev);
+fail_hid_power_on:
+	hid_hw_power(hdev, PM_HINT_NORMAL);
+fail_hid_open:
+	hid_hw_close(hdev);
+fail_hid_started:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void zdpms_remove(struct hid_device *hdev)
+{
+	struct zdpms_device *dev;
+
+	dev = hid_get_drvdata(hdev);
+	mutex_destroy(&(dev->io_lock));
+	hid_hw_power(hdev, PM_HINT_NORMAL);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static struct hid_driver zdpms_driver = {
+	.name       = "zdpms",
+	.id_table   = zdpms_devices,
+	.probe      = zdpms_probe,
+	.remove     = zdpms_remove,
+	.raw_event  = zdpms_raw_event,
+};
+
+module_hid_driver(zdpms_driver);
+
-- 
2.1.4

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

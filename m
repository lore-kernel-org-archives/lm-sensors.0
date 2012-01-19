From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:52 +0000
Subject: [lm-sensors] [PATCH 58/82] hwmon: (sht15) Fix multi-line comments
Message-Id: <1327017376-20466-59-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/sht15.c |   50 ++++++++++++++++++++++++------------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 46af605..54f762b 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -60,7 +60,7 @@ enum sht15_state {
 	SHT15_READING_HUMID
 };
 
-/**
+/*
  * struct sht15_temppair - elements of voltage dependent temp calc
  * @vdd:	supply voltage in microvolts
  * @d1:		see data sheet
@@ -115,7 +115,7 @@ static const u8 sht15_crc8_table[] = {
 	59,	10,	89,	104,	255,	206,	157,	172
 };
 
-/**
+/*
  * struct sht15_data - device instance specific data
  * @pdata:		platform data (gpio's etc).
  * @read_work:		bh of interrupt handler.
@@ -169,7 +169,7 @@ struct sht15_data {
 	atomic_t			interrupt_handled;
 };
 
-/**
+/*
  * sht15_reverse() - reverse a byte
  * @byte:    byte to reverse.
  */
@@ -182,7 +182,7 @@ static u8 sht15_reverse(u8 byte)
 	return c;
 }
 
-/**
+/*
  * sht15_crc8() - compute crc8
  * @data:	sht15 specific data.
  * @value:	sht15 retrieved data.
@@ -203,7 +203,7 @@ static u8 sht15_crc8(struct sht15_data *data,
 	return crc;
 }
 
-/**
+/*
  * sht15_connection_reset() - reset the comms interface
  * @data:	sht15 specific data
  *
@@ -225,7 +225,7 @@ static void sht15_connection_reset(struct sht15_data *data)
 	}
 }
 
-/**
+/*
  * sht15_send_bit() - send an individual bit to the device
  * @data:	device state data
  * @val:	value of bit to be sent
@@ -240,7 +240,7 @@ static inline void sht15_send_bit(struct sht15_data *data, int val)
 	ndelay(SHT15_TSCKL); /* clock low time */
 }
 
-/**
+/*
  * sht15_transmission_start() - specific sequence for new transmission
  * @data:	device state data
  *
@@ -269,7 +269,7 @@ static void sht15_transmission_start(struct sht15_data *data)
 	ndelay(SHT15_TSCKL);
 }
 
-/**
+/*
  * sht15_send_byte() - send a single byte to the device
  * @data:	device state
  * @byte:	value to be sent
@@ -284,7 +284,7 @@ static void sht15_send_byte(struct sht15_data *data, u8 byte)
 	}
 }
 
-/**
+/*
  * sht15_wait_for_response() - checks for ack from device
  * @data:	device state
  */
@@ -304,7 +304,7 @@ static int sht15_wait_for_response(struct sht15_data *data)
 	return 0;
 }
 
-/**
+/*
  * sht15_send_cmd() - Sends a command to the device.
  * @data:	device state
  * @cmd:	command byte to be sent
@@ -322,7 +322,7 @@ static int sht15_send_cmd(struct sht15_data *data, u8 cmd)
 	return ret;
 }
 
-/**
+/*
  * sht15_soft_reset() - send a soft reset command
  * @data:	sht15 specific data.
  *
@@ -342,7 +342,7 @@ static int sht15_soft_reset(struct sht15_data *data)
 	return ret;
 }
 
-/**
+/*
  * sht15_ack() - send a ack
  * @data:	sht15 specific data.
  *
@@ -362,7 +362,7 @@ static void sht15_ack(struct sht15_data *data)
 	gpio_direction_input(data->pdata->gpio_data);
 }
 
-/**
+/*
  * sht15_end_transmission() - notify device of end of transmission
  * @data:	device state.
  *
@@ -378,7 +378,7 @@ static void sht15_end_transmission(struct sht15_data *data)
 	ndelay(SHT15_TSCKL);
 }
 
-/**
+/*
  * sht15_read_byte() - Read a byte back from the device
  * @data:	device state.
  */
@@ -398,7 +398,7 @@ static u8 sht15_read_byte(struct sht15_data *data)
 	return byte;
 }
 
-/**
+/*
  * sht15_send_status() - write the status register byte
  * @data:	sht15 specific data.
  * @status:	the byte to set the status register with.
@@ -423,7 +423,7 @@ static int sht15_send_status(struct sht15_data *data, u8 status)
 	return 0;
 }
 
-/**
+/*
  * sht15_update_status() - get updated status register from device if too old
  * @data:	device instance specific data.
  *
@@ -490,7 +490,7 @@ error_ret:
 	return ret;
 }
 
-/**
+/*
  * sht15_measurement() - get a new value from device
  * @data:		device instance specific data
  * @command:		command sent to request value
@@ -552,7 +552,7 @@ static int sht15_measurement(struct sht15_data *data,
 	return 0;
 }
 
-/**
+/*
  * sht15_update_measurements() - get updated measures from device if too old
  * @data:	device state
  */
@@ -581,7 +581,7 @@ error_ret:
 	return ret;
 }
 
-/**
+/*
  * sht15_calc_temp() - convert the raw reading to a temperature
  * @data:	device state
  *
@@ -606,7 +606,7 @@ static inline int sht15_calc_temp(struct sht15_data *data)
 	return data->val_temp * d2 + d1;
 }
 
-/**
+/*
  * sht15_calc_humid() - using last temperature convert raw to humid
  * @data:	device state
  *
@@ -641,7 +641,7 @@ static inline int sht15_calc_humid(struct sht15_data *data)
 		/ 1000000 + rh_linear;
 }
 
-/**
+/*
  * sht15_show_status() - show status information in sysfs
  * @dev:	device.
  * @attr:	device attribute.
@@ -664,7 +664,7 @@ static ssize_t sht15_show_status(struct device *dev,
 	return ret ? ret : sprintf(buf, "%d\n", !!(data->val_status & bit));
 }
 
-/**
+/*
  * sht15_store_heater() - change heater state via sysfs
  * @dev:	device.
  * @attr:	device attribute.
@@ -699,7 +699,7 @@ static ssize_t sht15_store_heater(struct device *dev,
 	return ret ? ret : count;
 }
 
-/**
+/*
  * sht15_show_temp() - show temperature measurement value in sysfs
  * @dev:	device.
  * @attr:	device attribute.
@@ -722,7 +722,7 @@ static ssize_t sht15_show_temp(struct device *dev,
 				   sht15_calc_temp(data));
 }
 
-/**
+/*
  * sht15_show_humidity() - show humidity measurement value in sysfs
  * @dev:	device.
  * @attr:	device attribute.
@@ -859,7 +859,7 @@ static void sht15_update_voltage(struct work_struct *work_s)
 	data->supply_uV = regulator_get_voltage(data->reg);
 }
 
-/**
+/*
  * sht15_invalidate_voltage() - mark supply voltage invalid when notified by reg
  * @nb:		associated notification structure
  * @event:	voltage regulator state change event code
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>
Date: Tue, 26 Aug 2014 15:02:48 +0000
Subject: [lm-sensors] hwmon_device_register compatibility with lm-sensors
Message-Id: <BF3270C86E8B1349A26C34E4EC1C44CB2C9388EE@CMEXMB1.ad.emulex.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I'm using "hwmon_device_register_with_groups" to register with hwmon to show be2net's on-die temperature. I'm successful in doing it and the node is also visible at "/sys/class/hwmon/hwmon1/temp1_input" and lm-sensors  (sensors command) also shows the temperature.

However I'm not sure if a kernel doesn't support "_groups" version of the api, how do I register with hwmon so that it is compatible with lm-sensors.

For example, in kernels where "_groups" is not supported. I'm doing the following to register with hwmon

1.       sysfs_create_group

2.       hwmon_device_register
The above calls are creating "temp1_input" node at "/sys/class/hwmon/hwmon1/device/temp1_input" and sensors command is not showing the temperature.

Please let me know if I'm missing anything.

Thanks,
Venkat.
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

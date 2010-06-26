From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 26 Jun 2010 02:40:08 +0000
Subject: [lm-sensors] [PATCH/RFC 0/3] hwmon: Driver for LTC4261 I2C Negative
Message-Id: <1277520011-29782-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patchset adds support for Linear Technology's LTC4261 I2C Negative Voltage
Hot Swap Controller.

The patchset also updates the hwmon sysfs API to document additional current
alarm attributes.

The driver has only been tested with simulated hardware and is thus submitted
for feedback/review only at this time.

I am especially interested to get feedback on the following issues/questions. 

- Are the hwmon sysfs API extensions ok as documented ?
  In this context, there will be more attributes to add for the PMBus driver
  (currX_fault and possibly a number of power related attributes).
  Is it better to add API changes incrementally with the respective drivers,
  or would it be better to write a separate patch which addresses all
  API changes in a single commit ?
- Current sensor readings. The driver reports currents on a somewhat
  arbitrary current sense resistor and expects board specific adjustments to
  be made in sensors.conf. Another approach might be to define a module
  parameter. I prefer the current approach (it seems to be a bit better aligned
  with the hwmon sysfs API), but I am open to other ideas.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

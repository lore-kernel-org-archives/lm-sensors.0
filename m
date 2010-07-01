From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 01 Jul 2010 01:18:31 +0000
Subject: [lm-sensors] Driver for MAX6696 temperature sensor
Message-Id: <20100701011831.GA6915@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

one of the hwmon drivers I'll have to write is for MAX6696. This chip is similar to lm90 / max6680,
only it supports three temperature sensors instead of two. The two external sensors share one
set of registers.

What is the better approach - write a new driver based on the lm90 driver,
or modify the lm90 driver to support max6696 and thus optionally three channels ?
Any thoughts ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

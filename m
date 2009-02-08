From: Jerome Warnier <jwarnier@beeznest.net>
Date: Sun, 08 Feb 2009 11:46:14 +0000
Subject: [lm-sensors] SMSC support for Tyan S3992-E
Message-Id: <498EC606.4000109@beeznest.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On one of the servers I manage, which is a Debian Lenny (Testing)
running on Tyan S3992-E, I get the following kernel message when trying
to load the lm85 driver:

[5792969.531820] i2c /dev entries driver
[5793015.944697] i2c-adapter i2c-0: lm85: Detected SMSC chip
[5793015.944757] i2c-adapter i2c-0: lm85: Unrecognized version/stepping
0x68 Defaulting to Generic LM85.
[5793015.944853] hwmon-vid: Unknown VRM version of your x86 CPU


The kernel used is "linux-image-2.6.26-1-amd64          2.6.26-13".

The lm-sensors package is version "1:3.0.2-1+b2".

Hope it helps.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

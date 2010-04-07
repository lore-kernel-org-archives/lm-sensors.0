From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Wed, 07 Apr 2010 20:21:58 +0000
Subject: [lm-sensors] [PATCH 0/2]: hwmon: allow setting update rate from
Message-Id: <1270671720-1575-1-git-send-email-iws@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is an experimental patch to set the update rate from userspace. An
example implementation is provided for the adm1031 driver.

I think the modifications to the adm1031 driver turned out pretty ugly. I'd
be happy to drop the first patch and the userspace support from the second
patch.  I would keep just the parts that read the update rate from the chip
and use that during chip updates.

I can make my bootloader responsible for setting the update rate
appropriately in this case. The adm1031 driver will then use the programmed
update rate. The side effect to this is that a user cannot use i2cset to
change the update rate after the kernel has booted, if the driver is
built-in.

Thanks,
Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

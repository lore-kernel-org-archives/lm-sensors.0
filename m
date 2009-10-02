From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Oct 2009 13:43:32 +0000
Subject: [lm-sensors] Error message when ACPI causes a device probe to fail
Message-Id: <20091002154332.076fede2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

We have recently added a mechanism to check for ACPI vs. native driver
resource conflicts. When such a conflict happens, we get an error
message of the following form in the logs:

ACPI: I/O resource 0000:00:1f.3 [0x18a0-0x18bf] conflicts with ACPI region SMBI [0x18a0-0x18af]
ACPI: Device needs an ACPI driver

But when the conflict is found in probe(), we also get the following
error message:

i801_smbus: probe of 0000:00:1f.3 failed with error -16

This is because the probe() method returns -EBUSY. The driver core
currently silents some error codes (ENODEV and ENXIO) but not EBUSY.
This error message is redundant with the ones printed by ACPI, and
somewhat more frightening, so users may report it to us, as was the
case here:
http://bugzilla.kernel.org/show_bug.cgi?id293

So I would like to get rid of this message. I can think of two ways:

* Change the driver core to silent EBUSY as it does for ENODEV and
  ENXIO. Greg, I guess you wouldn't like that?

* Change all drivers to return either -ENODEV or -ENXIO when an ACPI
  resource conflict is found inside a probe function. After all, nobody
  will ever see the error code in question so maybe it's acceptable
  even though these error codes don't really match the reality?

Or maybe there's another fix possible and I did not see it. Feel free
to speak up if you have an idea.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 27 Mar 2009 12:18:50 +0000
Subject: [lm-sensors] Urgent: need some more info about the Hadess IC
Message-Id: <49CCC42A.6070804@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Some time ago we mailed about the Hadess management IC. You
said it was 100% identical to the Heimdall except for the
voltage registers, which should be 0x20 - 0x22.

This cannot be right, as this would give us the following
register definitions for the Hadess:

#define FSCHMD_REG_WDOG_PRESET		0x28
#define FSCHMD_REG_WDOG_STATE		0x23
#define FSCHMD_REG_WDOG_CONTROL		0x21

static const u8 FSCHMD_REG_VOLT[3] = { 0x20, 0x21, 0x22 };

Notice that register 0x21 now is seen as both a
voltage register and the watchdog control register, which
cannot be right. Can you please check if the watchdog registers
perhaps have changed with the Hadess too ?

And if possible double check nothing else has changed?

I put urgent in the subject, because I would like to
get the Hadess support in to kernel-2.6.30, and the
merge window for that has just opened (and doesn't stay open
all that long).

Thanks & Regards,

Hans


p.s.

2.6.30 will come with DMI based detection (so auto loading)
of the Hermes and Syleus drivers, and with Syleus support,
leading to 100% plug and play hwmon support for FSC systems
with those hwmon IC's :)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

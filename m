From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Tue, 25 Aug 2009 22:24:39 +0000
Subject: [lm-sensors] How to expose/clear historical faults (sysfs-interface)
Message-Id: <20090825222439.GH24983@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

I'm the author of the ltc4215 and ltc4245 drivers.

In the ltc4245 driver, I used the fault registers on the chip to display
the alarm outputs. These are not self-clearing (write 0 to clear).

In the ltc4215 driver, I used the status register on the chip to display
the alarm outputs. This is self clearing; it contains the status of the
chip at the time it is read. There is also a fault register, which has
historical status. It works exactly like the ltc4245 fault register.

For my application, I'm happy to have the ltc4245's alarms stay asserted
forever after they've been tripped once. However, I think it might be
beneficial to provide a way for userspace to clear the alarms. Alarms
are defined in the sysfs-interface document to be read-only.

For the ltc4215, the most useful output for my application are the
historical values: I'd like to know if the power supply was tripped in
the past due to overcurrent. Of course, I'd like a way to clear this
alarm, too. Is there an acceptable way to display both the immediate and
historical status to userspace?

I can always work around the above issues using the i2cget/i2cset
program to read/write the bits I need to, but this seems ugly.

Are there any thoughts about the above issues?

Thanks,
Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

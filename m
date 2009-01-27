From: Cory Casper <ccasper@gmail.com>
Date: Tue, 27 Jan 2009 16:41:19 +0000
Subject: [lm-sensors] Smart Battery locks up SMBus communication
Message-Id: <5955db7c0901270841i70139db2le3b1c7b42a81a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've run across a problem in interfacing with a smart battery
(bq2060E11) with kernel 2.4.26 and lm-sensors (2.10.0) and i2c
(2.10.0) patched into the kernel. Every once in a while which
difficult to repeat, the smart battery will not respond to the Linux
Host on smartbatt driver initialization. Monitoring I2C/SMBus activity
shows continuous clocking at the proper frequency on the Clock line
while the Data line was continuously de-asserted (high) by the smart
battery. We are unsure of what may be causing this invalid behavior
from the smart battery IC, however manually pulling the clock and data
lines low for 2.5 seconds does clear the invalid bus state.

Question 1: Has anyone observed this behavior with a smart battery and
know of any root causes that can make this happen? I feel that it may
be related to a message collision on the SMBus, but this is not yet
proven.

Question 2: If the root cause cannot be determined, how difficult
would it be to add the ability to detect this lockup in the kernel by
monitoring the SMBus activity and if detected, pull the data and clock
lines low for 2.5 seconds. Any implementation suggestions would be
highly valued since I will need to implement this. In addition, if
anyone would be help with this, I would be willing to donate towards
anyone helping to implement this behavior.

The SMBus contains a charger IC, Sm-Energy Lithium Ion Battery with
(BQ2060E207 battery IC), and an MPC880 processor running an Arabella
patched linux-2.4.26 kernel. The SMBus has two masters: the smart
battery and MPC880 host processor.

Any responses would be very appreciated,

Cory

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

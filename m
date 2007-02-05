From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Mon, 05 Feb 2007 15:23:28 +0000
Subject: [lm-sensors] LM85 problems with 2.6.16.x - 2.6.19.1
Message-Id: <654FA770A883FB43BAF3CB0B1E1DAC8C831D54@orca.penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0702051500420.28290@diagnostix.dwd.de>
In-Reply-To: <Pine.LNX.4.64.0702051500420.28290@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Can you send all of the 'lm85' lines from dmesg (ie dmesg | grep lm85) to the list.  I would like to confirm which chip was detected.  We may also need 'i2cdump 0 0x2e'

Thanks,
:v)

 -----Original Message-----
From: 	Holger Kiehl [mailto:Holger.Kiehl at dwd.de]
Sent:	Mon Feb 05 07:11:22 2007
To:	lm-sensors at lm-sensors.org
Subject:	[lm-sensors] LM85 problems with 2.6.16.x - 2.6.19.1

Hello

I am using a Tyan S4882 motherboard with 4 CPU's that has a LM85 sensor chip
which reports the following message during boot:

     .
     .
     ipmi device interface
     Enabling SMBus multiplexing for Tyan S4882
     lm85 0-002e: Client (0,0x2e) config is locked.
     lm85 0-002e: Client (0,0x2e) is not ready.
     lm85 0-002e: Client (0,0x2e) VxI mode is set. Please report this to the lm85 maintainer.

Looking at /var/log/messages I also can see multiple entries of:

     i2c_adapter i2c-0: SMBus collision!
          OR
     i2c_adapter i2c-1: SMBus collision!
          OR
     i2c_adapter i2c-2: SMBus collision!
           OR
     i2c_adapter i2c-3: SMBus collision!
           OR
     i2c_adapter i2c-4: SMBus collision!

This happens with lm_sensors 2.9.2 and 2.10.1 and plain kernel.org kernels
2.6.16.x to 2.6.19.1.

Any idea what is causing this and what I can do to remove the problem?

Thanks,
Holger
-- 



_______________________________________________
lm-sensors mailing list
lm-sensors at lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070205/cc205f2e/attachment.html 

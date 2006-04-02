From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 02 Apr 2006 08:11:15 +0000
Subject: [lm-sensors] nForce 410
Message-Id: <20060402101115.3be9e4b9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060401215808.67999.qmail@web37401.mail.mud.yahoo.com>
In-Reply-To: <20060401215808.67999.qmail@web37401.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, Rudolf,

(Mark, please always reply to the list rather than individual members.)

> Linux digittar 2.6.15-19-k7 #1 SMP PREEMPT Mon Mar 20 18:21:44 UTC 2006 i686 GNU/Linux
> (...)
> 0000:00:0a.1 0c05: 10de:0264 (rev a2)
> (...)
> 0000:00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a2)

OK, it's probably just a matter of adding this PCI ID to the
i2c-nforce2 driver. It would be nice if Nvidia could be somewhat
consistent in their product names...

Mark, please try the following (as root):
modprobe i2c-nforce2
echo "10de 0264" > /sys/bus/pci/drivers/nForce2_smbus/new_id

It should bring the SMBus to work. If it does, we'll add that ID to the
driver permanently.

Thanks,
-- 
Jean Delvare


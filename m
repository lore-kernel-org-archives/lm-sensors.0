From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 05 Nov 2006 12:20:55 +0000
Subject: [lm-sensors] help with laptop + eeprom
Message-Id: <454DD727.3080509@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ok, so I modprobed the modules and I tried running sensors. But I get:
> No sensors found!

EEproms are not the hardware monitoring devices. Your system has no known sensors.

You may try with acpi -V command to get the CPU temperature, or patch the kernel 
with my new Core 2 temperature monitor driver.

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-October/thread.html#18100

You need all three patches (the updated ones)

If you cant patch/compile kernel please wait for 2.6.20 or 2.6.21 kernel.

Regards
Rudolf


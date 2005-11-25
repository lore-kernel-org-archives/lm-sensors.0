From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 25 Nov 2005 20:52:32 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <43876B44.4070703@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

I have a theory that changing limit values will assert SMI interrupt and SMI code will hang the machine.
Maybe the interrupt is raised via SMBALERT line which can be disabled in the i2c-i801.c driver.

Eventualy i think if we switch the interrupt generation to IRQ9 so inux should report
"IRQ9 nobody cared" instead of crarsh ... if I'm correct with the SMI assumption.

you can try to:
setpci  -s 0:1f.3 40.b=1

This will set the SMB routing interrupt to IRQ9 (or some other but not on SMI)

and then repeat with sensors -s
This is a bit dangerous so please do it with filesystems mouted RO.

If you get instead of crash no crash and/or some message in dmesg we have won :)

Ruik

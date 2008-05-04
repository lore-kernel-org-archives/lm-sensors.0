From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 May 2008 17:30:54 +0000
Subject: [lm-sensors] Reverting the probe order
Message-Id: <20080504193054.2a81247b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

It just occurred to me today that the order in which we probe for
sensor chips in sensors-detect doesn't make sense. We start with the
less reliable and more risky probe (SMBus) to end with the less risky
and more reliable (Super-I/O, CPU and PCI devices). It is done that way
for historical reasons I guess, but in the light of recent reports [1],
I think we should reconsider our strategy.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023020.html

I think we should probe in the following order:

1* CPU and PCI chips. No probing is required, so it's 100% safe.

2* Super-I/O probing. The I/O ports accessed (0x2e, 0x2f and 0x4e,
0x4f) are relatively standard, so it's relatively safe.

3* ISA probing. We don't probe too many port, and half of the probes
are read-only, so it's still relatively safe, although probably less
safe than Super-I/O probes.

4* I2C/SMBus probing. As everybody knows, that's the most risky part,
because the semantics of I2C transactions vary from one chip to the
next, and while we only do read transactions from an SMBus perspective,
some chips may handle them as writes.

The advantage with reverting the probe order that way, is that we could
skip the most risky parts as soon as we have found what we were looking
for. In particular:

* I think we can skip ISA probing by default if we found a Super-I/O
with sensors. I can't remember a machine that had both a Super-I/O chip
with sensors, and an ISA hardware monitoring chip. In fact, we could
probably skip ISA probing even when we find a Super-I/O chip with no
sensors. The ISA chips (LM78, W83781D) are only found on old systems
which didn't have Super-I/O chips as far as I know.

* We could skip I2C probing by default if we have found a Super-I/O
chip with sensors. In most cases, the Super-I/O sensors will be what
the user must use, so why take the risk of probing the SMBus? The
Sapphire AM2RD790 motherboard is a good example of this. It uses an ITE
IT8716F for hardware monitoring, and probing the SMBus causes havoc.
The strategy I suggest would prevent users from getting into trouble
needlessly.

I know that on some boards, the Super-I/O sensors are activated but
unused, or they are used but a dedicated sensor chip is used in
addition, so the proposed strategy isn't perfect, but I still think it
would be a better (safer) default. We could then refine it depending on
the motherboard manufacturer for example.

Comments?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

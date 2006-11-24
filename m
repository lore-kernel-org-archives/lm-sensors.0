From: r.marek@assembler.cz (Rudolf Marek)
Date: Fri, 24 Nov 2006 13:07:41 +0000
Subject: [lm-sensors] Tyan S2877 CPU Temp Erratic
Message-Id: <4566EE9D.3050504@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163375222.4557b2764fc69@mail.third-rock.net>
In-Reply-To: <1163375222.4557b2764fc69@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Paul Reilly wrote:
> Hello,
> I have a Tyan S2877 motherboard. I had lm-sensors working perfectly,
> but every now and then the CPU temp field, goes wrong. For instance
> it was reporting around 50'C for ages, then after a reboot, it now
> reports -199.75?C . Opening the box, and checking all is OK. BIOS
> reports correct temp (around 48'C). Restarting multiple times, and
> still can't get it to go back to report correct CPU temp.

Hmm this may be some electrical problems or problems with the bus driver. Please 
can you switch on the i2c bus debugging in the kernel. If it is a production 
machine and you cannot experiment much with it you may try to use the k8temp 
driver which will read the CPU temperature directly from the processor.

The driver is in 2.6.19.

1) you may patch the kernel with patch for 2.6.19 - patches 
(http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017426.html)

2) use standalone version from here: 
http://assembler.cz/download/amd_digital_temp.tar.gz

3) lm-sensors 2.10.1 has the userspace support.

> I am using the LM85 module/code forced to use a ADT7463 chip
> as this best matches my hardware. My sensors.conf and output of
> sensors is shown below. NOTE, I only have one CPU in this dual
> socket board.
> 
> CPU1 Temp:-199.75?C  (low  =   -71?C, high =   -73?C)
> 
> Any one seen this problem before or know a fix?
> The CPU is a dual-core Opteron 265.

Oh one more idea. Please remove the "thermal" driver from kernel (rmmod thermal) 
or compile kernel without thermal zone support. Also, please send us the output of

cat /proc/acpi/dsdt > /tmp/dsdt.bin

Thanks,
Regards
Rudolf


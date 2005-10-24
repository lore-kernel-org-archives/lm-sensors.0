From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Mon, 24 Oct 2005 01:21:55 +0000
Subject: [lm-sensors] Support for SMSC 47M15x/192
Message-Id: <200510240119.29314.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510162303.21468.pavouk@pavouk.org>
In-Reply-To: <200510162303.21468.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> > I look at motherboard, and there is exactly LPC47M997-NR SMSC I/O chip.
>
> OK, so this suggests that this chip is compatible with the LPC47M15x and
> LPC47M192 chips as far as fan monitoring is concerned. You can set
> fan1_min to 0 to get rid of the alarm. That's a slow fan you have here,
> BTW.

It's a little strange. I can't set fan1_min lower than 640.
fan2_div it's possible to change to 1, 2, 4, 8, but minimal limits
are increased. Example of output:
smsc47m1-isa-0800
Adapter: ISA adapter
fan1:        0 RPM  (min =  640 RPM, div = 8)          ALARM
fan2:        0 RPM  (min = 5120 RPM, div = 1)          ALARM

smsc47m1-isa-0800
Adapter: ISA adapter
fan1:        0 RPM  (min =  640 RPM, div = 8)          ALARM
fan2:     1050 RPM  (min = 1280 RPM, div = 4)          ALARM

Setting of pwm doesn't work for me, but maybe I can do something wrong.

sensors -s tells me:
-----------------------
Error: Line 2047: Unknown feature name
smsc47m1-isa-0800: No such feature known
-----------------------

This is part of /etc/sensors.conf:
-------------------
chip "smsc47m1-*"
    set fan2_min 640
    set fan2_div 8
    set pwm1 1
-------------------

> The problem is that your system SMBus uses an ATI chip which we have no
> driver for, and I don't even think a datasheet is available. Since the
> hardware monitoring block is accessed through the SMBus, you won't be
> able to even access it without an ATI SMBus driver. Sorry.

This is probably on a good way :-)
Rudolf Marek working on it.

> You may try the ACPI "thermal" driver and look in
> /proc/acpi/thermal_zone. Maybe it'll at least let you know the CPU
> temperature.

This doesn't work for me.

Best regards,

Pavel Ruzicka

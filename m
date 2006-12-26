From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 26 Dec 2006 09:09:09 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <4590E6B5.1050409@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061208153817.de1c2b4c.khali@linux-fr.org>
In-Reply-To: <20061208153817.de1c2b4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi GongJun,

> [root at localhost ~]# sensors
> w83793-i2c-0-2f
> Adapter: SMBus I801 adapter at 1100
> VCoreA:    +1.18 V  (min =  +0.00 V, max =  +2.05 V)
> VCoreB:    +1.19 V  (min =  +0.00 V, max =  +2.05 V)
> Vtt:       +1.23 V  (min =  +0.00 V, max =  +2.05 V)
> in3:       +1.50 V  (min =  +0.00 V, max =  +4.08 V)
> in4:       +1.79 V  (min =  +0.00 V, max =  +4.08 V)
> +3.3V:     +3.31 V  (min =  +0.00 V, max =  +4.08 V)
> +12V:     +11.90 V  (min =  +0.00 V, max = +24.48 V)
> +5V:       +4.92 V  (min =  +0.00 V, max =  +6.12 V)
> 5VSB:      +4.94 V  (min =  +0.00 V, max =  +6.12 V)
> VBAT:      +3.20 V  (min =  +0.00 V, max =  +4.08 V)
> fan1:        0 RPM  (min =    0 RPM)
> fan2:     3169 RPM  (min =    0 RPM)
> fan3:        0 RPM  (min =    0 RPM)
> fan4:     3461 RPM  (min =    0 RPM)
> fan5:        0 RPM  (min =    0 RPM)
> fan6:        0 RPM  (min =    0 RPM)
> fan7:        0 RPM  (min =    0 RPM)
> fan8:        0 RPM  (min =    0 RPM)
> CPU1 Temp: +30.0??C  (high = +100.0??C, hyst = +95.0??C)
> CPU2 Temp: +31.0??C  (high = +100.0??C, hyst = +95.0??C)
> temp3:      +0.0??C  (high = +100.0??C, hyst = +95.0??C)
> temp4:      +0.0??C  (high = +100.0??C, hyst = +95.0??C)
> temp5:       +39??C  (high =  +100??C, hyst =   +95??C)
> temp6:       +37??C  (high =  +100??C, hyst =   +95??C)
> cpu0_vid: +1.513 V  (VRM Version 11.0)
> cpu1_vid: +0.425 V  (VRM Version 11.0)

This is expected to be good, because we tested with the "emulator" for the chip.
If you want to try that out:

http://assembler.cz/download/w83793/i2c-stub.c

You need to replace original i2c-stub in kernel/driver/i2c/busses and of course
choose it in menuconfig. When inserted it will just create a fake i2c bus with
fake chip on address 0x2f. Then if the module w83793 is loaded it will find this
chip and use it. The i2c-stub fakes the chip registers, so the reads from the
chip are exactly the same as from real chip - but they dont change. The writes
work too, because the modified value is stored in fake chip register.

We tried that when I was done with modifications of the drivers, so we at least
knew that this basic test would pass ;)

> If you have any idea that wants to be tested on w83793, feel free to contact us.

I think better would be to test setting of limits of voltages, fans. The a bit
of trip points. So generally the writes to the chip.

Rudolf


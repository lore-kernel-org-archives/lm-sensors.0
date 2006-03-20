From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Mon, 20 Mar 2006 23:38:33 +0000
Subject: [lm-sensors] [PATCH] Hardware monitoring support for SMSC
Message-Id: <200603210038.33203.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603192325570.3062@Laila>
In-Reply-To: <Pine.LNX.4.63.0603192325570.3062@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hartmut,

in-between is out final 2.6.16 and I tried it before few minutes.
I applied patch for ATI chipset from Rudolf too. 
It works for me, but my board MSI RS480M2-IL probably doesn't have
connected voltage inputs and TEMP3 input.
It corresponds to latest BIOS, where only fans and two temperatures
are visible.

Here is output from sensors program:
--------------------------------------
[root at home lm_sensors-2.10.0]# sensors
smsc47m1-isa-0800
Adapter: ISA adapter
fan1:        0 RPM  (min =  640 RPM, div = 8)          ALARM
fan2:     1059 RPM  (min =  640 RPM, div = 8)

smsc47m192-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 0b00

+2.5V:     +0.00 V  (min =  +0.00 V, max =  +3.32 V)   ALARM
VCore:     +0.00 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
+3.3V:     +0.00 V  (min =  +0.00 V, max =  +4.38 V)   ALARM
+5V:       +0.00 V  (min =  +0.00 V, max =  +6.64 V)   ALARM
VCC:       +3.37 V  (min =  +0.00 V, max =  +4.38 V)
+1.5V:     +0.00 V  (min =  +0.00 V, max =  +1.99 V)   ALARM
+1.8V:     +0.00 V  (min =  +0.00 V, max =  +2.39 V)   ALARM
Chip Temp: +37.0?C  (low  =  -128?C, high =  +127?C)
CPU Temp:  +26.0?C  (low  =  -128?C, high =   +60?C)
Sys Temp: +117.0?C  (low  =  -128?C, high =  +127?C)
vid:      +1.550 V  (VRM Version 2.4)
--------------------------------------
-------------
dmesg output:
smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997
i2c_adapter i2c-0: found SMSC47M192 or SMSC47M997, version 2, stepping A0
-------------

I must add line "MODULE_4=smsc47m192" for automatic loading of module.

Best regards,

Pavel Ruzicka

> I guess I forgot to mention that the patch was for kernel version
> 2.6.16-rc5 - sorry for that.
>
> For convenience, I attach the corresponding patch for 2.6.15 to this
> email.
>
> Best wishes,
>   Hartmut


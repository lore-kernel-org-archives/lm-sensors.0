From: "Lars Kr.Lundin" <lmsensors@lklundin.dk>
Date: Wed, 23 Jun 2010 19:37:59 +0000
Subject: Re: [lm-sensors] sensors.conf for DFI LP MI P55-T36 (it8720-*)
Message-Id: <20100623193759.26257.qmail@mailserver01.ottosenfx.dk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3418567598896959597=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
In-Reply-To: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
To: lm-sensors@vger.kernel.org

--===============3418567598896959597==
Content-Type: text/plain

On Tue, Jun 22, 2010 at 10:10:38PM +0200, Jean Delvare wrote:
> Hi Lars,
>
>
> Could you please provide a dump of the configuration register space of
> your chip? I'd like to check something:

Hi Jean,

Thanks for your interest in this board.

>
> # isaset -y -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
>

The -k option is not supported by /usr/sbin/isaset under Ubuntu 10.04:

$ sudo isaset
Syntax for I2C-like access:
  isaset [-y] ADDRREG DATAREG ADDRESS VALUE [MASK]
Syntax for flat address space:
  isaset [-y] -f ADDRESS VALUE [MASK]

> Together with the output of "sensors", and the revision of your chip
> (printed in the kernel logs when you load the it87 driver).

$ grep it87 /var/log/dmesg
[    3.992279] it87: Found IT8720F chip at 0xa10, revision 8
[    3.992288] it87: in3 is VCC (+5V)
[    3.992290] it87: in7 is VCCH (+5V Stand-By)


$ sensors
it8720-isa-0a10
Adapter: ISA adapter
Vcore:        +0.90 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
Vtt:          +1.15 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
+3.30V:       +3.28 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
in3:          +2.91 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
in4:          +2.83 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
CPU PLL:      +1.81 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
DRAM Voltage: +1.65 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
in7:          +2.90 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
Vbat:         +3.36 V
PWM fan:        0 RPM  (min =    0 RPM)
CPU fan:      448 RPM  (min =    0 RPM)
PCH Temp:     +43.0���C  (low  =  -1.0���C, high =  -1.0���C)  ALARM  sensor = thermistor
PWM Temp:     +43.0���C  (low  =  -1.0���C, high =  -1.0���C)  ALARM  sensor = thermistor
CPU Temp:     +30.0���C  (low  = +13.0���C, high = +13.0���C)  ALARM  sensor = disabled
cpu0_vid:    +1.300 V


>
> Thanks,
> --
> Jean Delvare

You are welcome to ask for other tests.

-Lars Lundin.



--===============3418567598896959597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3418567598896959597==--

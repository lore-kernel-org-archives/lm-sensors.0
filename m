From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 08 Aug 2013 05:19:17 +0000
Subject: Re: [lm-sensors] Unsuported ITE chipset 0x8771
Message-Id: <52032A55.40309@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <6CFD278BAABA444AAA6A1BAC172498CD@adminDator>
In-Reply-To: <6CFD278BAABA444AAA6A1BAC172498CD@adminDator>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 08/07/2013 09:41 PM, Sebastian Sjoholm wrote:
> Hi,
>
> I was reading the old post regarding the unsupported ITE chipset, and did a printout from my boards as well, I don't know if it helps.
>
Experimental support for IT8771E and IT8772E was added to the it87 driver
with Linux version 3.9. What kernel version are you running ?

Thanks,
Guenter

> # isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 4 using bank register 0x07.
> Continue? [Y/n] y
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 87 71 00 00 00 00 ff 0e 22 82 00 40 03 00 00 00
> 30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 02 90 02 30 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 02 00 00 04 04 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 40 00 00 20 00 f0 00 01 00 00 00 00 00 00 00
> # isadump 0x295 0x296
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x295 and data register 0x296.
> Continue? [Y/n] y
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 19 02 ff 01 37 ff 07 37 ff 07 49 0f 00 82 ff 00
> 10: ff d2 5f 3b c7 80 00 00 00 ff 00 ff 9f 6f 6f 6f
> 20: 2f ba f2 8a ba f4 ba 8d 88 35 2e f8 80 f0 00 00
> 30: 7f fe af ef 0e 9f b9 ff 0d df 7b 2f 7e 78 ae 9f
> 40: df eb 6f b5 fd fc 5f 40 ad 6a d4 00 ff ff ff ff
> 50: ff 38 7f 7f 7f 40 00 00 90 00 01 12 60 00 00 00
> 60: 00 14 46 6a 14 41 0f ff 00 7f 7f ff 00 00 0f ff
> 70: 7f 7f 7f 80 00 00 0f ff ff ff ff ff ff ff ff ff
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 3c 02 04
> 90: ff 00 00 00 ff 00 00 00 40 00 00 00 00 b6 02 20
> a0: fb f7 f7 f7 f7 f7 f7 ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> # modprobe it87 force_id=0x8721
> # sensors
> radeon-pci-0008
> Adapter: PCI adapter
> temp1:        +62.0°C
>
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +62.5°C  (high = +70.0°C)
>                         (crit = +100.0°C, hyst = +97.0°C)
>
> it8721-isa-0290
> Adapter: ISA adapter
> in0:          +0.56 V  (min =  +3.05 V, max =  +1.52 V)  ALARM
> in1:          +2.23 V  (min =  +2.87 V, max =  +2.10 V)  ALARM
> in2:          +2.90 V  (min =  +1.91 V, max =  +0.17 V)  ALARM
> +3.3V:        +3.31 V  (min =  +0.00 V, max =  +4.44 V)  ALARM
> in4:          +2.23 V  (min =  +2.68 V, max =  +0.16 V)  ALARM
> in5:          +2.92 V  (min =  +0.56 V, max =  +1.48 V)  ALARM
> in6:          +2.23 V  (min =  +1.44 V, max =  +1.51 V)  ALARM
> 3VSB:         +3.38 V  (min =  +3.82 V, max =  +4.18 V)  ALARM
> Vbat:         +3.26 V
> fan1:        5192 RPM  (min =    0 RPM)
> fan2:           0 RPM  (min =   16 RPM)  ALARM
> temp1:        +53.0°C  (low  = -21.0°C, high = -33.0°C)  ALARM  sensor = thermistor
> temp2:        +46.0°C  (low  = -75.0°C, high = +111.0°C)  sensor = thermistor
> temp3:         -8.0°C  (low  =  -4.0°C, high =  -3.0°C)  sensor = thermistor
> intrusion0:  OK
>
> I have total 5 of these boards, if requested I can printout from all of them.
>
> Regards,
> Sebastian
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

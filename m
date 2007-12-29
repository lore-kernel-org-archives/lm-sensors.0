From: "Rutul Dave" <rutuldave@gmail.com>
Date: Sat, 29 Dec 2007 21:03:55 +0000
Subject: Re: [lm-sensors] error loading coretemp module for 2.6.21.5 kernel
Message-Id: <975b59c50712291303u17f3a4bh388f53809d6fd94f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <975b59c50712271552u8e4b846r9545f817f8d779e1@mail.gmail.com>
In-Reply-To: <975b59c50712271552u8e4b846r9545f817f8d779e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Thanks Rudolf, your suggestion did work. I was able to load
coretemp.ko with the fix. The CPU model for the new processors is 0x17

[73247.627311] coretemp coretemp.0: This driver uses undocumented
features of Core CPU (Intel will not disclose the information to
individuals). Temperature might be wrong!
[73247.627413] coretemp coretemp.1: This driver uses undocumented
features of Core CPU (Intel will not disclose the information to
individuals). Temperature might be wrong!
[73247.627517] coretemp coretemp.2: This driver uses undocumented
features of Core CPU (Intel will not disclose the information to
individuals). Temperature might be wrong!
[73247.627634] coretemp coretemp.3: This driver uses undocumented
features of Core CPU (Intel will not disclose the information to
individuals). Temperature might be wrong!
[73247.627719] coretemp coretemp.4: This driver uses undocumented
features of Core CPU (Intel will not disclose the information to
individuals). Temperature might be wrong!
[73247.627824] coretemp coretemp.5: This driver uses undocumented
features of Core CPU (Intel will not disclose the information to
individuals). Temperature might be wrong!
[73247.627967] coretemp coretemp.6: This driver uses undocumented
features of Core CPU (Intel will not disclose the information to
individuals). Temperature might be wrong!
[73247.628107] coretemp coretemp.7: This driver uses undocumented
features of Core CPU (Intel will not disclose the information to
individuals). Temperature might be wrong!


[root@localhost hwmon]# sensors
w83793-i2c-0-2f
Adapter: SMBus I801 adapter at 1100
VCoreA:    +1.20 V  (min =  +0.92 V, max =  +1.49 V)
VCoreB:    +1.20 V  (min =  +0.92 V, max =  +1.49 V)
Vtt:       +1.16 V  (min =  +1.08 V, max =  +1.33 V)
in3:       +0.51 V  (min =  +0.38 V, max =  +0.69 V)
in4:       +2.99 V  (min =  +1.34 V, max =  +1.65 V)   ALARM
+3.3V:     +3.28 V  (min =  +2.96 V, max =  +3.63 V)
+12V:     +11.62 V  (min = +10.75 V, max = +13.25 V)
+5V:       +5.05 V  (min =  +4.64 V, max =  +5.65 V)
5VSB:      +5.09 V  (min =  +4.64 V, max =  +5.65 V)
VBAT:      +3.26 V  (min =  +2.99 V, max =  +3.66 V)
fan1:        0 RPM  (min =  712 RPM)                   ALARM
fan2:        0 RPM  (min =  712 RPM)                   ALARM
fan3:        0 RPM  (min =  712 RPM)                   ALARM
fan4:        0 RPM  (min =  712 RPM)                   ALARM
fan5:        0 RPM  (min =  712 RPM)                   ALARM
fan6:        0 RPM  (min =  712 RPM)                   ALARM
fan7:        0 RPM  (min =  712 RPM)                   ALARM
fan8:        0 RPM  (min =  712 RPM)                   ALARM
fan9:        0 RPM  (min =  712 RPM)                   ALARM
fan10:       0 RPM  (min =  712 RPM)                   ALARM
CPU1 Temp: +12.0°C  (high = +75.0°C, hyst = +70.0°C)
CPU2 Temp: +17.0°C  (high = +75.0°C, hyst = +70.0°C)
temp3:     +35.8°C  (high = +75.0°C, hyst = +70.0°C)
temp4:     +35.0°C  (high = +75.0°C, hyst = +70.0°C)
temp5:       +29°C  (high =   +50°C, hyst =   +45°C)

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:     +4.08 V  (min =  +2.82 V, max =  +3.79 V)       ALARM
+5V:       +5.11 V  (min =  +5.89 V, max =  +3.28 V)       ALARM
+12V:     +11.61 V  (min =  +6.63 V, max = +15.50 V)
-12V:      +0.88 V  (min = -10.22 V, max = -13.10 V)       ALARM
-5V:       +1.99 V  (min =  +4.20 V, max =  +1.13 V)       ALARM
V5SB:      +5.70 V  (min =  +4.38 V, max =  +3.23 V)       ALARM
VBat:      +0.24 V  (min =  +1.18 V, max =  +1.82 V)       ALARM
fan1:        0 RPM  (min =    0 RPM, div = 2)
fan2:        0 RPM  (min = 3835 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 2689 RPM, div = 2)              ALARM
temp1:       -48°C  (high =   +60°C, hyst =   +55°C)   sensor = thermistor
temp2:     -48.0°C  (high =   +80°C, hyst =   +75°C)   sensor = thermistor
temp3:     -48.0°C  (high =   +80°C, hyst =   +75°C)   sensor = thermistor
vid:      +0.000 V  (VRM Version 8.2)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +20°C  (high =  +100°C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +13°C  (high =  +100°C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +26°C  (high =  +100°C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +23°C  (high =  +100°C)

coretemp-isa-0004
Adapter: ISA adapter
Core 4:      +25°C  (high =  +100°C)

coretemp-isa-0005
Adapter: ISA adapter
Core 5:      +24°C  (high =  +100°C)

coretemp-isa-0006
Adapter: ISA adapter
Core 6:      +32°C  (high =  +100°C)

coretemp-isa-0007
Adapter: ISA adapter
Core 7:      +31°C  (high =  +100°C)



On Dec 28, 2007 12:13 PM, Rudolf Marek <r.marek@assembler.cz> wrote:
> Hi,
>
> Your CPU is to new, I guess Penryn based.
>
> The driver will work if you just fix:
>
>
>
>                  /* check if family 6, models e, f */
>
>                  if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
>
>                      !((c->x86_model = 0xe) || (c->x86_model = 0xf))) {
>
> to:
>
>
>                  /* check if family 6, models e, f */
>
>                  if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
>
>                      !((c->x86_model = 0xe) || (c->x86_model = 0x17))) {
>
> Thanks,
>
> Rudolf
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

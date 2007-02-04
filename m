From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 04 Feb 2007 15:03:06 +0000
Subject: [lm-sensors] Inconsistents results
Message-Id: <45C5F5AA.4090804@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C17E27.70603@free.fr>
In-Reply-To: <45C17E27.70603@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Georges Giralt wrote:
> Hi !
> I own a recent Asus mainboard (M2NPV-VM) with an Athlon 64X2 3600+ (the 
> cheap low cache version, low power consumption).
> The results I get with ACPI and sensors are inconsistent :
> The Mobo BIOS gives 28~30 ? C for the proc and 1?C above for the mobo 
> so 29~31 ?C)
> Under Linux (Fedora Core 6 2.6.19-1.2895.fc6 X86-64) I get :
> # cat /proc/acpi/thermal_zone/THRM/temperature
> temperature:             40 C

Please can you provide the dsdt.bin file?

cat /proc/acpi/dsdt > /tmp/dsdt.bin

(this command will create it in the /tmp directory)

> #sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>               +13?C
> Core1 Temp:
>               +27?C
> 
> it8716-isa-0290
> Adapter: ISA adapter
> VCore:     +1.02 V  (min =  +0.00 V, max =  +4.08 V)
> VDDR:      +3.25 V  (min =  +0.00 V, max =  +4.08 V)
> +3.3V:     +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> +5V:       +4.84 V  (min =  +0.00 V, max =  +6.85 V)
> +12V:     +11.78 V  (min =  +0.00 V, max = +16.32 V)
> in5:       +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> in6:       +0.00 V  (min =  +0.00 V, max =  +3.82 V)   ALARM
> 5VSB:      +4.68 V  (min =  +0.00 V, max =  +6.85 V)
> VBat:      +2.91 V
> fan1:     2860 RPM  (min =    0 RPM)
> fan2:     1391 RPM  (min =    0 RPM)
> fan3:        0 RPM  (min =    0 RPM)
> temp1:       +18?C  (low  =    -1?C, high =  +127?C)   sensor = diode
> temp2:       +28?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
> temp3:       +25?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
> vid:      +0.000 V
> #
> Two things bother me : First, the discrepancy between core0 temp and 
> core1 temp. As they are into the same package, they should even out, 
> should'nt they ? The second thing is that the spread ot temperature I 
> get : 13, 18, 25, 27, 28 and 40 ?C ...

You mean when you try to raise the temperature - CPU usage?

> If anybody has an answer, a lead, or an idea, it will have my gratitude !

The ACPI versus lm-sensors temperature may be explained after I will have the
dsdt.bin

Add +49



13 62 3E  0011 1110

18 67 43  0100 0011

25 74 4A  0100 1010

27 76 4C  0100 1100

28 77 4D  0100 1101

40 89 59  0101 1001

I added the 49 value to get back the raw value, no bit is stuck. Btw the diode
reading reads 18C - quite close to 13C - maybe the internal CPU sensors is not
well calibrated?

28-25 is the thermistor temperature of motherboard and not processor.

Please also include the cat /proc/cpuinfo

Thanks,
Rudolf


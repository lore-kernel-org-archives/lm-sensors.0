From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 10 Aug 2013 22:53:20 +0000
Subject: Re: [lm-sensors] Problems with Nuvoton nct6775 readouts
Message-Id: <5206C460.3080006@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/10/2013 03:38 PM, Tommy Apel wrote:
> Hello Mr. Roeck,
>
> I'm currently using your patched version of the nct6775 hwmon module,
> one thing that strikes me as odd is that the voltage readouts are way
> off from what they should be, it looks almost like I only get the
> readout for 'idle state', I've fixed my vcore at 1.3v but according to
> the readout at full load it is 0.9v, someone told me that the 'turbo'
> option could have an effect so that has been turned of for the sake of
> troubleshooting.
>
> Do you have any clues as to why this is happening ?
>
There are two reasons. First, ASUS doesn't set any limits in the BIOS,
which explains why all the limits are 0 and why the alarms are all active.

The second reason is that the ADCs in the Nuvoton chip have a maximum
range of 2.048V. Most voltage inputs are connected through a voltage divider.
For some of the voltages, there is an internal divider, which explains
the higher voltages. you will have to find out what the divider values are.
Then configure both the limits and the divider values in /etc/sensors3.conf,
run "sudo sensors -s", and all whould be ok.

Some hints how to determine divider values are at
	http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling
	http://www.lm-sensors.org/wiki/AsusFormulaHacking

Hope that helps. Some ASUS configurations are at
	http://www.lm-sensors.org/wiki/Configurations/Asus
You should be able to use those as examples.

Hope this helps,
Guenter

> Fan readings are about right it seems though.
>
> this is an ASUS Z87-A mobo with a Haswell i5-4670K@3.4GHz
>
> sensors output at full load>
>
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +27.8 C  (crit = +105.0 C)
> temp2:        +29.8 C  (crit = +105.0 C)
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +68.0 C  (high = +80.0 C, crit = +100.0 C)
> Core 0:         +68.0 C  (high = +80.0 C, crit = +100.0 C)
> Core 1:         +65.0 C  (high = +80.0 C, crit = +100.0 C)
> Core 2:         +61.0 C  (high = +80.0 C, crit = +100.0 C)
> Core 3:         +64.0 C  (high = +80.0 C, crit = +100.0 C)
>
> nct6791-isa-0290
> Adapter: ISA adapter
> in0:                    +0.90 V  (min =  +0.00 V, max =  +1.74 V) </-
> I assume this would be vcore
> in1:                    +1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in2:                    +3.41 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in3:                    +3.41 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in4:                    +1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in5:                    +1.99 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in6:                    +0.66 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in7:                    +3.46 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in8:                    +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in9:                    +1.01 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in10:                   +0.00 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in11:                   +0.87 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in12:                   +0.66 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in13:                   +0.66 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in14:                   +0.66 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> fan1:                   925 RPM  (min =    0 RPM)
> fan2:                  1025 RPM  (min =    0 RPM)
> fan3:                     0 RPM  (min =    0 RPM)
> fan4:                  3316 RPM  (min =    0 RPM)
> fan5:                     0 RPM  (min =    0 RPM)
> fan6:                  1001 RPM
> SYSTIN:                 +30.0 C  (high =  +0.0 C, hyst =  +0.0 C)
> ALARM  sensor = thermistor
> CPUTIN:                 +41.0 C  (high = +80.0 C, hyst = +75.0 C)
> sensor = thermistor
> AUXTIN0:                +45.0 C    sensor = thermistor
> AUXTIN1:               +127.0 C    sensor = thermistor
> AUXTIN2:                +33.0 C    sensor = thermistor
> AUXTIN3:                +45.0 C    sensor = thermistor
> PCH_CHIP_CPU_MAX_TEMP:   +0.0 C
> PCH_CHIP_TEMP:           +0.0 C
> PCH_CPU_TEMP:            +0.0 C
> PCH_MCH_TEMP:            +0.0 C
> intrusion0:            ALARM
> intrusion1:            ALARM
> beep_enable:           disabled
>
>
> /Tommy
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

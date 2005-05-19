From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Sensors detected, modules load, but nothing reported in sensors
Message-Id: <20050408215127.49587451.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4255A7BA.1040007@ameritech.net>
In-Reply-To: <4255A7BA.1040007@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeffery,

> In that range /proc/ioports shows:
> 
> 0295-0296 : pnp 00:09
> 
> Recompiled as you recommended with ACPI PnP turned off, and it works! 
> 
> Thanks so much for the response, I am quite happy with how well this
> works!

So you have this same problem as reported on bugzilla. Feel free to add
a comment there, stating you have the same problem. I would like to see
the problem resolved.

> FYI, and I think this may be a bug in sensors related only to dual cpu
> systems (or maybe just MY system)... when I run sensors I get:
> 
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.53 V  (min =  +0.94 V, max =  +0.96 V)
> +12V:      +5.65 V  (min = +10.82 V, max = +13.19 V)
> +3.3V:     +3.33 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.99 V  (min =  +4.75 V, max =  +5.25 V)
> -12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)
> V5SB:      +5.00 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +0.16 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:        0 RPM  (min =   -1 RPM, div = 2)
> CPU Fan:  4963 RPM  (min =   -1 RPM, div = 2)
> fan3:     4927 RPM  (min =   -1 RPM, div = 2)
> M/B Temp:    +25 C  (high =   +37 C, hyst =    +0 C)   sensor > thermistor     
> CPU Temp:  +21.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode
> temp3:     +19.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode
> vid:      +0.275 V  (VRM Version 9.0)
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm disabled
> 
> 
> Here are the (very minor!!) issues with the above:
> 
> 1.  When I run gkrellm2, it correctly recognizes that I have two Vcore
> Vcore1 and Vcore2.  Sensors only reports the first as Vcore.

Quite possibly in1 is VCore2. Edit /etc/sensors.conf, look for the
w83627thf-* section, and edit the labels as:

    label in0 "VCore1"
    label in1 "VCore2"

And comment out the "compute in1" line.

Might do the trick. More generally I invite you to search for hardware
monitoring data in the BIOS setup screens at boot time, write down
everything, and tweak /etc/sensors.conf accordingly. I usually helps.

> 2.  Similarly, I think that sensors is missing that temp3 is really
> CPU1 temp.

I doubt that. 19.5 degrees is not much. I never saw a CPU running below
24 degrees - and it wasn't an Opteron. If Opertons can really run that
low, I'm going to buy one.

> 3.  Strangely, sensors reports +5v on my 12V line, and -14 volts on
> the -12V line.  In contrast, gkrellm2 only sees one line - the +12V
> line and shows it as 0 which is maybe more likely since it is possible
> the 12V line is unused?

Unused, no. Unmonitored, quite possibly.

> I seem to recall that the 12V line is used in
> P4 systems, and to support power hungry AGP/PCI-E cards, neither of
> which exist in my micro dual opteron setup.  Anyway why does sensor
> report 14volts vs. 0 for gkrellm2?  I had thought gkrellm2 just read
> from lm_sensors, but maybe I am wrong about that.  Thoughts, if any?

Gkrellm and sensors share the drivers, but sensors relies on libsensors
and sensors.conf, while gkrellm does its own confiugration stuff. This
explains the differences.

-- 
Jean Delvare

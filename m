From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jul 2011 06:38:13 +0000
Subject: Re: [lm-sensors] want memory temperature(i5k_amb),
Message-Id: <20110724083813.58cc9882@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOfki7BChsVD09-EKKKG+tkmjAysXqQTO98XDZqxjmdRPh=sag@mail.gmail.com>
In-Reply-To: <CAOfki7BChsVD09-EKKKG+tkmjAysXqQTO98XDZqxjmdRPh=sag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sat, 23 Jul 2011 14:10:47 -0500, Suyu Zhang wrote:
> Hi, I have a Xserve server with 64bit 10.04 ubuntu and Mac os X server.
> 
> I want to know the temperature of memory module (FB-DIMM) under ubuntu, so I
> use 'sensors-detect' with following modules find:
> 
> Intel Core family thermal sensor...                         Success!
>     (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         Success!
>     (driver `i5k_amb')
> 
> then I 'modprobe' coretemp and i5k_amb, but when I use 'sensors', I can only
> get cpu temperature, and no memory temperature:
> 
> root@lake:/home/szhang# sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +51.0°C  (high = +86.0°C, crit = +100.0°C)
> 
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +51.0°C  (high = +86.0°C, crit = +100.0°C)
> 
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 1:      +52.0°C  (high = +86.0°C, crit = +100.0°C)
> 
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 0:      +50.0°C  (high = +86.0°C, crit = +100.0°C)
> 
> and I check mods and i5k_amb is loaded:
> 
> root@lake:/home/szhang# lsmod | grep i5k_amb
> i5k_amb                 5536  0
> 
> more interesting, I use a temperature monitor tool on Mac os, which is
> http://www.bresink.de/osx/TemperatureMonitor.html
> 
> I was surprised find that it provide a lot of sensors reading, including
> memory modules:
> 
> CPU Core 1: 39 C
> CPU Core 2: 41 C
> CPU Core 3: 39 C
> CPU Core 4: 42 C
> SMART Disk ST3750640NS P (3QD0H1Q0): 34 C
> SMC AMBIENT AIR: 27 C
> SMC AMBIENT AIR POSITION 2: 24 C
> SMC CPU A HEAT SINK: 36 C
> SMC CPU A PROXIMITY: 27 C
> SMC CPU B HEAT SINK: 35 C
> SMC CPU B PROXIMITY: 27 C
> SMC CPU C PROXIMITY: 27 C
> SMC CPU D PROXIMITY: 28 C
> SMC DRIVE BAY 1: 32 C
> SMC DRIVE BAY 2: 37 C
> SMC EXPANSION SLOTS: 38 C
> SMC GPU 1 CHIP: 45 C
> SMC MEMORY BANK A POS 0: 45 C
> SMC MEMORY BANK A POS 1: 26 C
> SMC MEMORY BANK A POS 2: 27 C
> SMC MEMORY BANK A POS 3: 27 C
> SMC MEMORY MODULE A1: 58 C
> SMC MEMORY MODULE A2: 63 C
> SMC MEMORY MODULE A3: 60 C
> SMC MEMORY MODULE A4: 56 C
> SMC MEMORY MODULE A5: 57 C
> SMC MEMORY MODULE A6: 55 C
> SMC MEMORY MODULE A7: 51 C
> SMC MEMORY MODULE B0: 54 C
> SMC NORTHBRIDGE CORE: 118 C
> SMC NORTHBRIDGE HEAT SINK: 79 C
> SMC PCI SLOT 1 POS 1: 44 C
> SMC PCI SLOT 1 POS 2: 46 C
> SMC PCI SLOT 2 POS 1: 44 C
> SMC PCI SLOT 2 POS 2: 47 C
> SMC POWER SUPPLY POSITION 1: 33 C
> SMC POWER SUPPLY POSITION 2: 49 C
> SMC POWER SUPPLY POSITION 3: 36 C
> 
> but with Mac os I can't do anything about my project...
> 
> so how can I get the memory temperature in ubuntu?

I don't know much about Apple hardware, but given the output above, you
could try loading the applesmc driver, maybe it will work.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

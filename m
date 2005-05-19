From: timo-news@eriele.fi (Timo Neuvonen)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Intel D865GLC (was: Re: Interested to donate a board to get a driver)
Message-Id: <cug5mm$bct$1@sea.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> After taking a look at your motherboard manual, it seems very clear to me
> that the fan monitoring capabilities of your PC87372 chip are NOT used.
> You have another, dedicated hardware monitoring chip on that board, with
> voltage, temperature and fan monitoring, and fan control. If you have a
> physical access to the board, look for it between to the CPU Fan header
> and the edge of the board (the manual has a nice drawing).
>

You seem to have pretty good manual there :-)

Chip in the location you described is (depending on the individual board in
question, I checked two boards) ADM1027, or EMC6D102.
lm_sensors uses ADM1027's driver to correctly access it.


> So it wouldn't be exactly fair from us to accept a donation from you and
> then find out that the driver we wrote is useless to you.
>
Nice that you care this much about my money. I really appreciate it.


> Could you please provide the output of sensors-detect (a recent one) for
> your system? I'm surprised that it didn't find that chip, since it's
> supposed to hang off the Intel SMBus, which we do support.
>
Actually, it did. I just was a little bit too much simple-minded. I noticed
sensors resulted in only one (cpu) fan speed reading, and there are three
fan connectors in the motherboard (and I want to use them all since couple
of days ago one of my servers crashed just because of a broken fan inside
the power supply).

My (incorrect) idea was that maybe this another fan monitoring chip is used
for the remaining two fans, until you told me it's not used for fan
monitoring at all. Actually, the reason for missing results was simply that
there were ignore- lines in sensors.conf for all but the first fan monitor
input for adm1027. Eh, easy to notice I'm just a beginner a with
lm_sensors...?

So, this problem seems to be solved now; what still remain is that I'm a
little suspicious about voltage readings looking too much idealistic, like
Vcore 1.500 Volts...

The output of sensors-detect is attached to the end of the message anyway,
although it obviously is now of little use.


> Thanks,
>
Hey, it's me who is supposed to say thanks!
You just lost a new motherboard... ;-)




Next adapter: SMBus I801 adapter at c400 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x08
Client found at address 0x0c
Client at address 0x2e can not be probed - unload all client drivers first!
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): y
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): y
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0xf011)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xf011)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xf011)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Success... found at address 0x06e0
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0xf0)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xf0)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xf0)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xf0)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xf0)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xf0)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xf0)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xf0)
Probing for `Winbond W83L517D Super IO'
  Failed! (0xf0)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus address 0x06e0 (Busdriver `i2c-isa')
    Chip `Nat. Semi. PC87372 Super IO Fan Sensors' (confidence: 9)



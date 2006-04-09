From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 09 Apr 2006 07:58:11 +0000
Subject: [lm-sensors] i2c-i801 and i2c-i810 can't see  82845G
Message-Id: <20060409095811.6c734355.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44389EC6.4060402@donehue.net>
In-Reply-To: <44389EC6.4060402@donehue.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

> I'm trying to get sensors working on a motherboard I have (see details 
> below)
> 
> I have run sensors-detect (see output further below) - and it says that 
> I have a i801 chipset, but when I run sensors I get this output:
> "No sensors found!"
> 
> I am running a 2.6.16.2 kernel on a debian x86 machine.
> (...)
> (lspci gives this output)
> 0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM 
> Controller/Host-Hub Interface (rev 01)
>         Subsystem: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM 
> Controller/Host-Hub Interface
>         Flags: bus master, fast devsel, latency 0
>         Memory at d0000000 (32-bit, prefetchable) [size8M]
>         Capabilities: [e4] #09 [0105]

This isn't the device with the SMBus interface. Look for an entry with
type "SMBus", e.g.:

00:1f.3 SMBus: Intel Corporation 82801CA/CAM SMBus Controller (rev 01)
        Subsystem: Sony Corporation VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
        Flags: medium devsel, IRQ 255
        I/O ports at 1880 [size2]

> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel 82801DB ICH4
> Probe succesfully concluded.
> 
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> (...)
> Next adapter: SMBus I801 adapter at 5000
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Client found at address 0x30
> Client found at address 0x31
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
> Client found at address 0x50
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Probing for `DDC monitor'... Failed!
> Probing for `Maxim MAX6900'... Failed!
> Client found at address 0x51
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x69

This means that your SMBus adapter was properly detected by the
i2c-i801 driver, but you only have SPD EEPROMs (memory module
information) available on this bus.

As for the i2c-i810 driver, you need lm_sensors 2.10.0 or later for
sensors-detect to find it. With earlier version, you must load it
manually before running sensors-detect if you want it to be probed.
However, this only makes sense if you are actually using the integrated
graphics chip and not an additional graphics adapter. Even then, the
chances that any hardware monitoring device is found on this bus are
very thin, all you'll see there is most certainly an information EEPROM
about the connected display if it supports DDC.

> Probing for `ITE 8702F Super IO Sensors'
>   Success... found at address 0x0290

This is your hardware monitoring chip. It's not a dedicated chip on the
SMBus, instead the hardware monitoring features are integrated into
your ITE Super-I/O chip.

Unfortunately, we don't have a driver for this chip at the moment. A
datasheet is available, so writing a driver is possible, however, this
takes time and we don't have much. I could find two previous requests
here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2003-August/003765.html
http://secure.netroedge.com/~lm78/readticket.cgi?ticket28
I've updated our "new drivers" page to mention all three requests.

According to my earlier investigation, the IT8702F chip only supports
fan speed monitoring and control (5 channels) and VID input, so it's
not a complete hardware monitoring chip (no voltages, no temperatures.)
The good side is that the driver should be relatively simple to write,
if anyone wants to take a chance.

You may try ACPI for the temperature (modprobe thermal, acpi -V).

-- 
Jean Delvare


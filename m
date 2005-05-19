From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Sensors detected, modules load, but nothing reported in sensors
Message-Id: <aKAw4GD8.1112949920.5898430.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <4255A7BA.1040007@ameritech.net>
In-Reply-To: <4255A7BA.1040007@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jeffery,

> I have an iWill Zmaxdp (dual opteron) on the Nforce3 250 Pro chipset.
>
> Running sensors-detect, I found the following chips/buses:
> eeprom
> i2c-isa
> i2c-nforce2
> w83627hf
> it87

It's very unlikely that you would need both it87 and w83627hf. One of
these has to be a misdetection.

> I had sensors-detect create my configuration files, and ran rc-update
> add lm_sensors default.  Here is my output from sensors-detect:
> Driver `it87' (may not be inserted):
>   Misdetects:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

Confirmed here. Do not load it87.

> Note that sensors-detect did not generate a module load for it87,

And quite rightly so, as it knew it was a misdetection.

> Any ideas?

Yes. Check /proc/ioports, see if something holds part of the 0x290-0x297
range. If there is something, try to recompile a kernel with
CONFIG_PNPACPI disabled. This is a known and reported problem waiting
for a solution:
  http://bugme.osdl.org/show_bug.cgi?id@14
The cause is IMHO a broken BIOS (or ACPI data thereof), so ideally the
motherboard manufacturers would fix their BIOS and the problem would go.
But I might be wrong.

--
Jean Delvare

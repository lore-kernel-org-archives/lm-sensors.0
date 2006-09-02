From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 07:12:39 +0000
Subject: [lm-sensors] Is the Intel i945G supported/planned?
Message-Id: <20060902091239.ad8c7826.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
In-Reply-To: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sunil,

> Ok, here it is, from the newer script:
> (...)
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): YES
> Probing for Super-I/O at 0x2e/0x2f
> Probing for `ITE IT8702F Sensors'...                        No (0x7901)
> Probing for `ITE IT8705F Sensors'...                        No (0x7901)
> Probing for `ITE IT8712F Sensors'...                        No (0x7901)
> Probing for `ITE IT8716F Sensors'...                        No (0x7901)
> Probing for `ITE IT8718F Sensors'...                        No (0x7901)
> Probing for `Nat. Semi. PC87351 Fan Sensors'...             No (0x79)
> Probing for `Nat. Semi. PC87360 Fan Sensors'...             No (0x79)
> Probing for `Nat. Semi. PC87363 Fan Sensors'...             No (0x79)
> Probing for `Nat. Semi. PC87364 Fan Sensors'...             No (0x79)
> Probing for `Nat. Semi. PC87365 Fan Sensors'...             No (0x79)
> Probing for `Nat. Semi. PC87365 Voltage Sensors'...         No (0x79)
> Probing for `Nat. Semi. PC87365 Thermal Sensors'...         No (0x79)
> Probing for `Nat. Semi. PC87366 Fan Sensors'...             No (0x79)
> Probing for `Nat. Semi. PC87366 Voltage Sensors'...         No (0x79)
> Probing for `Nat. Semi. PC87366 Thermal Sensors'...         No (0x79)
> Probing for `Nat. Semi. PC87372 Fan Sensors'...             No (0x79)
> Probing for `Nat. Semi. PC87373 Fan Sensors'...             No (0x79)
> Probing for `Nat. Semi. PC87591'...                         No (0x79)
> Probing for `Nat. Semi. PC87371'...                         No (0x79)
> Probing for `Nat. Semi. PC97371'...                         No (0x79)
> Probing for `Nat. Semi. PC8739x'...                         No (0x79)
> Probing for `Nat. Semi. PC8741x'...                         No (0x79)
> Probing for `Nat. Semi. PC87427 Fan Sensors'...             No (0x79)
> Probing for `Nat. Semi. PC87427 Health Sensors'...          No (0x79)
> Probing for `SMSC LPC47B27x Fan Sensors'...                 No (0x79)
> Probing for `SMSC LPC47M10x/13x Fan Sensors'...             No (0x79)
> Probing for `SMSC LPC47M14x Fan Sensors'...                 No (0x79)
> Probing for `SMSC LPC47M15x/192/997 Fan Sensors'...         No (0x79)
> Probing for `SMSC LPC47S42x Fan Sensors'...                 No (0x79)
> Probing for `SMSC LPC47S45x Fan Sensors'...                 No (0x79)
> Probing for `SMSC LPC47M172'...                             No (0x79)
> Probing for `SMSC LPC47B397-NC'...                          No (0x79)
> Probing for `SMSC SCH5307-NS'...                            No (0x79)
> Probing for `SMSC LPC47M584-NC'...                          No (0x79)
> Probing for `VIA VT1211 Sensors'...                         No
> Probing for `Winbond W83627EHF/EHG Sensors'...              No

You appear to have an unknown Super-I/O chip, presumably made by SMSC.
Could be a custom chip made by SMSC for Dell. Sometimes Super-I/O have
integrated hardware monitoring features. Without additional
information (like the name of the chip), there's not much we can do
though.

> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at e8a0'
>     Busdriver `i2c-i801', I2C address 0x50
>     Chip `eeprom' (confidence: 6)
>   * Bus `SMBus I801 adapter at e8a0'
>     Busdriver `i2c-i801', I2C address 0x52
>     Chip `eeprom' (confidence: 6)
> 
>   EEPROMs are *NOT* sensors! They are data storage chips commonly
>   found on memory modules (SPD), in monitors (EDID), or in some
>   laptops, for example.

> That's exactly what I had from the first ever run. I am not sure why
> subsequent runs refused to find any chip (A bug in older sensors-detect) but
> this is what it found the very first time and I had set it  up with these in

Either because the user pretended i2c-dev needn't be loaded (hum hum),
or because the eeprom driver was already loaded, and the user didn't
unload it in spite of the script asking for it.

I have since improved the script to gather information from already
loaded i2c chip drivers, hopefully this should make things better.

> /etc/conf.d/lm_sensors (gentoo diversion, /etc/init.d/lm_sensors reads it, I
> think) and /etc/modules.conf. Obviously, 'sensors' still comes out with 'No
> sensors found!' even when all the modules are loaded properly.

Quite rightly so, as EEPROMs aren't sensors, as the script kindly but
firmly reminded you above ;) Try "decode-dimms.pl" for decoded EEPROM
contents.

From another post:
> BIOS doesn't have any hardwar monitoring information. its a dell, what
> do ya expect...;-)

This is usually a good indication that there is no hardware monitoring
chip in the machine. You may try ACPI (modprobe thermal; acpi -t) as
your last hope.

-- 
Jean Delvare


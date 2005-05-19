From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Help me with VT82C586B
Message-Id: <NL4GLoSu.1111745054.5539110.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <14410443364.20050325100723@omskart.ru>
In-Reply-To: <14410443364.20050325100723@omskart.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Alexey,

Please CC: the mailing-list when replying.

> > What is your problem exactly?
>
> Where Temperature/FAN speed/Volts?

Not all motherboards have sensors, especially older ones, which seems to
be your case.

> Why 128, when I have 64Mb?

The value is read in the EEPROM of the memory module. Either the EEPROM
is bogus, or the module is really 128MB.

> How I can know what motherboard I have?

If even you don't know... ;) People are supposed to know what hardware
they are! Ask the person you got it from. Or open the case and take a
look, sometimes motherboards have their manufacturer and model written
down on them. Or look at what the BIOS displays when the machine boops.
You can also give a try to a tool named "dmidecode" [1], which might
tell you, providing your motherboard supports SMBIOS/DMI.

[1] http://www.nongnu.org/dmidecode/

> -----------------------------------------
> [skip]
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-via' for device 00:07.3: VIA Technologies VT82C586B Apollo
>    ACPI
> Probe succesfully concluded.
> [skip]
> Next adapter: VIA i2c
> Do you want to scan it? (YES/no/selectively):
> Client at address 0x51 can not be probed - unload all client drivers first!
> Client found at address 0x69
> [skip]
> Sorry, no chips were detected.
> Either your sensors are not supported, or they are
> connected to an I2C bus adapter that we do not support.
>-----------------------------------------

The bus drivers seems to be working OK, as it found two devices (eeprom
and clock). But no hardware monitoring chip. Your only hope is with ISA
chips. You did not include that section. What about it?

--
Jean Delvare

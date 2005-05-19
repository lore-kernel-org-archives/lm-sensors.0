From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: Addition to IBM whitelist
Message-Id: <1082033317.407e84a51008c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082027302.6117.9.camel@viper.cam.eu.citrix.com>
In-Reply-To: <1082027302.6117.9.camel@viper.cam.eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well looking at the log I find this :-
> 
> -----------------------------------
> 
> Client found at address 0x54
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x55
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x56
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x57
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Probing for `Sony Vaio EEPROM'... Failed!
> Client found at address 0x5c

Probably an AT24RF08 chip...

(In other words: I won't white-list your system, at least not now.
Sorry.)

> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x50
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x51
>     Chip `SPD EEPROM' (confidence: 8)
>   * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x52
>     Chip `SPD EEPROM' (confidence: 8)
>   * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x53
>     Chip `SPD EEPROM' (confidence: 8)
>   * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x54
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x55
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x56
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x57
>     Chip `SPD EEPROM' (confidence: 1)

Admittedly strange. Do you have 4 memory slots used out of 4 total?
Another possibility would be that this is a 24RF16 chip, but it doesn't
seem to even exist.

> I'm happy to test the adm1025 driver, I think this is actually the
> only one I was using under 2.4. I probably still have a 2.4 kernel
> around that I could boot into if that would help?

Well, the driver is supposed to work on 2.4 already, so what will need
testing is the 2.6 port once I am done with it.

I do have an evaluation board for the ADM1025 but it requires the same
power supply unit as my adsl router does, so I don't much like using it
;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

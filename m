From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Ticket 714
Message-Id: <3BEC5B23.942C00F7@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200111091109.FAA08820@buzzsaw.buzzsaw.net>
In-Reply-To: <200111091109.FAA08820@buzzsaw.buzzsaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You probably don't have any LM75's on the board, those devices
at 0x48 and 0x49 are parts of the w83782d. For some reason
our "alias detect" is not recognizing that.
See if not inserting the lm75 driver helps.

Rick F Nicholson wrote:
> 
> Did some more investigation. It appears that there are an lm75, an w83782d and
> the DIMM eeproms on the bus. The relevent output of "sensors-detect" is as follows:
> 
> Next adapter: SMBus vt82c596 adapter at 5000 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x00
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x2d
> Probing for `Myson MTP008'... Failed!
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `National Semiconductor LM87'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
> Probing for `Genesys Logic GL520SM'... Failed!
> Probing for `Genesys Logic GL525SM'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Failed!
> Probing for `Analog Devices ADM1025'... Failed!
> Probing for `Analog Devices ADM1024'... Failed!
> Probing for `Analog Devices ADM1022'... Failed!
> Probing for `Texas Instruments THMC50'... Failed!
> Client found at address 0x30
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x31
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x32
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x33
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x48
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Success!
>     (confidence 3, driver `lm75')
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Client found at address 0x49
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Success!
>     (confidence 3, driver `lm75')
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Success!
>     (confidence 3, driver `ds1621')
> Client found at address 0x50
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> ed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 8, driver `eeprom')
> Probing for `DDC monitor'... Failed!
> Client found at address 0x51
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x52
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x53
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x69
> 
>  Some chips are also accessible through the ISA bus. ISA probes are
>  typically a bit more dangerous, as we have to write to I/O ports to do
>  this.  Do you want to scan the ISA bus? (YES/no):
> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
>   Trying address 0x0290... Success!
>     (confidence 8, driver `w83781d')
> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83697HF'
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT 82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
> 
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue:
> 
> Driver `lm75' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus vt82c596 adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x48
>     Chip `National Semiconductor LM75' (confidence: 3)
>   * Bus `SMBus vt82c596 adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x49
>     Chip `National Semiconductor LM75' (confidence: 3)
> 
> Driver `ds1621' (may not be inserted):
>   Misdetects:
>   * Bus `SMBus vt82c596 adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x49
>     Chip `Dallas Semiconductor DS1621' (confidence: 3)
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus vt82c596 adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x50
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
>   * Bus `SMBus vt82c596 adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x51
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
>   * Bus `SMBus vt82c596 adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x52
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
>   * Bus `SMBus vt82c596 adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x53
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
> 
> Driver `w83781d' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83782D' (confidence: 8)
> 
> The output of "sensors" is as follows:
> 
> sensors
> w83782d-i2c-0-2d
> Adapter: SMBus vt82c596 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.76 V  (min =  +1.53 V, max =  +1.85 V)
> VCore 2:   +1.47 V  (min =  +1.53 V, max =  +4.08 V)
> +3.3V:     +3.31 V  (min =  +2.97 V, max =  +3.63 V)
> +5V:       +5.11 V  (min =  +4.50 V, max =  +6.85 V)
> +12V:     +11.59 V  (min = +10.79 V, max = +13.11 V)
> -12V:      -5.30 V  (min = -13.21 V, max = -10.90 V)
> -5V:       -1.59 V  (min =  -5.51 V, max =  +5.10 V)
> V5SB:      +4.23 V  (min =  +4.50 V, max =  +5.48 V)
> VBat:      +3.07 V  (min =  +2.70 V, max =  +3.29 V)
> fan1:        0 RPM  (min = 3000 RPM, div = 2)
> fan2:     5314 RPM  (min = 3000 RPM, div = 2)
> fan3:        0 RPM  (min = 3000 RPM, div = 2)
> temp1:     -48.0<B0>C  (limit =  +60<B0>C, hysteresis =  +50<B0>C) sensor = thermist
> or
> temp2:       +28<B0>C  (limit =  +60<B0>C, hysteresis =  +50<B0>C) sensor = PII/Cele
> ron diode
> temp3:       +28<B0>C  (limit =  +60<B0>C, hysteresis =  +50<B0>C) sensor = PII/Cele
> ron diode
> vid:      +1.70 V
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm disabled
> 
> eeprom-i2c-0-50
> Adapter: SMBus vt82c596 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        512
> 
> eeprom-i2c-0-51
> Adapter: SMBus vt82c596 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        512
> 
> eeprom-i2c-0-52
> Adapter: SMBus vt82c596 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        512
> 
> eeprom-i2c-0-53
> Adapter: SMBus vt82c596 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        512
> 
> Answering the questioins:
> After a collision are the readings bad forever or does it fix itself?
> Lasts forever.
> 
> Does removing and reloading either w83781d or i2c-viapro module fix the problem?
> No. Removing and reloading either doesn't fix the problem. Sometimes reloading
> w83781d, the w83782d is either not detected, the bus collides or it loads fine.
> 
> What else is on the bus, if anything?
> As far as I can tell, an lm75, the DIMM's eeprom and the w83782d are on the i2c bus.
> 
> Then tried running i2cdump 0 0. When I access something above address 0x2d, the
> onboard ethernet immediately stops working.  It's an i82559. I'll have to dig into
> the data sheet to see if it has an i2c connection.
> 
> rfn

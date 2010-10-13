From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Date: Wed, 13 Oct 2010 15:02:17 +0000
Subject: Re: [lm-sensors] Detection of W83L771AWG/ASG in lm90
Message-Id: <201010131702.18450.alexander.stein@informatik.tu-chemnitz.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
In-Reply-To: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

On Wednesday 13 October 2010, 15:57:41 you wrote:
> On Wed, 13 Oct 2010 15:40:18 +0200, Alexander Stein wrote:
> > 'sensors-detect' shows me there is W83L771W/G on my board:
> > > Probing for `Winbond W83L771W/G'...                         Success!
> > > 
> > >     (confidence 6, driver `to-be-written')
> > 
> > According to this wiki page http://www.lm-sensors.org/wiki/Devices
> > support should be handles by the lm90 driver. But after loading the lm90
> > driver, 'sensors' doesn't show any new device. Also loading the driver
> > by the alias "i2c:w83l771" doesn't help. Oh, i nearly forgot, I'm
> > running 2.6.34-gentoo- r11.
> > Any comments/suggestions?
> 
> Which I2C adapter is your W83L771W/G sitting on? The sensors-detect
> script will probe any adapter, however the lm90 driver can only
> auto-detect devices on I2C adapters which have properly set their class
> to I2C_CLASS_HWMON.

Here is a part from my sensors-detect output:
> Using driver `i2c-nforce2' for device 0000:00:01.1: nVidia Corporation
> nForce SMBus (MCP61)
> 
> Next adapter: SMBus nForce2 adapter at 5000 (i2c-0)
> Do you want to scan it? (yes/NO/selectively): yes
> Client found at address 0x4c
> Probing for `National Semiconductor LM75'...                No
> Probing for `Dallas Semiconductor DS75'...                  No
> Probing for `Analog Devices ADT7466'...                     No
> Probing for `Andigilog aSC7511'...                          No
> Probing for `Dallas Semiconductor DS1621/DS1631'...         No
> Probing for `Analog Devices ADM1021'...                     No
> Probing for `Analog Devices ADM1021A/ADM1023'...            No
> Probing for `Maxim MAX1617'...                              No
> Probing for `Maxim MAX1617A'...                             No
> Probing for `Maxim MAX1668'...                              No
> Probing for `Maxim MAX1805'...                              No
> Probing for `Maxim MAX1989'...                              No
> Probing for `Maxim MAX6655/MAX6656'...                      No
> Probing for `TI THMC10'...                                  No
> Probing for `National Semiconductor LM84'...                No
> Probing for `Genesys Logic GL523SM'...                      No
> Probing for `Onsemi MC1066'...                              No
> Probing for `Maxim MAX1618'...                              No
> Probing for `Maxim MAX1619'...                              No
> Probing for `National Semiconductor LM82/LM83'...           No
> Probing for `National Semiconductor LM90'...                No
> Probing for `National Semiconductor LM89/LM99'...           No
> Probing for `National Semiconductor LM86'...                No
> Probing for `Analog Devices ADM1032'...                     No
> Probing for `Maxim MAX6654/MAX6690'...                      No
> Probing for `Maxim MAX6657/MAX6658/MAX6659'...              No
> Probing for `Maxim MAX6648/MAX6649/MAX6692'...              No
> Probing for `Maxim MAX6680/MAX6681'...                      No
> Probing for `Winbond W83L771W/G'...                         Success!
> 
>     (confidence 6, driver `to-be-written')
> 
> Probing for `Winbond W83L771AWG/ASG'...                     No
> Probing for `Texas Instruments TMP401'...                   No
> Probing for `Texas Instruments TMP411'...                   No
> Probing for `Texas Instruments TMP421'...                   No
> Probing for `Texas Instruments TMP422'...                   No
> Probing for `Texas Instruments TMP423'...                   No
> Probing for `Texas Instruments AMC6821'...                  No
> Probing for `National Semiconductor LM63'...                No
> Probing for `Fintek F75363SG'...                            No
> Probing for `National Semiconductor LM73'...                No
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> Probing for `Analog Devices ADT7461'...                     No
> Probing for `Analog Devices ADT7481'...                     No
> Probing for `Fintek F75383S/M'...                           No
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
> 
>     (confidence 8, not a hardware monitoring chip)
> 
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
> 
>     (confidence 8, not a hardware monitoring chip)
> 
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
> 
>     (confidence 8, not a hardware monitoring chip)
> 
> Client found at address 0x53
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
> 
>     (confidence 8, not a hardware monitoring chip)

So it seems, it's the i2c-nforce2 driver for a SMBus nForce2 adapter. From a 
short grep in i2c-nforce2.c it seems that I2C_CLASS_HWMON is passed to the 
supported flags. Anyway, how can I name the exact device to be used by lm90?

Best regards,
Alexander

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

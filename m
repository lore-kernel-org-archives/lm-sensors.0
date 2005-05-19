From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: LM83 test results
Message-Id: <20030806122107.6d678b30.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Some good news.
> I have successfully tried the lm_sensors with the LM83 chip!
> I used a SBSP014 board that has an LM83 sensor attached to a
> ServerWorks CSB5 chipset's SMbus, on address 32h/33h. 

This is a really great news. You're the messiah I've been waiting for
for weeks now ;)

> Following is the sensor detect log and sensor output if interesting?

Of course it is. The detection works as intended. Just FMI, are you
using 2.8.0 or CVS?

You seem to have many, many chips on your I2C bus, some of which aren't
recognized by sensors-detect. I'd be interested in the following command
output:
  i2cdetect 0

Warning! This command, and others I could tell you I'm interested in,
are possibly dangerous, especially if your hardware was made by IBM, or
if your memory chips are from IBM. If your system is 3-5 years old, you
should be careful too.

So, whenever I say "I'm interested in something" you are free to do it
or not. I won't blame you if you don't. These are things I would do on
my machines because they are not production servers so I don't really
mind breaking them (I never breaked anything actually). But if your
system has some real use and you couldn't afford replacing it or part of
it, don't do the dangerous parts.

Back to the i2cdetect command above, I think it does approximately the
same as sensors-detect does, so it should be OK if your system survived
sensors-detect.

> # sensors -s
> # prog/sensors/sensors
> lm83-i2c-0-19
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> temp1:       +36?C  (limit = +127?C)                      
> temp2:       +35?C  (limit = +127?C)                      
> temp3:       +35?C  (limit = +127?C)                      
> temp4:       +35?C  (limit = +127?C)                      

Is it a SMP system? Any idea what the four different temperatures are
for? (A look at the BIOS setup screen could help.)

I'd be interested in the following command output:
  i2cdump 0 0x19

This will dump all the LM83's registers so I can take a deeper look, and
confirm or infirm some details that were not clear in the datasheet.
This command isn't dangerous IMHO, since the chipset at 0x19 really has
to be a LM83 or compatible.

Also, the LM83 driver is not completed. If you plan to use it and help
me testing it, I'll finish it for you, and possibly port it to Linux 2.6
too.

> eeprom-i2c-0-50
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> Memory size (MB):       256
>  
> eeprom-i2c-0-51
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> Memory size (MB):       256
>  
> eeprom-i2c-0-52
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> Memory size (MB):       256
>  
> eeprom-i2c-0-53
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> Memory size (MB):       256

Are these four entries correct? Do you have 4 SDRAM memory modules of
256MB each?

> eeprom-i2c-0-54
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>  
> eeprom-i2c-0-55
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>  
> eeprom-i2c-0-56
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>  
> eeprom-i2c-0-57
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter

Could that be 4 other empty memory slots?

I'd suggest you do *not* play too much with eeproms on your system.
i2c-piix4 + eeprom is the killing combo for IBM Thinkpads, and your
system has a strange behavior there (for example your eeproms have
invalid checksums, although the eeproms seem to contain correct values,
at first sight). Since I'm insanely curious, I'd love to dig into that,
but unless you explicitely ask me to do so, we won't.

Thanks a lot for your report!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

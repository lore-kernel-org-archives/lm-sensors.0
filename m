From: delvare@free.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Some informations about issues with the VIA Chipsets
Message-Id: <20030121180328.1b99106f.delvare@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301211738.34926.aurelien@ap2c.com>
In-Reply-To: <200301211738.34926.aurelien@ap2c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> When i launche sensors-detect, your program found that :
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus Via Pro adapter at 0500' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x52
>     Chip `Serial EEPROM' (confidence: 8)
> 
> Driver `it87' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)
> 
> But after that, when i launche the program sensors, it says me that it
> doesn't found any sensors. I don't understand anything.
> It is because these sensors are not implemented or it is a bug in your
> program ?
> I'm waiting your answer as soon as possible

Maybe it is just a bug in you (mis)reading the instructions. After
running sensors-detect, you are supposed to *load* the recommended
modules. Sensors-detect won't do it for you, nor will sensors itself.
So, try the following:
  modprobe it87
  modprobe eeprom (optional)
  sensors -s
  sensors
And you should see what you were expecting.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

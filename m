From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: missing sensor readings
Message-Id: <20030715231428.77309140.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <6A5ECC095A43E94180D288C357027544ABEA2E@cvexch01.atitech.com>
In-Reply-To: <6A5ECC095A43E94180D288C357027544ABEA2E@cvexch01.atitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> The temperature readings seems to be missing.  I talked to IBM and
> they couldn't tell me what sensors are on their motherboard.  The
> motherboard of that machine is custom made for that server so there is
> no motherboard model.  Attached are the readings I get by running
> sensors-detect, lsmod, i2cdetect and i2cdump.

First, do not send us Word documents again. We want raw text files.

Second, which version of lm_sensors are you using? I highly recommend
you use the latest one (2.8.0). Don't forget to install i2c-2.8.0 right
before. I would like to see the output of sensors-detect with this
version.

The way you ran i2cdetect and i2cdump wasn't very useful. You need to
unload all chip drivers first (in your case, do "rmmod eeprom"). Then,
run "i2cdetect 0". It will show which addresses are responsive on your
I2C bus. Then for each address where something has been detected, do
"i2cdump 0 0x50", where you replace 50 with the actual addresses. Don't
try 0x00 nor 0x69.

This will help us determine which kind of devices you do have. However,
the addresses you first sent do not sound like sensors, as Philip
Edelbrock said. 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

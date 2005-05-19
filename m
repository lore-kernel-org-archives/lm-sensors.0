From: delvare@ensicaen.ismra.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: eeprom driver
Message-Id: <Pine.GSO.4.40.0202061144150.12355-100000@e450.ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> BTW- If it saves effort, you could access the eeprom's more directly
> through the /dev/i2c* interface.  You wouldn't be dependant on the
> eeprom module that way, although you would need to be careful not to
> accidentially write data to the eeprom.  See prog/dump/i2c-dump.c for
> an example, and then look at the eeprom.c driver for the i2c sequence
> to read a value from eeprom (it's a write [to set the address pointer
> in eeprom memory] followed by a read, I think).

I certainly won't.  If we are to access the device directly, then it
wouldn't make sense to have a driver.  Anyway, my script is ready and
works with the current proc filenames, and it won't be hard to switch to
another naming scheme if required.

-- 
       /~~       Jean "Khali" Delvare
  -----\_                        mail: delvare@ensicaen.ismra.fr
 --------\                http://www.ensicaen.ismra.fr/~delvare/
---=ISMRA/- ____________________________________________________

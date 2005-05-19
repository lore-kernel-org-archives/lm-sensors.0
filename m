From: Manish_Lachwani@pmc-sierra.com (Manish Lachwani)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: i2c-yosemite
Message-Id: <9DFF23E1E33391449FDC324526D1F25902253276@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040222104106.714de992.khali@linux-fr.org>
In-Reply-To: <20040222104106.714de992.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'LM Sensors' <sensors@stimpy.netroedge.com>, 'LKML' <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>

Hi Jean

Couple of things. First of all, I did not have an idea that a driver existed for Atmel 24C32 EEPROM. In case of the Yosemite chip, the MAC address of the Gigabit subsystem is stored in the EEPROM. It needs to be fetched by the Gige driver using the I2C protocol. I could not find the driver in the 2.4 tree and hence wrote one for the yosemite. I could use the existing driver, which would make sense. 

Secondly, the reason why I mentioned:

"Currently, this Linux driver wont be integrated into the generic Linux
I2C framework."

is because at the time the driver was written, the chip did not exist. The idea was that once the chip is released and the driver tested, it could be checked in the generic i2c framework along with the driver for the MAX 1619 sensors chip. Now that the drivers already exist, I will use them instead. 

Thanks
Manish

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Sunday, February 22, 2004 1:41 AM
To: Manish Lachwani
Cc: LM Sensors; LKML; Greg KH
Subject: i2c-yosemite


Hi Manish,

I saw that there is a new driver named i2c-yosemite in Linux 2.6.3-mm2.
Quoting your words in the header:

"Currently, this Linux driver wont be integrated into the generic Linux
I2C framework."

Why that?

If everyone reimplements what already exists, the kernel is likely to go
bigger with no benefit. Also, you won't be able to use all user-space
tools that already exist, and will also have to write specific chip
drivers for the chips present on the yosemite bus, although these
drivers (Atmel 24C32 EEPROM and MAX 1619) already exist.

Please explain to us why you cannot/don't want to use the existing i2c
subsystem.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

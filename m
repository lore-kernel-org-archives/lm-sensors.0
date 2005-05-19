From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: i2c-yosemite
Message-Id: <20040223202420.33c25164.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9DFF23E1E33391449FDC324526D1F25902253276@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <9DFF23E1E33391449FDC324526D1F25902253276@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manish Lachwani <Manish_Lachwani@pmc-sierra.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, greg@kroah.com

> Couple of things. First of all, I did not have an idea that a driver
> existed for Atmel 24C32 EEPROM.

Actually, I read you a bit fast. I think our driver only supports 24C02
and 24C04, because 24C08 and bigger require 2-byte addressing.

> In case of the Yosemite chip, the MAC address of the Gigabit
> subsystem is stored in the EEPROM. It needs to be fetched by the Gige
> driver using the I2C protocol.

I didn't know about that. Funnily enough, a user reported today about a
strange EEPROM on his I2C bus, and it turns out that it holds a MAC
address (or at least it really looks like that).

> I could not find the driver in the 2.4 tree and hence wrote one for
> the yosemite. I could use the existing driver, which would make
> sense. 

The driver wasn't part of Linux 2.4 itself, because the lm_sensors
drivers were never integrated there. But they are in 2.6.

> The idea was that once the chip is released and the driver tested, it
> could be checked in the generic i2c framework along with the driver
> for the MAX 1619 sensors chip. Now that the drivers already exist, I
> will use them instead.

Aha, I read a bit too fast here too :/ We support the MAX1617(A), not
the MAX1619. That said, I took a look at the datasheet and the chips are
said to be very similar, so extending the driver should be quite
straightforward.

Anyway, the point isn't wether the exact drivers already exist or not.
The point is that using the existing i2c subsystem means that other
people needing support for similar chips will be able to use the same
drivers as you. This also means that all existing user-space tools will
work out-of-the-box, which is a great benefit IMHO.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

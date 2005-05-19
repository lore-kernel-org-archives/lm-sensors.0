From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Trying to find device chrontel 7009
Message-Id: <20031105222244.594bfe49.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031105203334.6eab5b78.khali@linux-fr.org>
In-Reply-To: <20031105203334.6eab5b78.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I downloaded the 7009's data sheet and it happens that is not
> > designed for the I2C interface. Why did you think you would find it
> > here? To me, it's obvious it can't be there. You have to look for it
> > somewhere else.
> 
> I would be so sorry if this is the truth. So I wasted your time. Here
> is the sentence I concluded that it could be connected to i2c:
> 
> 6. Register Control
> The CH7009 is controlled via a serial port. The serial port bus uses
> only the SPC clock to latch data into registers, and does not use any
> internally generated clocks so that the device can be written to in
> all power down modes. The device retains all register states.
> 
> I somehow thought, because its a synchonous serial bus, it could be a
> i2c.

Yes, that's somewhat similar to I2C, but the datasheets shows that the
data bus is 12-bit wide, while I2C's is 1-bit only. I even wonder how
they can call that a serial bus. Anyway, that's what made me say it's
not an I2C chip (plus the fact that searching the data sheet for I2C or
SMBus returned nothing).

> Sorry that I wasted so much time of you,

No problem. Good luck :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

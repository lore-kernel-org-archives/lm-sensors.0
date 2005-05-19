From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Trying to find device chrontel 7009
Message-Id: <20031106190430.080a9fcf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031105203334.6eab5b78.khali@linux-fr.org>
In-Reply-To: <20031105203334.6eab5b78.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Yes, that's somewhat similar to I2C, but the datasheets shows that
> > the data bus is 12-bit wide, while I2C's is 1-bit only. I even
> > wonder how they can call that a serial bus. Anyway, that's what made
> > me say it's not an I2C chip (plus the fact that searching the data
> > sheet for I2C or SMBus returned nothing).
> 
> What you meant is the data bus for video data transmission. control
> interface is a two wire synchronous serial connection. It's just a
> very simple bitshift module driven by external clock (SPC and SPD pin
> 14, 15).

Oh, OK. Thanks for the clarification. You see, I did not read the data
sheet more carefully than you after all ;) Seen from that point of view,
it could clearly have been connected to the I2C bus. Still we did not
see it, so it is either hiding, or elsewhere. Maybe you could get some
info from Chrontel and/or Intel?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

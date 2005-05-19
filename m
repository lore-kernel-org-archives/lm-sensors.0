From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <1082127629.407ff50d8b5c6@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > The only side effect I can think off is that it would increase the
> > address pointer for chips in autoincrement mode, but that's about
> > all and it doesn't seem to hurt, really.
> 
> At least with i2c you can even do zero-length reads, i.e. just send
> the read address and watch whenever someone acks it or not, without
> actually reading data.  Not sure whenever that is true for smbus as
> well.

This is exactly a SMBus "quick command" with data bit 1, if I understood
it correctly. This isn't what we do (we do "quick command" with data
bit 0), but that's my second choice if it turns out that "receive byte"
isn't possible as a probing command.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

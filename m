From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: I2C 2.1 support for High Speed I2C, 3.4 Mb/s
Message-Id: <71555548814716479478431542AA5F8A01B1B7D3@dlee2k04.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <71555548814716479478431542AA5F8A0276739C@dlee2k04.ent.ti.com>
In-Reply-To: <71555548814716479478431542AA5F8A0276739C@dlee2k04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello Mark,
 
> I don't think anybody's ever asked us about it, much less worked on
it.
> Looks like HS mode was defined in I2C V2.0 in 1998.

That's what I thought.

> Would you be working on a bit-banging driver or is here an I2C bus
master
> out there supporting HS mode?

Bus master.

> If you are going to write a driver please keep in touch and let us
know
> how it's going and what API extensions you propose.

I didn't think much on it.  Off the top of my head, I though client chip
drivers could advertise an attribute which indicates if they are hs-mode
capable.  If the bus master supports hs-mode and the client advertises
itself capable, then the master would just do it for transactions larger
than some number X.  After the lower speed setup phase is done, data can
be sent at max speed between hs targets even on a bus with slow devices.

> If a bit-banger big desision is to mod and/or start from i2c-algo-bit
or
> i2c-algo-biths.
> algo-bit is 33% duty cycle, biths is 50% duty cycle and in theory can
> go faster. However i2c spec says HS mode is 33% duty cycle. Go figure.
> See TODO for more info.

I wonder what rate a bit banging interface can achieve...

Regards,
Richard W.

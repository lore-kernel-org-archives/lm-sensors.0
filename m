From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 10 Sep 2006 17:48:14 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems w/
Message-Id: <20060910194814.d6687a4e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Matthias,

> > > I tried it, no success :\ I still only get 4 fans.
> > 
> > Odd. Did "isaset" complain about failed readback?
> 
> Err now that you mention it heh.
> 
> > The easiest way to make sure is:
> > 
> > isadump -y 0x295 0x296
> > isaset -y 0x295 0x296 0x47 0xf5
> > isadump -y 0x295 0x296
> > 
> > The value of register 0x47 should change in the second dump.
> 
> I'm indeed getting an error from isaset: 
> "Data mismatch, wrote 0xf5, read 0xf4 back."
> 
> I just tried again to be sure.

Odd, this register is supposed to be writable. Can you please try other
values (e.g. 0xa4) to see if other bits in the register can be written?

You may also try writing to register 0x48, we don't care about the
value there and it'll be an interesting test.

Pin 58 is shared between two functions, SI and AUXFANIN1. Your problem
might have something to do with this, but I can't find information
about function selection for this pin in the datasheet.

David, any idea?

-- 
Jean Delvare


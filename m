From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Adapter driver for opencores I2C fpga
Message-Id: <20030823213603.12449f47.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440224B33D@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440224B33D@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've just upgraded to version 2.8 of the I2C code, and have written 
> algorithm/adapter drivers for that interface. The driver does not yet
> support everything that the verilog core is capabale of, but does do 
> enough to support the devices we have on the card (LM83, MAX6550,
> EEPROM). 
> 
> Since most of the hard work is done by the verilog the drivers are
> quite simple. I've implemented them following the "bit" model, with an
> algorithm driver to do the transfers and adapter drivers to provide
> access to the registers implemented in the chip (all these do is hide
> the register addresses and widths), so it should be easily portable to
> new cards that use the same verilog.
> 
> Is this of interest?

Yes, I think it's of interest, as long as at least one other user around
the world will be able to use your driver (but I'm not the authority wrt
that topic).

I'd like you to tell me if the LM83 driver works OK for you. It has been
only slightly tested so far.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

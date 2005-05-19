From: stefano@codesink.org (Stefano Barbato)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: EEPROM read/write user space program
Message-Id: <200311282127.35985.stefano@codesink.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031122084059.0f9f73fa.khali@linux-fr.org>
In-Reply-To: <20031122084059.0f9f73fa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I could also change in "your system will brake, very very VERY much" :)

I think that defaulting to 8bit makes sense, I agree with you. It will be more 
safer or, better, less devastating. Reading from a 16bit using 8bit will just 
confuse the eeprom that can return wrong values (usually 0xff). Writing just 
don't work or at least not on eeproms I used for testing.

So I'll change to 16bit default as soon as possible (and I'll add a -16 
switch).

I was trying to figure out if there's a non-euristic mode to detect the eeprom 
type without writing to it but, before trying, I want to buy a new 8bit 
eeprom because I don't want to play with my dimm spd (that btw is not write 
protected)!

I'll let you know.

Thanks for the proofreading work :)

stefano


On Friday 28 November 2003 19:23, you wrote:
> > __________________________________WARNING____________________________
> > ___ Erroneously writing to a system EEPROM (like DIMM SPD modules) can
> > brake your system.  It will NOT boot any more so you'll not be able to
> > fix it.
>
> It's "break", not "brake" (also in some way I agree it does too ;)).
> And "any more" is "anymore".
>
> > Reading from 8bit EEPROMs (like that in your DIMM) without using the
> > -8 switch can also UNEXPECTEDLY write to them, so be sure to use the
> > -8 command param when required.
>
> Wouldn't it be safer to default to 8-bit and have a switch to use
> 16-bit addressing? From what you said, "reading from an 8bit eeprom
> using 16bit addressing can actually *write* to the eeprom", but what
> would reading a 16-bit eeprom using 8-bit addressing do? If it isn't
> dangerous, I believe you should default to 8-bit addressing.
>
> BTW, isn't it possible to detect the addressing mode?

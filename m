From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [RESEND3] Dallas 1-wire protocol implementation.
Message-Id: <20040607222430.1e52df2b@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1086602640.7694.71.camel@uganda>
In-Reply-To: <1086602640.7694.71.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Jun 2004 17:19:37 +0200
Aurelien Jarno <aurelien@aurel32.net> wrote:

> Hi Evgeniy!
> 
> I have quickly looked through your patch, and it seems your
> implementation only support 1 wire adapters in bit mode, ie the data
> line is drived by the driver.
> 
> I own a 1 wire <-> USB bridge built using a DS2490 chip from Dallas.
> It drivew directly the 1 wire bus, so you just have to send it
> "medium" level commands such as "Match access", "Search access",
> "Block I/O","Write EEPROM", etc.
> 
> It would be good if your patch has a preliminary support for this type
> of adapters, I mean I think it would be better to move all bit
> functions into a separate file called w1-algo-bit.c, just like for the
> I2C bus.
> 
> BTW, I would like to write a driver for the DS2490, but I don't really
> have the time by now. Maybe latter.

I think it is definitely a good idea.
I will think about design and try to create new weekly-resend-patchset
with this feature implemented.

Thank you.


> Bye,
> Aurelien

> -- 
>   .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
>  : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
>  `. `'   aurel32@debian.org         | aurelien@aurel32.net
>    `-    people.debian.org/~aurel32 | www.aurel32.net


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt

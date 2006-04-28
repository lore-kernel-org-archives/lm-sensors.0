From: tandrews@grok.co.za (Thomas Andrews)
Date: Fri, 28 Apr 2006 12:24:26 +0000
Subject: [lm-sensors] making a geode i2c slave driver
Message-Id: <20060428122426.GD14420@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427092159.GA27959@grok.co.za>
In-Reply-To: <20060427092159.GA27959@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Fri, Apr 28, 2006 at 01:03:19PM +0200, Jean Delvare wrote:

> > I hope you don't mind the imposition, Jean Delvare (khali on
> > #linux-sensors) suggested I contact you about a geode driver that I need
> > to write. (He said you wanted to do something similar a while back.)
> 
> That was Rudolf Marek who did, actually.

My humble appologies! I got my wires crossed. :p
 
[...]

> > The driver that I wrote for the Atmel is basically a vanilla sensor
> > driver. (...)
> 
> How does a microcontroller qualify as a sensor? And what do you mean
> with "vanilla"?

It doesn't qualify, and it isn't intended to stay that way, but as a
beginner, I found it to be the simplest way to get my hardware to be
seen. I made my micro behave for the time being like a temperature
sensor would do. By vanilla, I really just meant simple.

When I've figured out the correct way to do it, I'll implement it. Any
hints or advice in this regard would be most welcome!
 
> I will merge the following documentation update for the scx200_acb
> driver, comments welcome.

Thanks. I figured the base address stuff out myself, so I think it would
be a good idea if the next person doesn't have to do so too. As an
aside, the old driver that I used had a method to find the base
addresses out by itself. It worked for me. Do you think it makes sense
to merge that functionality into the new driver? I posted an excerpt to
the list in another thread earlier today. I'm happy to make the patch,
but I'll need someone to test the 1200 family...

Thanks for the help!
Thomas


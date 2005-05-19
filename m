From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: 2.4.22 kernel patches available
Message-Id: <3F523D32.7080304@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030831172730.775fb950.khali@linux-fr.org>
In-Reply-To: <20030831172730.775fb950.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On sybyte and max1617 we should try and find the authors and bring them into the fold.

On you moving on, hopefully you can find 1-2 hours a week for us which would
still qualify you as "active"! We've appreciated your energy and enthusiasm
(and new ideas) over the recent months, especially as it came when
I was running out of all of those...

Any proposal for how to proceed with the 2.4 patch?
Without you to generate a 2.8.1->2.4.23 patch, what should we do?


And if you don't mind, what are you going to be doing for a living?

thanks again
mds

Jean Delvare wrote:
> Hi all,
> 
> I just finished updating my installation guide to support the new 2.4.22
> kernel.
> 
> I noticed that new I2C drivers exist there: i2c-sibyte (plus
> i2c-algo-sibyte) and i2c-max1617. Why they end up there without us even
> hearing about it is a complete mystery to me. The max1617 driver is
> crappy (polling + working only with the sibyte bus) and completely
> useless since we already support that chip for years. The bus driver
> probably should have been built into a single module. And none of these
> modules will even compile since they use I2C IDs that are not defined.
> 
> My 2.4.22 patch simply wipe them out. I can't understand how they were
> accepted into the main kernel tree. I couldn't find anything related to
> them in the kernel changelog nor in LKML archives. I feel like we should
> complain about that, but unfortunately I don't have time for that right
> now. Greg, you have more contact with the kernel people than any of us
> here, do you have any information we don't have?
> 
> I am taking a new (well...) job tomorrow. At last :) I'm more than
> pleased, but you have to understand that this also means the end of my
> active participation to the LM Sensors project. Don't worry, I won't
> leave the project completely and within a few months I hope I'll have
> some time left again to contribute. But I won't spend 6 hours a day on
> it as it has been the case for the last few months. BTW, I'd like to
> thank you all very much for that. I've learned much here, and it also
> prevented me from falling into the laziness :)
> 
> See you later.
> 

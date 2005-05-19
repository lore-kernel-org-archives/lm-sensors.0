From: jdrew@somanetworks.com (Joe Drew)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: piix4 fails to reset? (ticket #1078)
Message-Id: <1040393595.1738.219.camel@albatross.yyz.somanetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1040328325.1738.165.camel@albatross.yyz.somanetworks.com>
In-Reply-To: <1040328325.1738.165.camel@albatross.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2002-12-20 at 00:47, Ky?sti M?lkki wrote:
> On Thu, 19 Dec 2002, Mark D. Studebaker wrote:
> 
> > If you have an idea about fixing it then if you post or check
> > in a patch there's lots of folks with piix4's that could test it,
> > at lest to see that it didn't break anything...
> 
> Attached. At least it compiles...
> So it retries host busy condition 5 times with 10 ms delay before
> it goes for Start. On a transaction timeout, it tries to release host
> using the KILL flag.

I can't speak to how this would affect long-term reliability, but in an
attempt to un-crap the SMBus on this card, I've tried adding the KILL
flag bit to before the host busy wait in piix4_transaction().
Unfortunately, it doesn't work - I get "KILL failed."

What seems especially strange is that for absolutely every transaction,
the SMBus returns 01. In addition, when the sensor modules were running,
they returned all (binary) ones in values, too. Is that a common
occurrence when the bus is locked up?

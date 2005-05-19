From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: W83791
Message-Id: <3D1A7A9C.DFF40F97@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.31.0206250045030.14052-100000@klaus.dns2go.com>
In-Reply-To: <Pine.LNX.4.31.0206250045030.14052-100000@klaus.dns2go.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

rats about the 8708 - maybe you can get a datasheet out of ITE.

when you have something for the 791 send it along.
Be sure and make your changes to CVS version.

If you're brave, use i2c from CVS, then load smbus-arp from
lm-sensors CVS and see what it says in dmesg.
It should assign an address to the 791.

Klaus Woltereck wrote:
> 
> On Mon, 24 Jun 2002, Mark Studebaker wrote:
> 
> > If you have a board with a 791 on it that would be great - let us know.
> 
> Yes, its a P4B533E.
> 
> The problem with this board is, that the fans seem to be connected to the
> IT8708F(MegaIO w/ LPC interface) - no docs, no addresses, no RPM readings
> :-(
> 
> > As the 791 has SMBus 2.0 support (which I'm working on in i2c-core, etc.)
> > there are some interesting things we can test.
> 
> Feel free to ask...
> 
> Bye,
> Klaus

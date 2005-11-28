From: n4phth4@yahoo.com (Keith)
Date: Mon, 28 Nov 2005 17:14:15 +0000
Subject: [Fwd: Re: [lm-sensors] Kernel hangs with i2c-i801 driver?]
Message-Id: <20051128161338.99653.qmail@web32612.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051126073613.GG26906@oden.homeip.net>
In-Reply-To: <20051126073613.GG26906@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- Daniel Nilsson <daniel.n.nilsson@home.se> wrote:

> On Sun, Nov 27, 2005 at 12:31:22PM +0100, Daniel
> Nilsson wrote:
> > I was finally able to get into a situation where I
> can reproduce the
> > hang in a repeatable fashion. I'm using this

...

I did some similar testing (writing values manually)
and was not able to make the box lock up until I
mistakenly wrote too small a value to vrm (at least I
think that's what did it); the box chugged along fine
until I started doing some work and it choked.  But
again I'm pretty sure it was my fault; after reboot
the BIOS complained about a previous voltage failure.
:)

I'm now at the point of assuming it was too tight of a
temperature range in the default sensors.conf.  With
temp1_min/max at 10-80 and temp2/temp3 at 10-50 I've
run sensors -s multiple times with no lockup.  I've
not changed anything else.

I still have fan readings of zero -- and it's not a
divisor problem considering there are no fan*_div
files in sysfs -- but this is another problem...

Keith




		
__________________________________________
Yahoo! DSL ? Something to write home about.
Just $16.99/mo. or less.
dsl.yahoo.com


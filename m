From: adobriyan@mail.ru (Alexey Dobriyan)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH 2.6] I2C: New chip driver: sis5595
Message-Id: <200502011857.24786.adobriyan@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <w2Am1HDp.1107265957.3006340.khali@localhost>
In-Reply-To: <w2Am1HDp.1107265957.3006340.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>

On Tuesday 01 February 2005 15:52, Jean Delvare wrote:

> > What about making sis5595_update_device() a simple jiffies-related wrapper
> > around function that updates "struct sis5595" unconditionally. I'm not sure
> > I plugged sis5595_do_update_client right, but you'll get the idea.

> 1* It forces a chip update (i.e. full register read) on driver load (or
> more precisely on client detection). Since I2C/SMBus accesses are really
> slow, it will result in a significant time penalty. As the read values
> are only considered valid for 1.5 second (or equivalent duration for the
> other drivers), this penalty brings statistically no benefit in return.
> 
> 2* Each subsequent update (or attempt thereof) will conditionally require
> an additional function call, which represents a small time penalty again
> (much more than a comparison if I'm not mistaken).

lm90 (all sensors chips have approximately the same speed, right?) spec says:
"It takes the LM90 31.25 ms to measure the temperature of the remote diod and
internal diode". Google says: "The buses [I2C, SMBus] operate at the same
speed, up to 100kHz, but the I2C bus has both 400kHz and 2MHz versions."

What I'm trying to say that you shouldn't care about s/cmp; jcc/call/ if the
actual measurement is infinite from CPU's POV.

> We are only trying to avoid a conditional test and to get rid of a local
> variable, and end up with a much slower init

Well, yes, I agree that initialization will become slower. But how long is
register read (from first outb command to the moment when CPU sees it)?
I'm trying to build time hierarchy of things we're discussing in my head.

	Alexey

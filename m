From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH 2.6] I2C: New chip driver: sis5595
Message-Id: <w2Am1HDp.1107265957.3006340.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <200502011612.27220.adobriyan@mail.ru>
References: <20050125220945.GA23560@bode.aurel32.net>
In-Reply-To: <20050125220945.GA23560@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adobriyan@mail.ru
Cc: Aurelien Jarno <aurelien@aurel32.net>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>


Hi Alexey,

> What about making sis5595_update_device() a simple jiffies-related wrapper
> around function that updates "struct sis5595" unconditionally. I'm not sure
> I plugged sis5595_do_update_client right, but you'll get the idea.

Yeah I get the idea, I think I had something similar in mind some times
ago but it failed to please me for the following reasons:

1* It forces a chip update (i.e. full register read) on driver load (or
more precisely on client detection). Since I2C/SMBus accesses are really
slow, it will result in a significant time penalty. As the read values
are only considered valid for 1.5 second (or equivalent duration for the
other drivers), this penalty brings statistically no benefit in return.

2* Each subsequent update (or attempt thereof) will conditionally require
an additional function call, which represents a small time penalty again
(much more than a comparison if I'm not mistaken).

We are only trying to avoid a conditional test and to get rid of a local
variable, and end up with a much slower init and an additional function
call later. The loss seems to overweight the gain, don't you think?

So I wouldn't go that way. To me, the only acceptable simplification is
the initialization of "last_updated" to something which ensures that
the first update attempt will succeed - providing we actually can do
that.

Now I wonder, this is certainly not the only drivers in the kernel which
need to do this, right? Didn't the other ones solve the issue already?
Would be worth taking a look.

Thanks,
--
Jean Delvare

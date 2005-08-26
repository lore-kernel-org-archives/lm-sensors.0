From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 26 Aug 2005 09:32:49 +0000
Subject: [lm-sensors] Re: [PATCH] drivers/hwmon/*: kfree() correct pointers
Message-Id: <20050826093214.415f1987.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050826000231.35b97af9.khali@linux-fr.org>
	<20050825235354.10376.qmail@lwn.net>
In-Reply-To: <20050825235354.10376.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Alexey Dobriyan <adobriyan@gmail.com>

Hi Jonathan,

> > Already fixed in Greg's i2c tree and -mm for quite some time now...
> 
> So it is.  The comment says, however, that "the existing code works
> somewhat by accident."  In the case of the 9240 driver, however, the
> existing code demonstrably does not work - it oopsed on me.

I too did notice that the adm9240 case was worse than the four other
ones back then, but when I tried to get it to crash, it never did.  This
is the reason why I did not push this patch upstream faster.  I wonder
why it now does oops on you.

I also believe that this patch was somewhat misnamed.  It is not related
to the new hwmon class, but jut happened to change the same part of
these five drivers.  With a better name, the patch would most probably
have been selected by Greg in the last batch of i2c patches to Linus.

> The patch in Greg's tree looks fine (it's a straightforward fix, after
> all);

I wouldn't call it straightforward, but it certainly has been reviewed
and tested well enough by now to be considered safe.

> I'd recommend that it be merged before 2.6.13.

Fine with me.

Thanks,
-- 
Jean Delvare

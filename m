From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: user/kernel bug and memory leak in i2c-dev
Message-Id: <20030805204928.GA5203@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805211609.4a3a66d2.khali@linux-fr.org>
In-Reply-To: <20030805211609.4a3a66d2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 05, 2003 at 09:16:09PM +0200, Jean Delvare wrote:
> 
> Hi Greg,
> 
> As you may have seen on LKML (and this list) we have a patch ready to
> fix the two problems mentioned in topic. I will submit it for inclusion
> into Linux 2.4 tomorrow. I think I need to CC: Marcelo for it to work,
> right?

Yes.  I'd be glad to send it to him if you want me to (with your
attribution of course.)

I'm still looking at the patch you submitted, as it still seems strange
to me why it's needed...   I'll write back to that in a bit.

> I checked wether the fix should be applied somewhere else. It doesn't
> apply to Linux 2.2 (there were no I2C subsystem there) but it *does*
> apply to 2.6.0-test2. The proposed patch won't apply cleanly because the
> code was reindented, but it *has* to be applied though. What do you want
> me to do? Prepare and submit a patch to the LKML and CC: Linus, as I
> plan to do for 2.4? Prepare the patch and send it to you? Leave you
> handle the problem alone?

Hey, I don't want to handle anything alone here :)

If you send me a patch, I'll be glad to forward it on to Linus by
putting it into a bk tree for him to pull from.

More in response to the patch...

Sorry for the delay, "Real Life" (tm) issues been keeping me busy...

thanks,

greg k-h

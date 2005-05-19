From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Fwd: Testing LM85 driver
Message-Id: <20030320043205.GB18787@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E6A6826.2060802@paradyne.com>
In-Reply-To: <3E6A6826.2060802@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 19, 2003 at 09:28:53PM -0500, Mark D. Studebaker  wrote:
> Greg KH wrote:
> >Well, I'm offering to be a go-between if you want me to do it.
> 
> Fine w/ me. The others on the list are being conspicuously silent.

Heh, I've noticed :)

> Is this work (and driver priorities) being driven by IBM
> or is this on your own time?

Hm, it's a bit of both.  I'm allowed to do this kind of stuff at work,
as IBM lets me do general kernel stuff.  But I'm also personally
interested in getting the i2c code merged into the driver model, and
synced up with the main kernel tree.  So I end up doing this both on
company and my own time :)

And I have this laptop here (non-IBM) that I really want to get working
properly with i2c so I can get access to some portions of the
hardware...

> OK. Can we just put in the mailing list name or should we put in 
> people's names?

Generally maintainers are people.  There is a place in the entry for a
mailing list address if you want to use that.

thanks,

greg k-h

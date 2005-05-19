From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Fwd: Testing LM85 driver
Message-Id: <20030318013228.GC4904@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E6A6826.2060802@paradyne.com>
In-Reply-To: <3E6A6826.2060802@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 17, 2003 at 08:25:48PM -0500, Mark D. Studebaker  wrote:
> I see you made it onto the mailing list. Welcome.

thanks.

> Hadn't seen that 2.5.65 was out.
> I was just looking at the diffs between CVS and 2.5.64.
> It isn't huge but it's growing.

.65 is bigger :)

> As I'm not running a 2.5 kernel and am not following LKML, I don't have
> any visibility into which of the changes actually are tested/work.

The code works for me here :)

> With Cristoph making all those changes it would have been a lot
> of work to keep up with the backporting to CVS.

Christoph has made a lot of good fixes, from what I've seen.

> If he's done and things start coming through us again,
> then it makes sense to sync up with 2.5.65.

Even without Christoph's changes, you need to keep up with the kernel
tree in order to keep in sync with the most recent development.  As I
previously mentioned, this is tough to do, but once everything gets into
the main kernel tree, the work is much smaller.

Oh, and who is the maintainer of the kernel i2c code?  The listed people
in the MAINTAINERS file don't seem to be around anymore (and one of the
emails listed there is currently invalid.)

thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Fwd: Testing LM85 driver
Message-Id: <20030318081845.GF6085@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E6A6826.2060802@paradyne.com>
In-Reply-To: <3E6A6826.2060802@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 17, 2003 at 08:50:16PM -0500, Mark D. Studebaker  wrote:
> 
> 
> Greg KH wrote:
> >On Mon, Mar 17, 2003 at 08:25:48PM -0500, Mark D. Studebaker  wrote:
> >
> 
> >>If he's done and things start coming through us again,
> >>then it makes sense to sync up with 2.5.65.
> >
> >
> >Even without Christoph's changes, you need to keep up with the kernel
> >tree in order to keep in sync with the most recent development.  As I
> >previously mentioned, this is tough to do, but once everything gets into
> >the main kernel tree, the work is much smaller.
> >
> 
> I understand. Nobody's volunteered to do it.

Well, I'm offering to be a go-between if you want me to do it.

> >Oh, and who is the maintainer of the kernel i2c code?  The listed people
> >in the MAINTAINERS file don't seem to be around anymore (and one of the
> >emails listed there is currently invalid.)
> >
> 
> That's us. We talked about submitting a patch to MAINTAINERS to make
> it official but we haven't.

I'd really recommend it.  Please send me a patch to that file for my
next round of stuff I send off to Linus.

thanks,

greg k-h

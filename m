From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: no more "applied, thanks" emails from me.
Message-Id: <20050506062721.GA14953@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050504042033.GB16011@kroah.com>
In-Reply-To: <20050504042033.GB16011@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 05, 2005 at 12:58:05AM -0700, Greg KH wrote:
> On Wed, May 04, 2005 at 10:33:00PM -0400, Mark M. Hoffman wrote:
> > Hi Greg:
> > 
> > * Greg KH <greg@kroah.com> [2005-05-03 21:20:33 -0700]:
> > > Just a short note to know that I'll probably not be sending any kind of
> > > ACK message out to the mailing list anymore when I apply patches to my
> > > tree.  Instead, the patch submitter will get a message when it gets
> > > applied, that contains a bunch of info about what patch it was, and
> > > others that they have pending in my tree.
> > 
> > I already received one of these for that little USB patch.  It would be
> > nice if you could make the ACK email threaded to the original patch email.
> 
> Yeah, I tried it, but unfortunatly the In-Reply-To: didn't work out for
> a variety of reasons (not present in patch due to it being stripped out,
> script to do raw smtp not handling it, etc.)  But I'll hack on it a bit
> and see if I can get that working as I too hate breaking threading...

Ok, I think I have this working now.  If you get a response from me,
that has broken threading, please let me know.

thanks,

greg k-h

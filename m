From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH 2.6] new sensors driver: SMSC LPC47B397-NC
Message-Id: <20050106223354.GA15813@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050102212924.GB17759@jupiter.solarsys.private>
In-Reply-To: <20050102212924.GB17759@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 04, 2005 at 12:38:24PM -0500, Mark M. Hoffman wrote:
> Hi again:
> 
> * Jean Delvare <khali@linux-fr.org> [2005-01-04 10:23:03 +0100]:
> > > Is there a published standard for email address obfuscation?  Would it
> > > make sense if there was? ;)
> > 
> > I tried a simple (cowboyz-free) obfuscation in the early days but Greg
> > told me it was making things more complex for him, so I stopped. This
> > probably means that people not wanting their e-mail address known just
> > cannot sign kernel patches.
> 
> How about this:
> 
> Signed-off-by: Craig Kelly (In-Store Broadcasting Network)
> Signed-off-by: Glenn Ball (Utilitek Systems, Inc.)
> Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
> 
> The first two aren't going to maintain the driver anyway, but I want
> the signatures there as contributor of the datasheet and holder of the
> copyright, respectively.  If I'm going to "sign-off" that I am allowed
> to distribute this work, then I also want to include from whom this
> permission came.  Linus wrote [1]:

That's an ok way to do it, but I _really_ would like to see real email
addresses in the signed-off-by line, as it helps out in the end for
figuring out problems.

Care to redo the patch?

thanks,

greg k-h

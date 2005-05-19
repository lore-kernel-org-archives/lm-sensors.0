From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c-algo-8xx
Message-Id: <20030802191240.GA16709@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802133344.71d15fac.khali@linux-fr.org>
In-Reply-To: <20030802133344.71d15fac.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 02, 2003 at 08:03:37PM +0200, Jean Delvare wrote:
> 
> > As this is a ppc driver, I'd look in the ppc kernel tree to see if
> > they have included it in their repository and not just synced up with
> > Linus's tree yet.
> 
> I didn't know there was an active separate tree for PPC. This must be a
> real mess sync'ing everything... Where can I take a look? Kernel.org
> only has patches up to 2.4.18 as far as I can see.

Take a look at:
	http://penguinppc.org/dev/kernel.shtml

And yes, all archs except i386 are usually out of sync from Linus's
tree.  x86-64 does the best job of keeping in sync, but even that one
usually lags a bit.

Hope this helps,

greg k-h

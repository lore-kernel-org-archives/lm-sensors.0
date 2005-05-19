From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [CVS PATCH] Sync cvs tree with latest 2.5 bk tree
Message-Id: <20030428233253.GA1462@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030425183641.GB2257@kroah.com>
In-Reply-To: <20030425183641.GB2257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 28, 2003 at 07:15:33PM -0400, Mark M. Hoffman wrote:
> * Greg KH <greg@kroah.com> [2003-04-28 09:58:26 -0700]:
> > Why even worry about a 2.5 and onward version of the CVS tree?  Why not
> > just use CVS for 2.4 and older, and use the in-kernel tree version of
> > the sensors and i2c code for that stuff?
> 
> Won't we still need to branch lmsensors for userspace?

Yes, lmsensors will need to.  But not the kernel code.  Sorry, I was
thinking only the kernel code when I wrote that.

greg k-h

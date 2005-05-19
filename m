From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-Id: <20050419185807.GA1191@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050419043938.GA23724@kroah.com>
In-Reply-To: <20050419043938.GA23724@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Mon, Apr 18, 2005 at 09:39:38PM -0700, Greg KH wrote:
> Alright, let's try some small i2c and w1 patches...
> 
> Could you merge with:
> 	kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/

Nice, it looks like the merge of this tree, and my usb tree worked just
fine.

So, what does this now mean?  Is your kernel.org git tree now going to
be the "real" kernel tree that you will be working off of now?  Should
we crank up the nightly snapshots and emails to the -commits list?

Can I rely on the fact that these patches are now in your tree and I can
forget about them? :)

Just wondering how comfortable you feel with your git tree so far.

thanks,

greg k-h

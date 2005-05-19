From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: bus scan removal
Message-Id: <20031223220939.GD15946@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031221100543.28eaf2ff.khali@linux-fr.org>
In-Reply-To: <20031221100543.28eaf2ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 23, 2003 at 10:58:45PM +0100, Jean Delvare wrote:
> > For systems that have a 64bit kernel, and a 32bit userspace, all
> > ioctls in the kernel need a "thunking" layer in order to pass the data
> > between the kernel and userspace properly.  Last I looked that layer
> > did not contain any i2c ioctls, so i2c-dev will not work on those
> > kinds of systems (ppc64, sparc64, mips64, amd64, ia64, etc...)
> 
> Take a look at 2.6.0-mm1's changelog. Didn't look at the code but it
> looks like someone just implemented this. Greg, do you confirm it's the
> same as what you're talking about?

You are correct, I forgot about Ben's patch.  Yes, this is exactly what
I was talking about.  So, if any people using kernels on the above
platform want to use i2c-detect, they should use the -mm tree.

thanks,

greg k-h

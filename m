From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [PATCH] sensors-detect and udev
Message-Id: <20040812195254.GA2952@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040810225714.GA2700@pc.aurel32.lan>
In-Reply-To: <20040810225714.GA2700@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 12, 2004 at 08:01:36PM +0200, Jean Delvare wrote:
> > udev manages the /dev tree from userspace based on the kernel
> > information in sysfs.  A good summary of it is at:
> > 	http://www.linuxjournal.com/article.php?sids16
> > (...)
> > Hope this helps explain it.
> 
> Thanks, that was a perfectly clear explanation.
> 
> (Note: I think there's a little error in the article. Minors were
> originally from 0 to 255, not 1 to 255.)

Oops, good catch, you are correct.

greg k-h

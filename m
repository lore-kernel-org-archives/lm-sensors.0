From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [PATCH] sensors-detect and udev
Message-Id: <20040811205927.GA20393@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040810225714.GA2700@pc.aurel32.lan>
In-Reply-To: <20040810225714.GA2700@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 11, 2004 at 08:36:51PM +0200, Jean Delvare wrote:
> 
> And could you please explain how udev is working? I don't know anything
> about it.

udev manages the /dev tree from userspace based on the kernel
information in sysfs.  A good summary of it is at:
	http://www.linuxjournal.com/article.php?sids16

There's also some older info linked off of:
	www.kroah.com/linux/
to an OLS paper, an OLS presentation, and a more recent OSCON
presentation on it.

Hope this helps explain it.

thanks,

greg k-h

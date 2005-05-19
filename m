From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: [PATCH 2.6] New chip driver: pcf8591
Message-Id: <20040409195700.GB18148@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040328160717.GA32728@pc.aurel32.private>
In-Reply-To: <20040328160717.GA32728@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Apr 09, 2004 at 09:42:07PM +0200, Jean Delvare wrote:
> 
> BTW, wouldn't a "else return -1" make sense here? Silently ignoring
> errors doesn't sound good to me.

Well make it a real error, like -EINVAL or something, so userspace has a
chance to report it properly.  Not just -1.

thanks,

greg k-h

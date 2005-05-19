From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <20040213234031.GA17133@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 10, 2004 at 08:26:51PM +0100, Jean Delvare wrote: 
> Greg, is it correct to have such a high number of sysfs files for a
> driver?

That's fine to do.  You might want to start using attribute lists to
make it easier to register all of those files :)

thanks,

greg k-h

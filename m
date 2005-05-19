From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041201222951.GB9357@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 29, 2004 at 11:09:44PM -0500, Mark M. Hoffman wrote:
> 
> There is precedent to having two implementations of the same driver -
> at least Adaptec 2940 that I know of.  Ultimately it's up to Greg I
> guess...

There is the uhci and usb-uhci drivers in the 2.4 kernel too, if you are
looking for precedent.  But in the end, it's a big pain to have two
drivers, as distros will ask you which one they need to pick.  And if
one of them works for everyone, then why not just have one driver.

So try to prevent it if you can.

thanks,

greg k-h

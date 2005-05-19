From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: new drivers for linux 2.6, testers wanted
Message-Id: <20040103055247.GA5306@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040101092047.3c6a40b4.khali@linux-fr.org>
In-Reply-To: <20040101092047.3c6a40b4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 01, 2004 at 09:20:47AM +0100, Jean Delvare wrote:
> 
> So, if any of you have parallel port i2c adapters and are running a 2.6
> kernel, that would be nice to you to give a try to my new drivers.
> You'll have to pass the type parameter that is correct for your board:
>  0 = Philips
>  2 = Velleman
>  3 = ELV
>  4 = ADM evaluation board

Is there any way to autodetect this so the module parameter is not
needed?

thanks,

greg k-h

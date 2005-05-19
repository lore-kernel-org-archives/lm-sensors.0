From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: i2c adapters class
Message-Id: <20040315210358.GB23503@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040224223843.2fb3394a.khali@linux-fr.org>
In-Reply-To: <20040224223843.2fb3394a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 13, 2004 at 08:27:01PM +0100, Jean Delvare wrote:
> > Ah, in digging through the change log entries I found the following:
> > (...)
> > So this was a video developer's request.  Does that help explain it a
> > bit more now?
> 
> This at leasts explain how it came in here with neither you nor I
> knowing why.

Heh, well the patch did go though me to Linus, so I can't claim complete
ignorance :)

> This also suggests that we should leave classes in place. And if other
> people use it, we should do as well, for the sake of consistency.

Agreed.

> So, from now on, I suggest:
> * Renaming I2C_ADAP_CLASS_SMBUS to I2C_ADAP_CLASS_SENSORS (unless
>   someone prefers another name).
> * All chip driver check for the bus being of this class.
> * All bus driver known to host sensors get this class.
> 
> I'll submit a patch doing all that if nobody objects.

That sounds good to me.

thanks,

greg k-h

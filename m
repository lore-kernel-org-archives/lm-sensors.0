From: greg@kroah.com (Greg KH)
Date: Thu, 01 Sep 2005 18:02:28 +0000
Subject: [lm-sensors] Re: i2c via686a.c: save at least 0.5k of space by long
Message-Id: <20050901155915.GB1235@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509010910.14824.vda@ilport.com.ua>
In-Reply-To: <200509010910.14824.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 09:10:14AM +0300, Denis Vlasenko wrote:
> Not tested, but it's rather obvious.

Except you forgot a "Signed-off-by:" line...

> --- linux-2.6.12.src/drivers/i2c/chips/via686a.c.orig	Sun Jun 19 16:10:10 2005
> +++ linux-2.6.12.src/drivers/i2c/chips/via686a.c	Tue Aug 30 00:21:39 2005
> @@ -205,7 +205,7 @@ static inline u8 FAN_TO_REG(long rpm, in
>   but the function is very linear in the useful range (0-80 deg C), so 
>   we'll just use linear interpolation for 10-bit readings.)  So, tempLUT 
>   is the temp at via register values 0-255: */
> -static const long tempLUT[] > +static const int16_t tempLUT[] 
int16_t is not a proper kernel type.  Do you really mean s16 instead?
Care to redo this?

thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040221010248.GE18346@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 20, 2004 at 07:55:37PM -0500, Mark Studebaker wrote:
> Exactly the same as what's in
> /sys/class/i2c-dev/i2c-x/device/i2c-y/name file now,
> for example
> 
> 	SMBus AMD756 adapter at 80e0    	

Ah, that would be nice.  I'll see if I can get that to work...

thanks,

greg k-h

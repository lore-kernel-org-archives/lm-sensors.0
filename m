From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: [PATCH 2.6] Support for IXP42x GPIO-based I2C (updated)
Message-Id: <20040217225931.GA4131@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040217212536.GA23535@plexity.net>
In-Reply-To: <20040217212536.GA23535@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 17, 2004 at 02:25:36PM -0700, Deepak Saxena wrote:
> 
> Greg,
> 
> Following is an updated patch to add support for using the GPIO lines
> on an Intel IXP42x SOC for I2C.  Changes since last patch include:
> 
> - Cleanups as per Jean Delvare's comments
> 
> - Rename functions as 42x instead of 425
> 
> - Change the comments at the top of the file to better reflect the
>   purpose of this driver.
> 
> This code has been tested with the eeprom client driver and worked
> w/o any problems.

Applied, thanks.

greg k-h

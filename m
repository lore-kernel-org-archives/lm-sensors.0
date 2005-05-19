From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH lm_sensors2 CVS code] - i2c-prosavage driver
Message-Id: <20030615043634.GB5661@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0306141542460.16135-200000@axp.arion.loc>
In-Reply-To: <Pine.LNX.4.21.0306141542460.16135-200000@axp.arion.loc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 14, 2003 at 03:52:10PM +0200, henk wrote:
> 
> Added i2c-prosavage bus driver to todays lm_sensors2 CVS code, an updated 
> ./mkpatch/mkpatch.pl and ./kernel/busses/Module.mk is included.
> 
> ..
> /*  18-05-2003 - created
>  *  16-06-2003 - adapted for lm_sensors2
>  *
>  *  This driver interfaces to the I2C bus of the VIA north bridge embedded
>  *  ProSavage4/8 devices. Usefull for gaining access to the TV Encoder
> chips.
> ..
> 
> Please include this in the CVS tree..

Care to make a 2.5 patch too?

thanks,

greg k-h

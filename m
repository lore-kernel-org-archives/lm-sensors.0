From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH 2.6] Update IOP3xx I2C bus driver
Message-Id: <20050106225122.GA17900@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104195023.GA9225@plexity.net>
In-Reply-To: <20050104195023.GA9225@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 04, 2005 at 11:50:23AM -0800, Deepak Saxena wrote:
> 
> Greg,
> 
> The following patch is a major cleanup of the IOP3xx I2C bus driver
> that is found on Intel's IOP and IXP chipsets. The existing driver in
> the 2.6 tree uses hardcoded I/O addresses based on board configuration 
> which is just going to get ugly as more chips use this unit. The update
> switches to using the driver model and passing in the I/O addresses
> via platform_device resources. The patch also updates the ID name to 
> more closely match the actual usage of the device.  

Nice stuff, that's a great usage of the resource stuff.  I've applied
your second patch to my trees.

thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: status of i2c in 2.5.70 kernel
Message-Id: <20030609170036.GA7023@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030609114202.19c1002e.b.stolk@chello.nl>
In-Reply-To: <20030609114202.19c1002e.b.stolk@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 09, 2003 at 06:42:37PM +0200, Bram Stolk wrote:
> Greg,
> 
> 
> Thanks for the info!
> 
> There is indeed info in the /sys/class directory.
> 
> amoras:/sys/bus/i2c# cat /sys/class/i2c-adapter/i2c-0/device/name 
> SMBus Via Pro adapter at 5000
> 
> Yet, the /sys/bus/i2c dir contains no files, dirs only:
> 
> amoras:/sys/bus/i2c# find /sys/bus/i2c -type f -print
> amoras:/sys/bus/i2c# 
> 
> When I open i2c-0, and try reading from all addresses, I can see
> that there are 3 slaves on the bus that respond to read-requests.

Then you need to figure out which chip drivers corrispond to those
slaves.  The majority of the chip drivers have not been ported from the
sensor's cvs tree to the 2.5 kernel due to people not having the
hardware.  If you could help out in this, it would be greatly
appreciated.

thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH 2.6] New chip driver ported: lm80
Message-Id: <20040214174852.GB5280@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040214125017.7d977b1a.khali@linux-fr.org>
In-Reply-To: <20040214125017.7d977b1a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 14, 2004 at 12:50:17PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Here is a port for the lm80 driver, which supports LM80 chips by
> National Semiconductor. The port is mostly the work of Tiago Sousa,
> which I reviewed and polished as necessary.
> 
> I leave it to you to decide wether you want to accept this driver in
> Linux 2.6, or not. See my previous mail for reasons you could have not
> to want it. (My opinion being: now that the driver has been ported,
> let's include it.)

Looks good, I'll add it to my TODO queue to apply after 2.6.3 is out.

thanks,

greg k-h

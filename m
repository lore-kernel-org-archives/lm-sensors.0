From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: lm_sensors & kernel
Message-Id: <20031111214605.GA6544@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031110190054.5c8c683b.khali@linux-fr.org>
In-Reply-To: <20031110190054.5c8c683b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 10, 2003 at 02:25:11PM -0600, Troy Henderson wrote:
> > It is there! Take a look in drivers/i2c, you'll see almost all bus
> > drivers, plus several chip drivers. The main problem is that user-space
> > tools don't support Linux 2.6 yet (although I think someone is working
> > on it) so you'll have to read the raw values in /sysfs. Admittedly not
> > very comfortable.
> 
> I was able to do that, but I was looking for a way to make GKRellm show 
> the sensor data.

The latest versions of gkrellm should work just fine with a 2.6 kernel
to see the sensor values.  It uses sysfs.

Good luck,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Tue, 29 Aug 2006 23:25:56 +0000
Subject: [lm-sensors] [PATCH 00/14] hwmon updates for 2.6.19
Message-Id: <20060829232556.GA18233@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060828140020.61c81eb0.khali@linux-fr.org>
In-Reply-To: <20060828140020.61c81eb0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 28, 2006 at 02:00:20PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Here comes a 14-piece hwmon update patchset. There is a new driver for
> the thermal sensors embedded in AMD K8 CPUs, many fixes and
> improvements to the it87 driver, including support for the IT8716F and
> IT8718F, and a few other things. All these patches should go to -mm for
> now, and to 2.6.19 later.

I've applied them all.

Care to work on all of the __must_check warnings that the hwmon code now
spits out in the -mm and my trees?  It's quite ugly :(

thanks,

greg k-h


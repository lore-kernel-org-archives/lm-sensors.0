From: greg@kroah.com (Greg KH)
Date: Wed, 27 Jul 2005 00:55:52 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers
Message-Id: <20050726225411.GA5606@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050719233902.40282559.khali@linux-fr.org> <20050719234843.14cfb1ec.khali@linux-fr.org> <20050720042755.GD26552@kroah.com> <20050720234603.2b66560d.khali@linux-fr.org> <20050725003551.GE9824@kroah.com> <20050725192827.0b166d1e.khali@linux-fr.org>
In-Reply-To: <20050725192827.0b166d1e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Mon, Jul 25, 2005 at 07:28:27PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> > Ah, much better, thanks.  Sounds like a great plan, I'll go apply your
> > patches in a day or so when I catch up from my travels.
> 
> OK, thanks.
> 
> Note that there are a few patches which you should apply before this
> series, in particular Mark Hoffman's 3 hwmon class patches. There are no
> hard dependencies between both series but applying them in order is
> likely to ease your work.
> 
> You can take a look at my current stack here for reference:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/series

Ok, should be caught up now.  I have a pci patch or two still left to
apply that i know you were also tracking.

thanks,

greg k-h

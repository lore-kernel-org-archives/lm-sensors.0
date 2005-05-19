From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] drivers/i2c/*: #include <linux/config.h> cleanup
Message-Id: <20050502204049.GB32713@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050416184922.7c09d848.khali@linux-fr.org>
In-Reply-To: <20050416184922.7c09d848.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 16, 2005 at 06:49:22PM +0200, Jean Delvare wrote:
> Hi Alexey,
> 
> > Files that don't use CONFIG_* stuff shouldn't include config.h
> > Files that use CONFIG_* stuff should include config.h
> >
> > It's that simple. ;-)
> 
> I agree. This won't change anything though, as all drivers include
> either device.h or module.h, which in turn include config.h. But you are
> still correct, so I approve your patch.
> 
> For completeness, I would propose the following on top of your own
> patch:
> 
> i2c bus drivers do not need to define DEBUG themselves, as the Kconfig
> system takes care of it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] drivers/i2c/*: #include <linux/config.h> cleanup
Message-Id: <20050502214217.GB19499@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050416184922.7c09d848.khali@linux-fr.org>
In-Reply-To: <20050416184922.7c09d848.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 16, 2005 at 06:10:02PM +0000, Alexey Dobriyan wrote:

> Files that don't use CONFIG_* stuff shouldn't include config.h
> Files that use CONFIG_* stuff should include config.h
> 
> It's that simple. ;-)
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Applied, thanks.

greg k-h

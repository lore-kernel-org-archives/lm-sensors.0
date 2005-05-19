From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: [PATCH] Add SiS96x I2C/SMBus driver (vs 2.5.69-bk6)
Message-Id: <20030513205132.GA11843@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030512010613.GA12130@earth.solarsys.private>
In-Reply-To: <20030512010613.GA12130@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>
Cc: mhoffman@lightlink.com

On Sun, May 11, 2003 at 09:06:13PM -0400, Mark M. Hoffman wrote:
> This patch adds support for the SMBus of SiS96x south
> bridges.  It is based on i2c-sis645.c from the lm sensors
> project, which never made it into an official kernel and
> was anyway mis-named.
> 
> This driver works on my SiS 645/961 board vs w83781d.

Thanks, I've applied this to my trees and will send it on.

greg k-h

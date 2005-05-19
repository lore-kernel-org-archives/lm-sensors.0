From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH 2.6] Trivial indentation fix in i2c/chips/Kconfig
Message-Id: <20050303001449.GB10340@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4224C0D4.2060303@katalix.com> <cIyC5ZN2.1109756623.5808030.khali@localhost> <20050302194522.2512fe02.khali@linux-fr.org>
In-Reply-To: <20050302194522.2512fe02.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: James Chapman <jchapman@katalix.com>

On Wed, Mar 02, 2005 at 07:45:22PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Quoting myself:
> 
> > (...) I also think I see an indentation issue on the "tristate" line,
> > seemingly copied from the SENSORS_DS1621 section which would need to
> > be fixed as well.
> 
> Here is the trivial patch fixing that, if you want to apply it.
> 
> Thanks,
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [RFC] I2C: Remove the i2c_client id field
Message-Id: <20050106231244.GA22174@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041227230402.272fafd0.khali@linux-fr.org>
In-Reply-To: <20041227230402.272fafd0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

On Mon, Dec 27, 2004 at 11:04:02PM +0100, Jean Delvare wrote:
> Hi Greg, hi all,
> 
> While porting various hardware monitoring drivers to Linux 2.6 and
> otherwise working on i2c drivers in 2.6, I found that the i2c_client
> structure has an "id" field (of type int) which is mostly unused. I am
> not exactly sure why it was introduced in the first place, and since the
> i2c subsystem code was significantly reworked since, it might not
> actually matter.

It's fine with me if it's dropped.

thanks,

greg k-h

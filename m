From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH] Add a non-blocking interface to the I2C code, part 1
Message-Id: <20050317070940.GA15508@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42261AFB.40001@acm.org>
In-Reply-To: <42261AFB.40001@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>

On Wed, Mar 02, 2005 at 01:58:51PM -0600, Corey Minyard wrote:
> This patch reorganizes the I2C SMBus formatting code to make it more
> suitable for the upcoming non-blocking changes.

You are changing too much stuff here to claim it's just a
reorganization:
	- variable name changes for no reason
	- coding style changes (improper ones at that)
	- logic changes.

What exactly are you doing with this patch, and why?

thanks,

greg k-h

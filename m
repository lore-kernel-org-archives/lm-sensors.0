From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH 2.6.0-test3]bugfix for initialization bug in adm1021
Message-Id: <20030814213242.GA4058@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1060731495.11264.8.camel@vmhack>
In-Reply-To: <1060731495.11264.8.camel@vmhack>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, lkml <linux-kernel@vger.kernel.org>

On Tue, Aug 12, 2003 at 04:38:13PM -0700, Rusty Lynch wrote:
> While initializing the adm1021 device, the driver is performing a conversion
> from fixed point to Celcius on values that were declaired as Celcius.  On
> my Dell Precision 220 this results in a shutdown after a couple of minutes
> running.
> 
> This is a very simple patch against the 2.6.0-test3 tree that just removes the
> conversion.

Applied, thanks.

Next time you might want to CC: me to make sure I catch this.

greg k-h

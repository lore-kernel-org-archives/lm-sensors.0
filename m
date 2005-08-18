From: greg@kroah.com (Greg KH)
Date: Thu, 18 Aug 2005 20:56:38 +0000
Subject: [lm-sensors] Re: [PATCH 0/5] improve i2c probing
Message-Id: <20050818185401.GA32684@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050815175106.GA24959@litech.org>
In-Reply-To: <20050815175106.GA24959@litech.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathan Lutchansky <lutchann@litech.org>
Cc: LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Mon, Aug 15, 2005 at 01:51:06PM -0400, Nathan Lutchansky wrote:
> Hi everyone,
> 
> This patch series makes a couple of improvements to the i2c device
> probing process.

<snip>

These all generally look quite good, thanks.  But it looks like you and
Jean went back and forth on a few issues, care to repost an updated
series of patches based on that exchange so I can have them get some
testing in the -mm tree?

thanks,

greg k-h

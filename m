From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: [PATCH] ds1337 1/4
Message-Id: <20050407233628.GA6703@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique> <20050407211839.GA5357@kroah.com> <20050407231758.GB27226@orphique>
In-Reply-To: <20050407231758.GB27226@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>

On Fri, Apr 08, 2005 at 01:17:58AM +0200, Ladislav Michl wrote:
> On Thu, Apr 07, 2005 at 02:18:39PM -0700, Greg KH wrote:
> > Jean's point is that you should send an individual patch for each type
> > of individual change.  It's ok to say "patch 3 requires you to have
> > applied patches 1 and 2" and so on.  Please split this up better.
> 
> Here it is...
> 
> Use i2c_transfer to send message, so we get proper bus locking.

Oops, you forgot to add a Signed-off-by: line for every patch, as per
Documentation/SubmittingPatches.  Care to redo them?

thanks,

greg k-h

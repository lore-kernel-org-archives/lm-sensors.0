From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] ds1337 3/4
Message-Id: <20050502204136.GE32713@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407231848.GD27226@orphique> <u5mZNEX1.1112954918.3200720.khali@localhost> <20050408130639.GC7054@orphique>
In-Reply-To: <20050408130639.GC7054@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>

On Fri, Apr 08, 2005 at 03:06:39PM +0200, Ladislav Michl wrote:
> On Fri, Apr 08, 2005 at 12:08:38PM +0200, Jean Delvare wrote:
> > Looks OK to me.
> 
> Ok, I have few more fixes for this driver and will send them later
> when I find time to split them out into smaller chunks. Again, here is
> patch with signed off line.
> 
> 
> dev_{dbg,err} functions should print client's device name. data->id can
> be dropped from message, because device is determined by bus it hangs on
> (it has fixed address).
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Applied, thanks.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] ds1337 2/4
Message-Id: <20050502204128.GD32713@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407231820.GC27226@orphique> <okTF4WNV.1112950260.5841330.khali@localhost> <20050408130216.GB7054@orphique>
In-Reply-To: <20050408130216.GB7054@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>

On Fri, Apr 08, 2005 at 03:02:16PM +0200, Ladislav Michl wrote:
> On Fri, Apr 08, 2005 at 10:51:00AM +0200, Jean Delvare wrote:
> > Yes, this one is OK with me too.
> 
> Ok, here it is with signed off line.
> 
> Use correct macros to convert between bdc and bin. See linux/bcd.h
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Applied, thanks.

greg k-h

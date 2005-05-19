From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] ds1337 1/4
Message-Id: <20050502204117.GC32713@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique> <20050407211839.GA5357@kroah.com> <20050407231758.GB27226@orphique> <20050407233628.GA6703@kroah.com> <20050408130021.GA7054@orphique>
In-Reply-To: <20050408130021.GA7054@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>

On Fri, Apr 08, 2005 at 03:00:21PM +0200, Ladislav Michl wrote:
> On Thu, Apr 07, 2005 at 04:36:29PM -0700, Greg KH wrote:
> > Oops, you forgot to add a Signed-off-by: line for every patch, as per
> > Documentation/SubmittingPatches.  Care to redo them?
> 
> Here it is (I'm sorry about that).
> 
> Use i2c_transfer to send message, so we get proper bus locking.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Applied, thanks.

greg k-h

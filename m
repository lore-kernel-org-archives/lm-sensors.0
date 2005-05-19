From: jchapman@katalix.com (James Chapman)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [PATCH] ds1337 1/4
Message-Id: <4256B1D2.5080502@katalix.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique> <20050407211839.GA5357@kroah.com> <20050407231758.GB27226@orphique> <20050407233628.GA6703@kroah.com> <20050408130021.GA7054@orphique>
In-Reply-To: <20050408130021.GA7054@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Greg KH <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>

Sorry for joining this thread late.

Patches 1-3 are fine with me.

/james

Ladislav Michl wrote:

> On Thu, Apr 07, 2005 at 04:36:29PM -0700, Greg KH wrote:
> 
>>Oops, you forgot to add a Signed-off-by: line for every patch, as per
>>Documentation/SubmittingPatches.  Care to redo them?
> 
> 
> Here it is (I'm sorry about that).
> 
> Use i2c_transfer to send message, so we get proper bus locking.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 

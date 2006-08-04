From: linux-kernel@hansmi.ch (Michael Hanselmann)
Date: Fri, 04 Aug 2006 21:49:24 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060804214924.GE7982@hansmi.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 04, 2006 at 05:39:32PM -0300, Aristeu Sergio Rozanski Filho wrote:
> > This guarantees a minimum wait time of 5msec after writing the value.
> > Looking at the specs[1], this should be done. Your code doesn't do that:

> I doubt that if it's possible to retrying after a fail the hardware will
> bother if we try to do the first read in less than 5ms... but here it
> goes. two versions, feel free to choose.

The specs are written based on the Mac OS X driver, and I think Apple
knows their hardware.

After discussing both variants, Ren? Nussbaumer and myself prefer the
first one.

Acked-by: Michael Hanselmann <linux-kernel at hansmi.ch>
Acked-by: Ren? Nussbaumer <linux-kernel at killerfox.forkbomb.ch>

Greets,
Michael


From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: bmcsensors howto?
Message-Id: <20040922143122.M9829@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <e6c87c5df333406bb6fd34c1549fe20d@onlymooo.com>
In-Reply-To: <e6c87c5df333406bb6fd34c1549fe20d@onlymooo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 22 Sep 2004 16:02:56 +0200, Axel Thimm wrote
> On Wed, Sep 22, 2004 at 08:49:17AM -0400, Mark Studebaker wrote:
> > We don't make the RPMs.
> > If you're running 2.6 then wait until the port is finished and included in 
> > the kernel.
> 
> Is it possible to build external kernel modules for 2.6 as it is for
> 2.4? I could then package it up like currently done for 2.4.

It is technically possible but we want to avoid this as much as possible.
Kernel drivers must live in the kernel tree.

-- 
Jean Delvare
http://khali.linux-fr.org/

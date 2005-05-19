From: zwane@linuxpower.ca (Zwane Mwaikambo)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <Pine.LNX.4.61.0411291549480.6302@montezuma.fsmlabs.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 28 Nov 2004, Mark M. Hoffman wrote:

> Hello all:
> 
> I've started a complete re-write of the i2c-i801 SMBus driver.  As
> compared to the old one, this one:
> 
> 1) Supports fewer transaction types... still TODO
> 
> 2) Does not have any BIOS workaround nastiness.  I am hoping that
> I can leave that out and that people who need that can be directed
> to just use the old driver.
> 
> 3) Does not support PEC (not sure who uses it... can also be TODO
> if there's interest).
> 
> And the primary difference 4) uses interrupts instead of polling.
> 
> I'm not exactly a stranger to interrupt-handling, having designed
> whole interrupt handling mechanisms for (non-Linux) embedded systems.
> *But*, as this is my first shot at it with a Linux driver...  I would
> appreciate a close look at those parts.  The design is similar to 
> i2c-iop3xx, except where it's different. :)

Looking at the driver, algo_data->lock only protects status, which can 
easily be overwritten if the reader doesn't read it before the next 
interrupt. In which case it seems like overkill using a lock, why not just 
do an atomic xchg?

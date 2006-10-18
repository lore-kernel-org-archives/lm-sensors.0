From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Oct 2006 14:59:00 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors
Message-Id: <20061018165900.bbac0aa7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4533FD74.2050404@hal.saar.de>
In-Reply-To: <4533FD74.2050404@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

On Wed, 18 Oct 2006 06:37:24 +0200, Michael Kress wrote:
> xen-3.0.3-0 is released now, it comes with kernel 2.6.16.29 and runs
> flawlessly so far.
> I was modprob'ing and rmmod'ing pc87427 every 2 secs for some hours now,
> plus I was running bonnie++ in the background.
> 
> Between these 2 secs I was able to do a clean sensors run.
> 
> No messages, no crashes, just perfect. You never know, but so far, even
> my irq messages about "nobody cared" are gone.

Good news! :) Thanks for letting me now.

The pc87427 driver is in -mm now.

-- 
Jean Delvare


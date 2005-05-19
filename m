From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: w83627hf driver initialization
Message-Id: <40F1D985.1000206@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407080908.i6898rDo086579@zone3.gcu-squad.org>
In-Reply-To: <200407080908.i6898rDo086579@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'll look at it.

Jean Delvare wrote:
> Hi all,
> 
> Regarding ticket #1722:
> 
> The w83627hf driver (both in 2.4/CVS and 2.6) has a really agressive init
> process. This isn't the first time we have a problem report related to
> this, typically fans going to full speed on driver load (this is the
> case in this ticket).
> 
> It would be great if someone who can test the driver (I cannot) would
> take a look and rework this part of the driver.
> 
> As a reminder, our policy for drivers is that the init process should NOT
> reset the chip by default, and should do as little as necessary to make
> the chip work. The BIOS is supposed to have done the configuration work
> properly. Allowing more initialization to be forced with init > 1 or
> initialization to be completely skipped with init = 0 is a good things
> too, but the default (init = 1) should stick to the "light
> initialization" idea.
> 
> Thanks,
> Jean Delvare
> 
> 

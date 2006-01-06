From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 06 Jan 2006 19:08:48 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re:
Message-Id: <20060106200848.08ed4ad2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> Sorry I have not read the w83687thf spec before, It seems a similar chip
> to w83627thf, so I would like to give a patch to try make the driver
> work first. I'm not sure if it can work but I'm sure there should be a
> better solution.

So you do have a datasheet for this chip? I asked Chunhao Huang about
it when he was working with us, but back then he didn't have the
datasheet:

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012754.html

The main reason why we do not support this chip at the moment is simply
the lack of datasheet. If you can publish it on Winbond's site and/or
send it to me, we should be able to start working on proper support. I
made the same assumption you did about the W83687THF chip: that it was
probably similar to the W83627THF, given the similar names and release
dates. If this is true, adding support to the w83627hf driver should be
straightforward. The experimental patch I wrote several months ago may
even be almost sufficient, at least to start with.

> Quoting Jim: 
> > BTW - youd do well to drop the *misfortunate* posture.
> I will try to tell my HW colleagues your dissatisfaction...
> Thank you Jim ;) 

It really has nothing to do with the hardware itself. It's simply a
matter of getting documentation about the chip. I can easily understand
Steven's original position, it's always a bit worrying when you realize
that your precious hardware lacks support, and he couldn't know how
helpful Winbond is. Now that he knows, I'm sure he'll see the life in
a much more positive way :)

-- 
Jean Delvare


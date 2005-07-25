From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 25 Jul 2005 20:06:52 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <20050725200630.58cc9486.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D27327.7050402@internode.on.net>
In-Reply-To: <42D27327.7050402@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Cadu,

> > The driver is only half coded. I did fan and temperature monitoring,
> > because I think that's what most people are interested in. I'd have
> > done more but had many other things to do and no hardware to test my
> > code so my progress was too slow.
> 
> Sorry. I was working on it (and it's easy to make), but in the last
> weeks I was so busy... I'm so sorry.

Don't be sorry, it's no problem. Take your time. If people think it's
not fast enough, then they should code it themselves.

> In this week I will have time to work on it. I hope I will have a
> patch this week with voltage support. Timothy, please stay in touch
> with me. I'll be pleasure if you can help me to test the code (and
> maybe to hack the code ;) )!

Please make sure your base your patches on something relatively recent
(2.6.13-rc3 or better), else we will face problems when merging your
code in the current driver.

Thanks,
-- 
Jean Delvare

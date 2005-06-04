From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Jun 2005 18:13:08 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050604181344.772e035a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

> > [1] I personally prefer more leading zeros, or better yet none at
> > all.
> 
> Sure, just an example, use what you want.  More is always nice to keep
> things sorted sanely.

ls -v is nice for that purpose too. I would better improve sorting
algorithms were needed than add arbitrary limits were not needed.

That being said, I'd be curious to see a system with more than 10
hardware monitoring chips (record so far is 6 on the Tyan S4882 board).

Thanks,
-- 
Jean Delvare

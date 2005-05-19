From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c oops
Message-Id: <20031115171307.39a4b017.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031115113245.2dd85fba.khali@linux-fr.org>
In-Reply-To: <20031115113245.2dd85fba.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Yes, that would. I invite you to take a look at the kernel/i2c.h
> > file in your local i2c CVS copy to make sure you have i2c_delay()
> > there. Then look at the patch you generated and make check that
> > i2c_delay() is there too. Hopefully you will understand where it
> > does go wrong.
> 
> There's no i2c_delay() in my CVS version of i2c.h either.

So you don't have the latest CVS. I suspect you have some sticky tag set (aren't you by any chance using the deprecated lk2-4 branch?) Start from scratch and it should be OK.

> > Eventually I'll make a patch available for 2.4.23-rc1 if there are
> > enough requests for such a patch.
> 
> I was just wanting to get a "good" way to patch 2.4.23 when it comes
> out so that I wouldn't have to wait for your patches since I know that
> you're probably pretty darn busy.

I understand. I feel myself ashamed to be so slow updating the patch set, but actually I also have other activities (real life or not) so it takes some time before I can have this done.

I'll let you know when a new patch is available.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

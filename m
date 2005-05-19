From: thenders@math.tamu.edu (Troy Henderson)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c oops
Message-Id: <Pine.LNX.4.44.0311150853160.17798-100000@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031115113245.2dd85fba.khali@linux-fr.org>
In-Reply-To: <20031115113245.2dd85fba.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Yes, that would. I invite you to take a look at the kernel/i2c.h file in
> your local i2c CVS copy to make sure you have i2c_delay() there.
> Then look at the patch you generated and make check that i2c_delay() is
> there too. Hopefully you will understand where it does go wrong.

There's no i2c_delay() in my CVS version of i2c.h either.
 
> Eventually I'll make a patch available for 2.4.23-rc1 if there are
> enough requests for such a patch.

I was just wanting to get a "good" way to patch 2.4.23 when it comes out 
so that I wouldn't have to wait for your patches since I know that you're 
probably pretty darn busy.
 
Troy Henderson

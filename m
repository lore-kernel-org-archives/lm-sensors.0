From: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: [patch] 2.5.38 i2c cleanup using module_init/exit
Message-Id: <Pine.LNX.4.44.0209252213060.1203-100000@home.transmeta.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D929339.3821855B@attbi.com>
In-Reply-To: <3D929339.3821855B@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Thu, 26 Sep 2002, Albert Cranford wrote:
>
> No guys.  Not acceptable.  I don't need handling.

It's not about handling. 

Jeff (like me) doesn't have the time to check the i2c CVS tree etc, and 
having somebody (you) do that is invaluable.  

And I'm in the situation that I spend almost all my time already just
merging stuff (check out the actual checkins I've done in the BK tree that
aren't just merges, and you'll see that most of them are pretty trivial),
and Jeff has been doing the "driver merges" into BK tree's, which makes it
simpler for me since I know he actually does look at the patches, and I
already merge with his BK trees anyway.

This is why I like multi-level setups. Not because Jeff is "handling" you, 
but because it means that I have to keep track of fewer things. I'm 
basically lazy.

I have this theory that people can know about 5-10 people well, and after
that they have to spend effort on it. So instead of me merging from 50
people, I'd rather merge from 7, and those 7 can merge from another 7,
etc. Leaving everybody comfortable with the load, instead of people being 
pissed off at me for not merging their patches (which has certainly been 
the case at times ;)

(I also have ulterior motives, which is to make it easier for me to take a
week off every once in a while - just because when there are five or so
people who end up doing the tracking of patches _anyway_. I'm planning on
taking a few weeks off in Australia in January or something ;).

		Linus

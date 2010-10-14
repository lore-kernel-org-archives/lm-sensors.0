From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Oct 2010 11:37:27 +0000
Subject: Re: [lm-sensors] Detection of W83L771W/G in lm90
Message-Id: <20101014133727.658ec6a6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014114626.7c4be041@endymion.delvare>
In-Reply-To: <20101014114626.7c4be041@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexander,

On Thu, 14 Oct 2010 11:58:14 +0200, Alexander Stein wrote:
> On Thursday 14 October 2010, 11:46:26 Jean Delvare wrote:
> > I'm done with the patch adding detection support to the lm90 driver.
> > Here it is, if you want to give it a try. I've tested it on the dump
> > you provided and it worked fine, so I really expect it to work for you
> > too.
> > 
> > If you can't test a kernel patch, I can also provide a standalone
> > version of the lm90 driver.
> 
> Please provide me a standalone driver, as the patch doesn't apply. Neither on 
> my 2.6.34 nor on my git kernel. It seems your lines are messed up.
> > @@ -1237,10 +1237,23 @@ static int lm90_detect(struct i2c_client
> 
> My driver has only 1072 lines.
> > # wc -l lm90.c
> > 1072 lm90.c 

The patch goes on top of 11 other pending patches to the lm90 driver,
that's why it doesn't apply on your vanilla kernel trees. The
standalone driver will be easier to test:

http://khali.linux-fr.org/devel/misc/lm90/

Should work OK with any kernel >= 2.6.32.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

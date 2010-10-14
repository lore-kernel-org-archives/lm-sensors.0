From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Date: Thu, 14 Oct 2010 09:58:14 +0000
Subject: Re: [lm-sensors] Detection of W83L771W/G in lm90
Message-Id: <201010141158.15014.alexander.stein@informatik.tu-chemnitz.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014114626.7c4be041@endymion.delvare>
In-Reply-To: <20101014114626.7c4be041@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hell Jean,

On Thursday 14 October 2010, 11:46:26 Jean Delvare wrote:
> > Thanks a lot you two so far. If you want some testing on chip detection,
> > drop me a line.
> 
> I'm done with the patch adding detection support to the lm90 driver.
> Here it is, if you want to give it a try. I've tested it on the dump
> you provided and it worked fine, so I really expect it to work for you
> too.
> 
> If you can't test a kernel patch, I can also provide a standalone
> version of the lm90 driver.

Please provide me a standalone driver, as the patch doesn't apply. Neither on 
my 2.6.34 nor on my git kernel. It seems your lines are messed up.
> @@ -1237,10 +1237,23 @@ static int lm90_detect(struct i2c_client

My driver has only 1072 lines.
> # wc -l lm90.c
> 1072 lm90.c 

Best regards,
Alexander

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

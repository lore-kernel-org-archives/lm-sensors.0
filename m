From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: i2c-core CVS oopsing 2.4; velleman won't compile
Message-Id: <20031231175915.7f2f0650.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF1F4AF.8000809@verizon.net>
In-Reply-To: <3FF1F4AF.8000809@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i2c-core oopsing for last couple of weeks.
> Also, velleman won't compile.
> 
> Are these my problem or are we in the middle of changes or...?
> 
> Below are velleman compile output, and ksymoops from i2c-core.

I think it's you. Velleman compiles here, and i2c-core doesn't oops
(although if you explain how you get it to oops I could give it a try).

I suspect your hard disk drive is having problems, or you are trying to
compile against broken headers (2.6? you wouldn't dare...). Maybe you
could try a fresh checkout from CVS and see if it works any better.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

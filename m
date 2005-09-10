From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 10 Sep 2005 22:46:12 +0000
Subject: [lm-sensors] Patch: Kernel 2.6 and multiple buses
Message-Id: <20050910224535.2eade133.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43215B5F.7050100@megware.com>
In-Reply-To: <43215B5F.7050100@megware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Karsten,

Quoting myself:
> Thanks a lot for this patch. I had been investigating this bug some
> times ago but could never figure out what the problem was. It's really
> great that you did succeed in finding the reason. I know it'll make a
> few other users happy too.

OK, I committed your patch, and also removed the algorithm name
comparison from the bus match test. Additionally, I dropped some
algorithm stuff from i2cbusses.c (which affects i2cset, i2cdump and
i2cdetect), sensors-detect and sensord, so that people stop wondering
about "unavailable algorithm name" messages.

I would appreciate if you could give a try to lm_sensors CVS and confirm
that it still works OK for you.

Thanks again for your contribution,
-- 
Jean Delvare

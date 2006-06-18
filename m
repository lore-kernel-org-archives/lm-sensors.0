From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Jun 2006 17:02:30 +0000
Subject: [lm-sensors] better temp2 computation for asus CUSL2C
Message-Id: <20060618190230.880689ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060618021736.f08a39bb.gimeshell@web.de>
In-Reply-To: <20060618021736.f08a39bb.gimeshell@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi (no name),

> > http://www.lm-sensors.org/wiki/FAQ/Chapter3#MyBIOSreportsamuchhigherCPUtemperaturethanyourmodules
> > (In particular the last paragraph.)
> 
> Yes that's it!
> Now what would be better way to correct this?

Actually my point was that there is probably nothing to correct.

>                                                Is there any difference
> between both ways?
> 
> a) multiply @ with bigger factor eg 31 instead of 30
> compute temp2 (@*31/43)+25, ...
> 
> b) adding bigger factor, eg 31 instead of 25 to @.
> compute temp2 (@*30/43)+31, ...

How are we supposed to guess? We would need many data points to decide
which is best, and you did provide only one (which may not even be
correct.)

> Why isn't compute line so easy to only add ONE value to @. No
> multiplikation anymore. Only addition. Is this a practical thought?

We use the formula which gives the best result for the applicable range
of temperatures. There's little point in having a slighly more simple
equation if it gives less accurate results.

-- 
Jean Delvare


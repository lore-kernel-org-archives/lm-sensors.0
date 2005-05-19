From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: two questions about w83792d.c for linux-2.4
Message-Id: <BaDBnXyA.1109160099.5409940.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190A90@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190A90@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> I have modified the 792 driver again, according to your suggestion.
> Would you please check it for me when you are free? :-)
>
> Note that:
> (1) All the voltage calculation is done in the driver, the
> sensors.conf does NOT use any multiplier for voltage this time.

Perfect :) Nothing to say, you got it alright this time.

> (2) In the near future, the voltage/fan/temp register macro might
> will be combined into such macros as
> #define W83781D_REG_IN_MAX(nr) ...
> #define W83781D_REG_IN_MIN(nr) ...
> #define W83781D_REG_IN(nr) ...
> so that I can reduce my codes.

Not sure to get exactly what you mean, but merging conversion macros with
access macros doesn't sound good.

Also, for register access, I'd recommend static arrays over complex
macros. Macros are fine when there is a nice mathematical formula to get
the address from the index. When things get more complex and you start
having conditionals in the macro, it becomes inefficient, and static
arrays are better IMHO.

--
Jean Delvare

From: Juerg Haefliger <juergh@gmail.com>
Date: Thu, 16 Dec 2010 15:46:55 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon (dme1737): cleanups
Message-Id: <AANLkTik=YE_JRP8CNeA+8=BU12d6LQ9Fj6RvjaSVar1A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimTbiT_swuiyaHP9rLmN2iUfqPyu_gfq16QY-zv@mail.gmail.com>
In-Reply-To: <AANLkTimTbiT_swuiyaHP9rLmN2iUfqPyu_gfq16QY-zv@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,


> On Thu, Dec 16, 2010 at 05:21:40AM -0500, Juerg Haefliger wrote:
>> Minor cleanups. Mostly removing assignments in if statements to get
>> rid of checkpatch errors.
>>
>> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> Just wondering ... did you run this patch through checkpatch ?
> I did, and got 11 warnings for the unnecessary use of { }.
>
> Not sure if getting rid of checkpatch errors is worth it if you just
> replace the errors with warnings.

Yes I did run it through checkpatch. I'll trade warnings for errors
any time :-) No seriously, I personally think it's bad to not have {}
around single statements. It's not only dangerous but also
inconsistent with the rest of the code. I refuse to remove them from
any of the drivers that I own. Just my personal preference.

...Juerg


> Guenter
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

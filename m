From: grant_lkml@dodo.com.au (Grant Coady)
Date: Tue, 13 Sep 2005 22:36:27 +0000
Subject: [lm-sensors] Re: Query: should I split adm9240 patch?
Message-Id: <80dei1dmq1clqig3qob83bunb956ahl08e@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <vccci15r771u8go9tvrn50mo9e9tss5otl@4ax.com>
In-Reply-To: <vccci15r771u8go9tvrn50mo9e9tss5otl@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
On Tue, 13 Sep 2005 14:32:33 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>
>Hi Grant,
>
>> adm9240 changlog:
>> remove half-bit offset from scaled zero value
>
>BTW, this description doesn't mean anything to me. Can you clarify what
>this change is all about?

@@ -81,6 +81,8 @@ I2C_CLIENT_INSMOD_3(adm9240, ds1780, lm8
 /* generalised scaling with integer rounding */
 static inline int SCALE(long val, int mul, int div)
 {
+	if (val = 0)
+		return 0;
 	if (val < 0)
 		return (val * mul - div / 2) / div;
 	else

Without this change the SCALE function returned ((div / 2) / div) for zero.
>
>> remove i2c read/write debug wrappers
>> change kmalloc + memset to kzalloc
>> convert temperature accessors to Yani Ioannou's dynamic sysfs callbacks
>> convert voltage accessors to Yani Ioannou's dynamic sysfs callbacks
>
>Fan accessors not converted? I'd understand if you did not convert the
>temperature accessors, as there is a single temperature channel, but
>there are two fan channels so there would certainly be a benefit in
>converting fan accessors.

I had not done conversions when I wrote this query, thought the 
conversion would be much more difficult, thus was putting it off, 
turned out quite easy once I realised how it worked.

memory size shrinkage:
old			16472
after cleanup + temp	16120
after vin		14584
after fan		14264

I suppose every litle bit helps?  

>
>> (perhaps some more cleanups)
>>
>> Started on updating adm9240 today, best to know early if the patch
>> should be split -- perhaps cleanups then dynamic sysfs?
>
>Yes I think it would be better to split it in two parts, as you just
>suggest. The dynamic sysfs callbacks alone are a large change, not
>trivial to review, so it'll be easier for me to review if there are no
>additional changes in the way. Whether you start with cleanups or sysfs
>changes is up to you, I don't think it really matters.

Gak, I already sent patch, will review and split it.  And yes, probably 
difficult to review.  Me just stoked on getting it done and working 
after not touching code for months.
>
>Oh, and please make sure that your patches apply cleanly incrementaly
>over 2.6.14-rc1 + your previous adm9240 cleanup patch.

Okay.  Split patch and submit against 14-rc1...  Soon.

Thanks,
Grant.


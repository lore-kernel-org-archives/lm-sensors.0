From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: two questions about w83792d.c for linux-2.4
Message-Id: <20050224075811.322ffef3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190A90@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190A90@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,

> > ...set the "in" file magnitude to 3 (which means divide by
> > 1000).
> 
> I want to add some comment here, since we use "3" as the magnitude
> of voltage now instead of the original "2", I think I should modify
> the program "sensors" 792 part(prog/sensors.chip.c), so that it can
> show the magnitude 3.
> 
> For Example: when we run "sensors"
> VCoreA:    +1.52 V  (min =  +1.40 V, max =  +1.60 V)
> Should be:
> VCoreA:    +1.524 V  (min =  +1.400 V, max =  +1.600 V)
> because the interface in0 in /proc is "1.400 1.600 1.524"
> 
> Do you agree with me?

Technically, you do not *need* to do it. I think we have several drivers
exporting more decimal places than "sensors" displays, because
additional places sometimes add little value and makes the output of
"sensors" a little harder to read.

Now, in the case of the w83792d driver, it is definitely a good idea to
display 3 decimal places for VCoreA and VCoreB, because these are low
value, high resolution inputs. For the other voltages it is less
important but probably still a good idea, except for in7 and in8 because
they don't have the extra accuracy bits. Same for limits, they don't
have the extra accuracy bits so I would not display 3 decimal places,
only 2. That being said you are relatiely free in your choices here and
if you really want to display 3 decimal places for all voltage values,
it's fine with me.

What *is* important however is that you use the same magnitude in
lib/chips.c than the driver uses (here 3 for the voltage inputs). If you
don't, sensors won't show the correct values.

Thanks,
-- 
Jean Delvare

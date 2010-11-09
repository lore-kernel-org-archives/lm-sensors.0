From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Nov 2010 13:51:26 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <20101109145126.08d8012e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Oct 2010 09:43:47 -0400, Arun Raghavan wrote:
> > On Sun, 24 Oct 2010 21:40:38 -0400, Arun Raghavan wrote:
> [snip]
> > There's no reason why overclocking would help. Overclocking will
> > generate more heat, but the time it takes to generate it won't change.
> >
> Since the maximum temperature was higher, I was hoping to see some
> intermediate reading
> between idle and fully-loaded temperatures.
> 
> [snip]
> > Arun, back to your immediate issue, you have two options, either
> > rebuild the coretemp driver with a shorter cache lifetime (replace HZ
> > with HZ/10 in function coretemp_update_device) or access the MSR
> > yourself from user-space (but then you lose all the power of
> > libsensors.)
> >
> Thanks for the suggestion, I will try it. Is it known how frequently the sensors
> actually update the readings?

Arun, are there any results from your tests? I would like to lower the
cache lifetime in the coretemp driver and am looking for real-world
numbers to decide what would be a reasonable duration. 

I could do some experiments on my two coretemp machines, but if you
already have figures available, I'm interested :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

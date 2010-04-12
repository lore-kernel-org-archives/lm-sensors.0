From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Apr 2010 19:11:52 +0000
Subject: Re: [lm-sensors] Coretemp goes up since 2.6.31.4
Message-Id: <20100412211152.4e2a3c42@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100409111733.7bb2b5fa@hyperion.delvare>
In-Reply-To: <20100409111733.7bb2b5fa@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 Apr 2010 19:22:22 +0200, dienet wrote:
> On Sat, 10 Apr 2010 10:07:30 +0200, Jean Delvare <khali@linux-fr.org>  
> wrote:
> 
> 
> > I assume these results are using the original coretemp driver of each
> > kernel. So, you are in one of these cases where the heuristic changes
> > in 2.6. I can't say whether this is correct in your case or not, this
> > heuristic is a horrible mess. But the relevant thing here is that your
> > CPU is actually running _cooler_ in 2.6.33 than in 2.6.31: 71 degrees
> > below the critical limit, instead of 67 degrees below the limit
> > previously. In both cases, you have a huge thermal margin, so it's
> > alright.
> 
> I'm just saying what I see. And I see that sensors show higher temp. on  
> 2.6.33 then on 2.6.31 - that's all I can say.
> Now I'm on 2.6.33.2 and I never see 30 deg. or below. On 2.6.31 30 deg. or  
> below was quite normal (but I don't know if that was the *real* temp).

Again, coretemp is never reporting a real temperature. It is reporting
a margin to a critical, arbitrary limit, which we don't know for sure.
Even if we knew it for sure, the sensor is only accurate when it isn't
too far from the limit. Your CPUs are running cool, way below the
limit, so outside of the sensor's good accuracy range. Neither 2.6.31
nor 2.6.33 is giving you a real temperature.

> > The fact that the high limit has the same value as the critical limit
> > is certainly a bug, as it doesn't make any sense physically.
> 
> Any way to fix it? I can say that this bug is quite old or my system isn't  
> configured for a long time.

No idea, sorry. There are bug reports and patches flying around for the
coretemp driver, but I do not have the time to look into them right now.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

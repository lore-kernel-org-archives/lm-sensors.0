From: Ilyes Gouta <ilyes.gouta@gmail.com>
Date: Sun, 19 Oct 2008 18:56:59 +0000
Subject: Re: [lm-sensors] ATI graphics card temperature -> lm-sensors
Message-Id: <48FB82FB.3000406@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1224420520.19051.5.camel@localhost>
In-Reply-To: <1224420520.19051.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Is there any documentation about the i2c multimedia channel? I'm also 
interested in adding such a feature to my system in order to monitor my 
ATI radeon's (3650HD) temperature/fan.

Regards,
Ilyes.

Hans de Goede wrote:
> Thomas wrote:
>> Hallo,
>>
>> I wonder how difficult it would be to incorporate temperature and
>> fanspeed of ATI graphics cards into lm-sensors.
>>
>> There is the aticonfig tool which provides the data (and more, like
>> clockspeeds, ...):
>> aticonfig --adapter=0 --od-gettemperature
>> aticonfig --pplib-cmd "get fanspeed 0"
>>
>> What would be the best way to do that?
>> I guess I could do if I knew where to start :)
>>
> 
> aticonfig is part of the proprietary driver, so lets forget about that path, 
> besides that we really want to do this as standard in kernel hwmon drivers so 
> that existing lm_sensors aware tools will just pick this info up as one 
> additional sensor in the system.
> 
> I've actually been looking into this, and it should be quite doable. I've 
> looked at how to do this for my radeon 9800pro, so your milage may very with 
> other cards.
> 
> For my 9800 pro there is a standard (and already supported) fintek i2c hwmon IC 
> (I don't remember the exact model) on the card. The big problem was that its on 
> the radeon multimedia i2c channel, for which no in kernel i2c master ("adapter" 
> in kernel / lm_sensor speak) driver exists, now this is fixable by just writing 
> such a driver, but the problem is that the X server in some special cases (ATI 
> all in wonder hardware) actually uses this i2c channel and thus pokes the 
> register of the multimedia i2c controller off the radeon from userspace.
> 
> But in comes modesetting, and it comes to the rescue in this case, as 
> modesetting completely removes the need and ability for userspace to directly 
> poke radeon registers. This has broken all in wonder support, but I'm sure this 
> will get fixed eventually and that is a price we will have to pay for progress.
> 
> In the hwmon case this is actually really good as now the way is free to add 
> multimedia i2c support to the drm driver (and this is something which will be 
> needed to fix the all in wonder cards) and once the i2c multimedia channel is 
> supported as a normal kernel i2c adapter, lm_sensors should just work, atleast 
> for my 9800.
> 
> I've discussed this with Dave Airlie during the Linux Plumbers Conference, and 
> he agreed that adding support for the multimedia i2c channel to the drm driver 
> is the way forward. I've added him to the CC in case he has anything to add.
> 
> If you want to look into adding support for hwmon to ati cards, writing 
> multimedia i2c channel drm driver code would be the first step. I believe Dave 
> Airlied is the person to talk to if you want to do that. I will gladly 
> volunteer as a tester for this. (radeon 9800, radeon x1950 pro)
> 
> Regards,
> 
> Hans
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

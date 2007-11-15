From: Alexander Kiel <alexanderkiel@gmx.net>
Date: Thu, 15 Nov 2007 23:15:21 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <1195168521.6275.27.camel@alex>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> I understand the problem now. In the w83627ehf driver, there is this code:
> static ssize_t
> store_pwm_enable(struct device *dev, struct device_attribute *attr,
>                         const char *buf, size_t count)
> 
> ...
> 
>         if (!val || (val > 2))  /* only modes 1 and 2 are supported */
>                 return -EINVAL;
> 
> That is the "write error: invalid argument" error. The reason this
> code rejects a write of 0 to pwm_enable is because the w83627ehf does
> not have a true "disable" mode. Some other chips will set the pwm
> output to 100% when they are disabled. The w83627ehf doesn't have a
> disable mode. Of course, setting it to manual and storing 255 in the
> pwm would do the same thing.
> 
> That's what pwmconfig (lm_sensors version 2.10.4) does:
>                 # Try pwmN_enable=0
>                 echo 0 > $ENABLE 2> /dev/null
>                 if [ "`cat $ENABLE`" -eq 0 ]
>                 then
>                         # Success
>                         return 0
>                 fi
> 
>                 # It didn't work, try pwmN_enable=1 pwmN%5
>                 echo 1 > $ENABLE 2> /dev/null
>                 echo $MAX > $1
>                 if [ "`cat $ENABLE`" -eq 1 -a "`cat $1`" -ge 190 ]
>                 then
>                         # Success
>                         return 0
>                 fi
> 
> So I *think* the problem is in pwmconfig. But yes, manually writing 0
> to pwm_enable will give you an -EINVAL.
> 
> To be completely honest, I haven't run pwmconfig in a while. I know it
> generally works, but someone should probably post a patch to get it to
> work smoothly with w83627ehf and w83627dhg chips. (I could do that...
> given lots of time :-)

Ok the problem with pwmconfig is the following:

echo 0 > $ENABLE 2> /dev/null outputs actually 0. This is the 0 from the
echo. echo 3 > $ENABLE 2> /dev/null would output 3. I have no clue why
this is the case.

This 0 causes the line echo $MAX > $1 to set pwm1 to 0 instead of 255.
If I add a > /dev/null to the line echo 0 > $ENABLE 2> /dev/null it
works as it should.

So the diff is:
----------------------------------------------------------------------
127c127
<               echo 0 > $ENABLE > /dev/null 2> /dev/null
---
>               echo 0 > $ENABLE 2> /dev/null
----------------------------------------------------------------------

Can you submit this patch? I don't have a reasonable access to the
lm-sensors community.

Second: Can you please tell me what echo 2 > pwm1_enable does on this
chip? Is it an chip automatic fan control? It works great for me. It
puts my fan currently to a 155.

Regards
Alex



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 25 May 2006 14:54:22 +0000
Subject: [lm-sensors] vt1211 patch
Message-Id: <191fb4ca0605250754y4ffe117fucd52fc2c5b37369a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oops, forgot to include the lm_sensors mailinglist...

 > So basically manual control is impossible?

I think so yes, but the datasheet is not clear. I should check with
Via eventually.


> I can either choose fan on or fan auto
> Can you give me a simple way to test the switching off of a fan?
> I experimented multiple values in all the files and I can't get it off.

Let's see if I can remember (I currently don't have access to the
datasheets). Try the following:
cat pwmX (should return 255)
echo 2 > pwmX_enable
echo 100 > pwmX_auto_point4_temp

Now 'cat pwmX' should return 0 do indicate 0% duty-cycle. If your
board has the PWM outputs connected the associated fan should be
turned off. If it is indeed, be careful not to blow anything up!

...juerg



> Besides:
>
> # echo 0> pwm2_auto_point1_temp && cat pwm2_auto_point1_pwm
>
> 2
>
>


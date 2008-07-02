From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Jul 2008 19:18:50 +0000
Subject: Re: [lm-sensors] vt1211 fan control script
Message-Id: <20080702211850.1dfcb2a2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0807021127n6ed962efy3a0a31b2a6dc2b21@mail.gmail.com>
In-Reply-To: <191fb4ca0807021127n6ed962efy3a0a31b2a6dc2b21@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Wed, 2 Jul 2008 11:27:21 -0700, Juerg Haefliger wrote:
> I wrote a little script for manual fan control of the VT1211. It's
> special as it puts the VT1211 PMW controller in automatic mode and
> sets the temp thresholds to extreme levels to simulate manual control.
> This is necessary since the manual mode of the VT1211 is not working.
> 
> Would it be OK to include the script with lm-sensors or should I just
> put it somewhere on the lm-sensors website?

I'm fine either way. It could go in prog/pwm in the lm-sensors package.
Not sure how it would fit in the wiki, it's not exceptionally good at
storing files. Alternatively we could create
http://dl.lm-sensors.org/lm-sensors/scripts/ and put it there. But I
think it will get better visibility in the lm-sensors package, and
source control has its advantages as well.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

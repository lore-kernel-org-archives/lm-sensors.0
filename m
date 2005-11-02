From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 02 Nov 2005 20:26:43 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <20051102202603.3cfd779c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

BTW, Knut...

> Fans:
> ==
> I connected a fan for tests. It?s a Verax fan with 9 pulses / revolution.
> 
> In sensors.conf I used the four dividers 1,2,4,9 instead of the *:
> 
>     set fan1_div *
>     set fan1_min 1000
> 
> Here are the results
> 
> 1:    fan1:     12024 RPM  (min =    0 RPM, div = 1)
> 2:    fan1:     11702 RPM  (min =    0 RPM, div = 2)
> 4:    fan1:     11702 RPM  (min =    0 RPM, div = 4)
> 8:    fan1:     12603 RPM  (min =  999 RPM, div = 8)
> 9:    fan1:     11915 RPM  (min =    0 RPM, div = 2)
> 
> Obviously the fan1_min are ignored most of the time and dividers are not 
> handled correctly.

Dividers work the way they are supposed to. You do not seem to
understand what that way is. I invite you to read the following document:
  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/fan-divisors

Hopefully this will help you understand how it works.

If you use a 9 pulse/rev fan (didn't know these existed...) instead of
standard 2 pulse/rev, you should add the following line to your
configuration file:

  conpute fan1 @*2/9, @*9/2

-- 
Jean Delvare

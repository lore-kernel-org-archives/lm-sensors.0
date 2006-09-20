From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 20 Sep 2006 19:13:06 +0000
Subject: [lm-sensors] lm_sensors trigger pc buzzer beeping continuously
Message-Id: <451192C2.4010505@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <5251aaf50609051620r683eb75fm95d738c444ff86da@mail.gmail.com>
In-Reply-To: <5251aaf50609051620r683eb75fm95d738c444ff86da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> hello all,
> i use a gigabyte mobo(GA-8I915GV-MF)with i915GV chipset and only CPU 
> temperature sensor available.it <http://available.it> shows CPU temp 
> correctly.now i configure it with`sensors-detect` and it detected driver 
> `it87'.the problem is during booting itself after sometime it triggers 
> PC beeping continuously.am <http://continuously.am> quoting results below.
> Driver `it87' (should be inserted):

Maybe you have set up temp alarm in bios to too low level and it starts beep 
when booting because your CPU is hotter. Please provide output of "sensors" so 
we can check the levels.

Thanks,
regards
Rudolf


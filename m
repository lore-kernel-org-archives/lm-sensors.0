From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 05 Nov 2005 23:00:47 +0000
Subject: [lm-sensors] w83627hf, fan speed always high, unchangeable?
Message-Id: <20051105230039.34e812b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43692C12.90301@gmail.com>
In-Reply-To: <43692C12.90301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

> The loud fan was actually the CPU fan (I only discovered that _after_
> I exchanged the power supply fan).  Luckily I could reuse the
> potiometer for the power supply fan for the CPU fan then.  With the
> potiometer on the lowest voltage setting it is much more quieter now
> and testing with the "cpuburn" program for a long time still only had
> a max peak temperature at 68? degrees.  So its sort of a workaround
> solution now, but I'm closer to the original goal.

68 degrees C is quite high, even for a peak value. I wouldn't want any
of my CPUs to reach that temperature.

> I tried it, no difference.  I tried with init=0, but for 2.6.14 it
> should be reset=1, as reset=0/init=0 is the default behaviour, right?
> :)

The default is actually reset=0/init=1.

> Thanks for the great support you all are doing on lm-sensors, its a
> real help.

Thanks for the nice words :') These are really valuable as these are
almost the only reward we ever get. Unhappy users usually make much
more noise than happy ones, and at times this becomes very frustrating,
although I guess it's unavoidable.

-- 
Jean Delvare

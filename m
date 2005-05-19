From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH 2.6] w83781d fan_div code refactoring
Message-Id: <20040318020653.GA21016@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040317220839.373babf0.khali@linux-fr.org>
In-Reply-To: <20040317220839.373babf0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-03-17 22:08:39 +0100]:

> While testing, I found a corner case that isn't handled properly. It
> doesn't seem to be handled by the lm78 and the asb100 either. Setting
> fanN_div before ever reading from the chip or setting fanN_min will make
> use of fanN_min while it was never initialized.
> 
> Mark, can you confirm this behavior with your asb100 driver? Maybe I
> missed something...

You're right, it's a bug...

> While a corner case, we better fix it quickly since it is very likely to
> happen. We used to set fan divisors before fan mins in sensors.conf
> because setting fan divisors was breaking fan mins, and this will
> trigger the bug, since we invite users to run "sensors -s" prior to
> running "sensors".

But it's not real dangerous, since who inits fanX_div without also
init'ing fanX_min immediately after?

> This patch doesn't address the issue. I plan to submit a cross-driver
> patch later for this instead.
> 
> I can think of three ways to solve the issue and would like to hear
> opinions about which we should use:
> 
> 1* In the driver's init function, read fan_mins from the chip so they
> are initialized.
> 
> 2* In the store_fan_div function, call update_device.
> 
> 3* In the store_fan_div function, if data->valid = 0, read the fan_min
> from the chip.
> 
> Each method introduces a slowdown at some point. #1 slows the module
> loading, #2 slows the first "sensors -s", #3 slows setting fan divisors
> (each time). Additionally, #1 and #3 can be said to break the caching
> mechanism we implement in each chip driver.
> 
> I think I would go for #1, but have no strong preference actually.

I prefer #1: it fixes the whole *class* of bugs which can arise from
interactions between set/show functions and uninit'ed <driver>_data
structure elements.  E.g. I can see this type of bug creeping in to
smart PWM control where it could be much more dangerous.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

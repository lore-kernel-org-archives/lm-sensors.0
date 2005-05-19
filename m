From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <20050417125709.771caaaf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> So I see it more as me putting wrong priorities on things, thus 
> I now accept your argument of valid alarm + fan speed display, 
> the 'sufferer' will be fan speed resolution, but that does not 
> matter for ridiculous settings, which is what we want handle 
> with "Just Works".  Agree?

Agreed. We want to handle all cases but with varying level of effort.

If the user doesn't setup anything, we at least want the fan speed
reading to be correct. This is why we have the clock divider increment
on 255 fan reading.

If the user setups things in a correct way (relevant low limit), then we
want to pick the best divider automatically. This is why we have the
divider adjustment in set_fan_min().

If the user setups things in a weird way (ridiculous limit), we don't
care. Of course we don't want this to break, but we don't attempt to
optimize that case in any way.

In particular, we do not want to do anything special when the low limit
is disabled. There are only two valid reasons to disable the limit:
1* No fan is connected. No need to waste our energy on this case,
obviously.
2* The fan is actually running slower that the chip supports. The
current code will switch to the highest divider, which is the correct
thing to do. No additional code is needed.

Disabling the low limit when you have a fan running at a standard speed
is a bad idea, which is why I ask you not to add code to support that
case.

Thanks,
-- 
Jean Delvare

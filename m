From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: interface changes in linux 2.6, lm_sensors 2.8.8
Message-Id: <20040920001258.GC3652@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040916123814.M40115@linux-fr.org>
In-Reply-To: <20040916123814.M40115@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean:

* Jean Delvare <khali@linux-fr.org> [2004-09-16 14:48:44 +0100]:
> I think you have a plan to revert my bogus pwmN -> fanN_pwm interface change.
> I believe that it would be great if you could add support for this in
> libsensors before 2.8.8 is released. That way, people will need to upgrade
> only once for both changes. Since libsensors now has room for one alternative
> name for each feature, you don't need to update the drivers themselves now,
> only the library.

Agreed, I would like to get the library changes in to 2.8.8.  However, I'm not
sure yet what is the scope of the changes.  Right now, I see these:

fan?_pwm	=> pwm?
fan?_pwm_enable	=> pwm?_enable

Are there more?  I think there could be.  So, that forces me to do the driver
work up front anyway.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

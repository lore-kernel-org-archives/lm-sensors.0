From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 05 Sep 2005 18:33:46 +0000
Subject: [lm-sensors] Call for 2.9.2
Message-Id: <20050905183340.0f5cad49.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716170208.7c1f7e3d.khali@linux-fr.org>
In-Reply-To: <20050716170208.7c1f7e3d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Mark,

> As I pointed out on #linux-sensors, there is what I consider to be a
> bug in the /sys/class/hwmon handling: if /sys/class/hwmon is not
> present, SPD/eeproms will be read normally by sensors(1); but if it
> *is* present, then SPD/eeproms will not be found or displayed.
> 
> Even if we plan to get rid of SPD/eeprom reading from sensors(1)
> (which I think is sensible), the current behavior is surprising, to
> say the least.
> 
> I'm sorry I haven't had time to work up a fix - I have a four-day
> weekend coming up during which I should have some time.  At any rate,
> IMO it's a release-stopper.

Any news about this? We're waiting for you. Can you please at least tell
us what you think should be done to address the issue?

Thanks,
-- 
Jean Delvare

From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 31 Aug 2005 05:39:51 +0000
Subject: [lm-sensors] Call for 2.9.2
Message-Id: <20050831033909.GA20694@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716170208.7c1f7e3d.khali@linux-fr.org>
In-Reply-To: <20050716170208.7c1f7e3d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2005-08-30 22:31:52 +0200]:
> OK, so it seems to be the right time for the 2.9.2 release. Philip, are
> you ready to go?

As I pointed out on #linux-sensors, there is what I consider to be a bug in
the /sys/class/hwmon handling: if /sys/class/hwmon is not present, SPD/eeproms
will be read normally by sensors(1); but if it *is* present, then SPD/eeproms
will not be found or displayed.

Even if we plan to get rid of SPD/eeprom reading from sensors(1) (which I
think is sensible), the current behavior is surprising, to say the least.

I'm sorry I haven't had time to work up a fix - I have a four-day weekend
coming up during which I should have some time.  At any rate, IMO it's a
release-stopper.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Feb 2006 10:51:14 +0000
Subject: [lm-sensors] use of struct platform_device vs struct device in
Message-Id: <20060204115114.67845ad2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43E12BDF.1020805@gmail.com>
In-Reply-To: <43E12BDF.1020805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> WRT waiting for 2.9.2,  it would take some months to get updates
> thru -mm and then into mainline.   Certainly drivers could sit in -mm
> until the time is right.

Bad idea from a maintenance point of view. Converting i2c-isa drivers to
platform drivers will be very intrusive, so it's likely that other
patches (bug fixes etc...) with conflict with them, effectively
doubling the amount of work.

I'd better postpone any work related to such conversions until we are
ready to merge them. This also gives us some time to make sure that the
choices I made for the f71805f driver were correct. See the recent
thread started by Hans de Goede for example.

> Actually though, the question I posed was twisted from an OT one;
> Im working on pc8736x_gpio, which is an adaptation of scx200_gpio,
> so its a char-dev.  I was looking for a way to get a struct device that
> I could use in dev_dbg() and friends,
> 
> I may imitate your work in pc87360, just to get some familiarity
> with platform_device, (along with on-topic help ;-), then apply that
> to my gpio project.

You can still do this in your private sandbox if it helps you.

Thanks,
-- 
Jean Delvare


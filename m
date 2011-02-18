From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Feb 2011 08:07:03 +0000
Subject: Re: [lm-sensors] Moving the lis3lv02d driver
Message-Id: <20110218090703.35ea7e90@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195148.GB20826@ericsson.com>
In-Reply-To: <20110217195148.GB20826@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 17 Feb 2011 11:51:48 -0800, Guenter Roeck wrote:

> we discussed moving the lis3lv02d driver to another location earlier. 
> 
> Unfortunately, I don't find the thread anymore, and I don't recall
> if we reached a conclusion where to move it to.

I think you are looking for this thread:
http://www.spinics.net/lists/linux-input/msg11585.html

> Any thoughts ?

I would be happy with _any_ solution which moves the lis3lv02d driver
outside of drivers/hwmon.

The difficulty I see is that hp_accel depends on lis3lv02d, and
hp_accel would normally go to drivers/platform/x86, but lis3lv02d can't
live there. So doing the right thing would need some work to fix the
dependencies.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

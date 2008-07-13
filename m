From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 13 Jul 2008 06:31:32 +0000
Subject: Re: [lm-sensors] [RFC] (almost) booting allyesconfig -- please
Message-Id: <4879A144.8060203@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <for-27-patch1-0@bga.com>	<48768018.2070704@hhs.nl>	<acca8e14e769b2feadee19f1f7448438@bga.com>	<20080711085246.1ead773b@hyperion.delvare>	<48770B5E.7000308@hhs.nl> <20080711093650.4b98e3b7@hyperion.delvare>
In-Reply-To: <20080711093650.4b98e3b7@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org, Samuel Ortiz <samuel@sortiz.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Jean Delvare wrote:
> On Fri, 11 Jul 2008 09:27:26 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> Hi Hans, hi Milton,
>>>
>> <snip>
>>
>>>> One could make a superio driver, and create sub-devices for the IR, 
>>>> I2C, floppy, parallel, etc
>>>> nodes.
>>> There have been proposals to do this, and this would indeed be a very
>>> good idea, but unfortunately nobody took the time to implement this
>>> properly, push it upstream and volunteer to maintain it. The problem is
>>> that you don't need just a "driver", but a new subsystem, that needs to
>>> be designed and maintained.
>> Well, I believe there have been some lightweight superio locking coordinator 
>> patches been floating around on the lm_sensors list, and I have reviewed them 
>> and then a new version was done with my issues fixed.
>>
>> I kinda liked the proposed solution there, it was quite simple, moved all the 
>> generic superio stuff into generic superio code, and added locking for super io 
>> access from multiple drivers, what ever happened to those patches?
> 
> As far as I know, nothing, and this is the problem. Somebody needs to
> step up and call him/herself the maintainer of the new code, and push
> it upstream and convert all the drivers (hwmon, watchdog, parallel
> port...) to make use of it. And I am not the one to do this, I am busy
> enough as is with i2c and hwmon.
>

Ok, I've mailed Jim Cromie, the author of the superio access patches 
from end 2007 and told him we're still interested in this and asked him 
if he is willing to drive this forward.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

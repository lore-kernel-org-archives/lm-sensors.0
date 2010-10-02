From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sat, 02 Oct 2010 12:27:05 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/9] lis3 accelerator feature update
Message-Id: <4CA72519.1070600@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>	<20101002025311.GA25875@ericsson.com> <20101002102528.2955d95a@endymion.delvare>
In-Reply-To: <20101002102528.2955d95a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, "eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org" <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On 10/02/10 09:25, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 1 Oct 2010 19:53:11 -0700, Guenter Roeck wrote:
>> On Fri, Oct 01, 2010 at 07:46:47AM -0400, Samu Onkalo wrote:
>>> This patch set is done to top of 2.6.36-RC5
>>>
>>> Changes are tested only with I2C interface using 8bit sensor since I don't
>>> have other possibilities.
>>>
>>> I send this as RFC since changes may affect functionalities or use cases
>>> which I can't test or I don't know to exist. 
>>>
>> Wonder if there is a better mailing list to get good (or even any) feedback
>> for this patchset. Even though the driver resides in the hwmon directory,
>> it isn't really a hardware monitoring driver. Neither i2c nor hwmon fits well.
>>
>> Ideas, anyone ?
cc lkml?  These are very much device specific so only people who can really
review are those who actually have the part or don't mind spending a fair bit
of time familiarizing themselves with a fairly complex driver.

Perhaps runtime pm ones want to go to the runtime pm guys? That bit isn't
really subsystem specific. I'm quite keen to drive that stuff into some of
my drivers, but haven't done it yet so am not familiar enough with the
infrastructure.

> 
> In an ideal world, people interested in accelerometers would create a
> subsystem for it, declare themselves maintainers of it, and all
> accelerometer drivers which currently leave under drivers/hwmon (hdaps,
> hp_accel, lis3lv02d and maybe ams) would be moved there.
Agreed.
> 
> The current state is very bad, because these drivers are located in a
> maintained subsystem but they don't belong there. This is what
> motivated my request to move these drivers away [1]. But as you can see
> nobody replied.
Dmitry often takes a little while to reply, so I wouldn't give up hope yet.

Sadly, despite numerous people wading in from time to time to tell use we
are doing it all wrong, those who actually are interested day to day in
these sorts of devices are far too thin on the ground.

Personally, if no one responds from input, I'd just push this driver
into misc asap.  Can't seen anyone objecting to that.
> 
> [1] http://www.spinics.net/lists/linux-input/msg11411.html
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

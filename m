From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Sun, 19 Jun 2005 18:47:25 +0000
Subject: [lm-sensors] Re: w1-dev
Message-Id: <20050619204650.1af70a33@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506141239.28609.bgardner@wabtec.com>
In-Reply-To: <200506141239.28609.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 17 Jun 2005 11:03:39 -0400
<BGardner@Wabtec.com> wrote:

> Hi Evgeniy,
> 
> <quote>
>  - there is kernel policy to not include new functionality without
> it's users, so you need to push eeprom driver into w1 subsystem :) 
> </quote>
> 
> I plan on doing that eventually. 
> The family 23 driver will need a 512 byte eeprom sysfs entry, and I'd
> like to cache the data.
> 
> I'll need to make these changes to the w1 family stuff:
>  1. The family drivers need private storage in each slave
>  2. Add optional add/remove functions when a slave is added.
>     This is needed to add sysfs entries and allocate private memory.

This looks ok to me.

> <quote>
>  - I want to move w1 notifications to kernel connector, when it will be
> put into mainline (if it will be), so notification part of w1
> and new dev interface could be much simplified with it.
> </quote>
> 
> I didn't find any examples of using the connector code in 2.6.12-rc5-mm2
> on-line.
> Would you point me to an example of how to use that feature?
> 

You can find example test module and some design and interface
documentation in Documentation/connector/.

> <quote>
>  - I personally hate strings :), I do not insist, but why 
> strings, but not binary data, like i2c does?
> </quote>
> 
> I agree. Switching to binary would eliminate a fair amount of code.
> Once I figure out that connector/netlink stuff, I'll change that.
> 
> I just need to find some time to work on it. =)

Ok :)

> Thanks,
> Ben
> 


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt

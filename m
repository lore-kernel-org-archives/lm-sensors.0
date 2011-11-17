From: MyungJoo Ham <myungjoo.ham@gmail.com>
Date: Thu, 17 Nov 2011 08:22:03 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/2] HWMON: add in-kernel interfaces to
Message-Id: <CAJ0PZbR=8PPKNNREOBXL1U8To+jjp9=gkQz_NKUVKU8DhyWPJQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320389433-1671-1-git-send-email-myungjoo.ham@samsung.com>
	<1321044403.2757.23.camel@bwh-desktop>
	<CAJ0PZbQsTYZvoVMgZ_L5uPUxCTbzH72zzUqUkvXNnmqiDOGY=g@mail.gmail.com>
	<4EC1444E.5080108@cam.ac.uk>
In-Reply-To: <4EC1444E.5080108@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Ben Hutchings <bhutchings@solarflare.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, dg77.kim@samsung.com, kyungmin.park@samsung.com

On Tue, Nov 15, 2011 at 1:39 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 11/14/2011 01:31 AM, MyungJoo Ham wrote:
>> On Sat, Nov 12, 2011 at 5:46 AM, Ben Hutchings
>> <bhutchings@solarflare.com> wrote:
>>> On Fri, 2011-11-04 at 15:50 +0900, MyungJoo Ham wrote:
>>>> We have been reading hwmon values (TMU, the SoC-core temperature senso=
r,
>>>> and NTC, the ambient or battery surface temperature sensor) for
>>>> Charger-Manager. However, because hwmon does not have in-kernel interf=
ace,
>>>> we have been using undesired method, including "../../../fs/*.h".
>>>>
>>>> This patch is to provide in-kernel interface for hwmon:
>>>> hwmon_get_value and hwmon_set_value. In order to use these two functio=
ns,
>>>> the hwmon driver should provide its sysfs attributes to hwmon framework
>>>> as well. If the hwmon driver does not provide (by providing NULL), the=
 users
>>>> of the hwmon won't be able to use hwmon_get/set_value();
>>>> The sysfs attribute (struct attribuyte_group *) is provided with
>>>> hwmon_device_register; adding the second parameter to hwmon_device_reg=
ister().
>>>> The 2/2 patch shows the changes in device drivers due to this.
>>> [...]
>>>
>>> This is an improvement, but I don't think it is quite enough. =A0As I
>>> understand the hwmon sysfs interface, all sensor values should be
>>> integers. =A0So the in-kernel interface should also work with integers,
>>> not strings.
>>>
>>> As a first implementation you could perhaps parse the strings back to
>>> integers. =A0However in the longer term the driver API should be changed
>>> so that hwmon drivers fully describe their sensors to the core and the
>>> core takes care of exposing them through sysfs and the in-kernel API.
>>
>> I agree.
>>
>> I'll let it the in-kernel interfaces provide integer value although it w=
ill
>> simply parse strings as you've addressed until we have some other
>> interfaces for sysfs entries in hwmon device drivers.
>>
>>
> To throw another option into the mix, you could make it an IIO driver
> and sit hwmon on top of that (there is already a simple driver for
> doing this) - IIO has in kernel interfaces of the type
> you want. =A0Not everything is there yet though.
>
> Jonathan

Yes, we may alter the HWMON drivers to be IIO drivers as well.

However, to me, at least for the HWMON devices I've been looking, IIO
seems to be an overkill and more complex than needed for the target
devices.

Thanks.


Cheers!
MyungJoo
--=20
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

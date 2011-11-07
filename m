From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Mon, 07 Nov 2011 04:35:36 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/2] HWMON: add in-kernel interfaces to
Message-Id: <CAJ0PZbQsvz36uN4MDf5EmB_88ttP=5v7JhbB-D5+wE6W5_4BcQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320389433-1671-1-git-send-email-myungjoo.ham@samsung.com>
	<20111106055343.GA21533@ericsson.com>
In-Reply-To: <20111106055343.GA21533@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "dg77.kim@samsung.com" <dg77.kim@samsung.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>

On Sun, Nov 6, 2011 at 2:53 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Fri, Nov 04, 2011 at 02:50:31AM -0400, MyungJoo Ham wrote:
>> We have been reading hwmon values (TMU, the SoC-core temperature sensor,
>> and NTC, the ambient or battery surface temperature sensor) for
>> Charger-Manager. However, because hwmon does not have in-kernel interfac=
e,
>> we have been using undesired method, including "../../../fs/*.h".
>>
>> This patch is to provide in-kernel interface for hwmon:
>> hwmon_get_value and hwmon_set_value. In order to use these two functions,
>> the hwmon driver should provide its sysfs attributes to hwmon framework
>> as well. If the hwmon driver does not provide (by providing NULL), the u=
sers
>> of the hwmon won't be able to use hwmon_get/set_value();
>> The sysfs attribute (struct attribuyte_group *) is provided with
>> hwmon_device_register; adding the second parameter to hwmon_device_regis=
ter().
>> The 2/2 patch shows the changes in device drivers due to this.
>>
>> Among the HWMON device, all but ntc_thermistor.c does not setup attribut=
e_group
>> for HWMON; thus they do not support hwmon_get/set_value with this patch.
>>
>> As soon as the server synchronizes git repositories, you can see how
>> hwmon_get_value() is used at:
>> http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/he=
ads/charger-manager
>>
> Hi,
>
> I agree that we'll need a solution for the callback problem at some point.
> However, I have a number of concerns with the approach used in your patch=
 set.
>
> The first patch breaks compilation. It changes the API w/o making the sam=
e changes
> in the affected drivers. This is unacceptable. Each patch of a patch seri=
es must
> result in working code.

Hello,

I simply thought having a single patch with API change and device
driver change altogether too ugly.
Anyway, by adding another API function to add get/set properties to
HWMON drivers, the need for this issue will disappear.

>
> Merging functionality into one function and then breaking out again, as y=
ou do with
> the set/get functions, results in unnecessarily complexity.
> =A0 =A0 =A0 =A0{set, get} -> access(flag) --> {set, get}
> Better write separate functions and keep the common code in a function ca=
lled by the
> {set, get} functions.

Ok.

>
> We should not have to change the API for every caller, especially if many=
 of those will
> never benefit from the new API. It would be better to define a new API fu=
nction and map
> the old API function to the new one. Saves a lot of calls with unnecessar=
y "NULL" parameter,
> and coincidentially reduces the patch size and avoids the breakage mentio=
ned above.
>

Good. I'd like to add a new API function for this functionality, too.
I guess that it'd be easier to address your following comments by
adding another API function.

> The get and set functions are extremely expensive, having to loop through=
 the list
> of attributes and performing a string comparison on each attribute to fin=
d the sensor.
>
> The proposed change only works for a small subset of drivers, those with =
a well defined
> single attribute groups. If and when we implement a solution for the inte=
rnal-API
> problem, it should work for all hwmon drivers, not only for a small subse=
t.
>
> Thanks,
> Guenter
>
>

Thank you.


Cheers!
MyungJoo

--=20
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

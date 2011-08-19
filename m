From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Fri, 19 Aug 2011 13:13:53 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6 V2] hwmon: OMAP4: On die
Message-Id: <CAJ6a13b17aAyQeumdqjAVR9Fs7mP6J-b9f+bJe+B6Dk0SXw3qg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
	<1313664735-8917-7-git-send-email-j-keerthy@ti.com>
	<20110819021333.GA27544@ericsson.com>
	<CAJ6a13b6EQNhkQ+i5vf0kxKJ3RadY7iSCSJwZ5_sd3Y0BydUow@mail.gmail.com>
	<20110819061745.GA28832@ericsson.com>
In-Reply-To: <20110819061745.GA28832@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Aug 19, 2011 at 11:47 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Fri, Aug 19, 2011 at 02:04:58AM -0400, J, KEERTHY wrote:
>> On Fri, Aug 19, 2011 at 7:43 AM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > On Thu, Aug 18, 2011 at 06:52:15AM -0400, Keerthy wrote:
>> >> On chip temperature sensor driver. The driver monitors the temperatur=
e of
>> >> the MPU subsystem of the OMAP4. It sends notifications to the user sp=
ace if
>> >> the temperature crosses user defined thresholds via kobject_uevent in=
terface.
>> >> The user is allowed to configure the temperature thresholds vis sysfs=
 nodes
>> >> exposed using hwmon interface.
>> >>
>> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> >> Cc: Jean Delvare <khali@linux-fr.org>
>> >> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>> >> Cc: lm-sensors@lm-sensors.org
>> >
>> > High level review:
>> >
>> > - too much and too broad mutex locking. show functions should not need=
 locks at all,
>> > =A0set functions only while data is written into registers and into pl=
atform data.
>>
>> Ok. I will clean this.
>>
>> > - driver is quite noisy. There should definitely not be any log messag=
es
>> > =A0if a set parameter is wrong. Show functions already return an error=
 value
>> > =A0to the user; a log message indicating the error again just creates =
noise.
>> > =A0For one boolean set during probe (is_efuse_valid), each subsequent =
show results
>> > =A0in a log message if it is false. Some errors result in multiple log=
 messages.
>>
>> A user tries to set an invalid temperature threshold. The user should
>> be notified about this. The invalid temperature will not be set. The user
>> should not be allowed to set an invalid temperature. It is to inform
>> the user about precisely the problem with the parameter.
>>
> User is notified with -EINVAL. Unless on the console, which is unlikely,
> the user will likely not notice a message in the kernel log.

These messages on console are useful for debug purpose
so can i place it under dev_dbg? Only on explicit enabling
these messages can be seen.

>
>> In some of the samples the bandgap is not trimmed and hence
>> temperature reported will be wrong. So every time a user tries to read
>> he is alerted that the temperatures are not accurate.
>>
> In the kernel log ? Sorry, that doesn't make sense. You alert the system =
administrator,
> not the user.

Ok. Can this be a dev_dbg message? Only for debug purpose
this can be useful.

>
> Guenter
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

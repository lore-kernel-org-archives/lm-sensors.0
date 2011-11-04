From: =?ISO-8859-1?Q?Lars_Nood=E9n?= <lars.nooden@gmail.com>
Date: Fri, 04 Nov 2011 10:27:33 +0000
Subject: Re: [lm-sensors] Hardware running hot and without the fan
Message-Id: <4EB3BE15.3070009@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EB1108F.6070009@gmail.com> <20111103020301.GA22333@ericsson.com> <4EB250FD.3070000@gmail.com> <20111103134902.GA26121@ericsson.com> <4EB2A46B.8080600@gmail.com> <1320332801.2309.60.camel@groeck-laptop> <4EB2B0FD.309@gmail.com> <20111103174635.GA12229@polaris.bitmath.org>
In-Reply-To: <20111103174635.GA12229@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Henrik Rydberg <rydberg@euromail.se>
Cc: guenter.roeck@ericsson.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 11/3/11 7:46 PM, Henrik Rydberg wrote:
> On Thu, Nov 03, 2011 at 05:19:25PM +0200, Lars Nood=E9n wrote:
>> On 11/03/2011 05:06 PM, Guenter Roeck wrote:
>>> On Thu, 2011-11-03 at 10:25 -0400, Lars Nood=E9n wrote:
>> [snip]
>>>> The one machine reports one fan and the other two fans.  I haven't fou=
nd
>>>> a way to set the fan speed manually.  The output from sensors
>>>> is
>>>>  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/881593/comments/=
44
>>>> and here
>>>>  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/881593/comments/=
47
>>>
>>> Do the fans actually turn, or is the output bogus ?
>>
>> The output is bogus, the fans are not turning.  On #47 there above, I
>> think the temperatures might be inaccurate, too.  Since they'll go up
>> and down as much as 8 degrees in a few seconds.
>>
>>> You should be able to set the fan speed by writing into the fanX_input
>>> and/or fanX_output sysfs attributes. You find those
>>> in /sys/class/hwmon/hwmon0/device (assuming there is only one hwmon
>>> device).
>>
>> I can set the fan speed manually.  e.g.:
>>
>>  echo 3500 > /sys/class/hwmon/hwmon0/device/fan1_output
>>
>> That helps some.
>=20
> I am confused.
>=20
> From what I gather, the fans work, and it should be possible to run
> the macfanctld daemon (not fancontrol) to tune the fans.

On the note book, one fan works with manual control only.  If there is a
second fan, it cannot be turned on manually.  On the mini, there are no
fan devices listed in /sys/class/hwmon/hwmon0/device/

> If there really is a problem with the applesmc, following
> http://ubuntuforums.org/showthread.php?t=3D924096 is a good idea.
>=20
> However, the root problem is most likely the GPU consuming too much
> power. Depending on the exact laptop model, there may or may not be a
> viable workaround. If you model is very new, there is most likely and
> active thread about it on the ubuntu forums.

Not that I've been able to find and an attempt at starting a new thread
has no response.

> After checking around on the forums, if you find that this is still a
> fan or temperature sensor problem, and not a GPU problem, then please
> restate the problem as exactly as you can.

I think there are two problems.  One is the GPU or some other part
running hot.  The other is the sensors/fans issue: the fans don't turn
on even when the system is hot.  Both problems are evident on two
different models of hardware, the notebook is a MacBookPro8,2 and the
desktop is a Macmini3,1.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/881593

/Lars

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

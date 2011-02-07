From: Andrew Lutomirski <luto@mit.edu>
Date: Mon, 07 Feb 2011 16:50:48 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <AANLkTiksw+sR0ffGZ1fwSN7c31bdvG6vdqvde65vOc8Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Feb 7, 2011 at 9:57 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Mon, Feb 07, 2011 at 09:47:22AM -0500, Guenter Roeck wrote:
> [ ... ]
>> >
>> > The second line happens on the first call to 'sensors'. =A0Rebooting
>> > triggers it again, but rmmod/insmod does not.
>> >
>> That is as expected. The driver loads the sensor value, detects that it =
is out of range,
>> and automatically adjusts the divisor register.
>>
>> Usually, in other drivers, it is possible to write into the divisor regi=
ster.
>> This can then be used to initialize the divisor to a reasonable value at=
 startup.
>> For some reason that is not implemented for this driver; I don't know wh=
y.
>>
>> > Should the driver just fix up the divisors on load instead of on first=
 read?
>> >
>> No, the divisor should be writable so you can initialize it at startup.
>> I'll see if I can fix that.
>>
> Ok, I know the reason. The divider is set automatically when the minimum =
speed is configured.
> This is because both the current speed and the minimum speed are affected=
 by the divider
> settings, and the divider value has to work for both.
>
> So what you'll have to do is to set a minimum speed, and the problem will=
 go away.

I admit I'm a bit confused as to what fan2_min does.  I have a minimum
(to warn?) fan speed set in BIOS, which seems to have nothing to do
with the initial value of fan2_min.  Changing fan2_min will cause
fan2_alarm to become set or unset, when I decrease min below input,
alarm stays set until I read it once.

This is rather curious -- it means that the sequence:
echo 200 >fan2_min
echo 100 >fan2_min
cat fan2_input
cat fan2_alarm

shows alarm=3D0 but

echo 200 >fan2_min
echo 100 >fan2_min
cat fan2_alarm
cat fan2_input

shows alarm=3D1

In any case, what does alarm (and, hence, min) do?  Userspace can
compare two numbers on its own, but no uevent seems to be generated
when an alarm is hit.

--Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

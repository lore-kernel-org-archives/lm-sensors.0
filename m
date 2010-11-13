From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Sat, 13 Nov 2010 07:21:58 +0000
Subject: Re: [lm-sensors] Location for thermal drivers
Message-Id: <AANLkTikPt09Xdr_wvjmXhdPD8UdA-7b=AJjC+zgn8PA4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289594026.22931.388.camel@groeck-laptop>
	<AANLkTimERGh2yGGX_E_N4ajxg_-0QTFS54QSKj2+AAfF@mail.gmail.com>
	<1289599600.22931.406.camel@groeck-laptop>
In-Reply-To: <1289599600.22931.406.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: guenter.roeck@ericsson.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Nov 12, 2010 at 2:06 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Fri, 2010-11-12 at 16:53 -0500, Phil Pokorny wrote:
>> On Fri, Nov 12, 2010 at 12:33 PM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > I think a better location for the driver would be drivers/thermal.
>> > drivers/hwmon is not really a good fit, since hwmon support for thermal
>> > drivers is optional.
>>
>> What is the difference between a "thermal" sensor and a "temperature"
>> sensor? =A0Aren't they the same thing?
>>
> The thermal framework is much more extensive than the hwmon framework.
> See Documentation/thermal/sysfs-api.txt for details.

Ahh...  Sorry for wasting your time without reading the necessary
background first.  I have rectified this oversight.

Reading the thermal sysfs-api and code, it's seems clear that it is a
very ACPI centric kind of thing.  It's involved in the coordination of
temperatures and the ways (fans, throttle algorithms, etc.) to keep
them in check.  It makes regular calls into the ACPI parser to
evaluate values.

But this driver that Alan has written seems to be a hwmon driver.
It's poking at registers, setting up A2D channels and dealing with
thermistors and perhaps voltages?  Those are very hwmon like things
for a driver to do.

It appears to be very similar to the coretemp and k10temp drivers that
read temperatures from the internals of the CPU.

I vote for hwmon rather than drivers/thermal...

Phil P.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

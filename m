From: Martin Peres <martin.peres@free.fr>
Date: Fri, 04 Mar 2011 08:36:13 +0000
Subject: Re: [lm-sensors] [Nouveau]  hwmon API update
Message-Id: <4D70A47D.7090209@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110213171640.GB13323@ericsson.com>
	<20110213230833.0ee2ff16@endymion.delvare>
	<AANLkTindG=m4FhNS202MH8YVBUCoDEADTQLxo-Bf_8qx@mail.gmail.com>
	<20110303152216.GA21667@ericsson.com> <4D6FCFF2.7040604@free.fr>
	<1299185295.2255.13.camel@workstation>
	<1299187158.18605.28.camel@groeck-laptop>
	<1299189416.2255.22.camel@workstation>
	<1299189822.18605.35.camel@groeck-laptop>
	<4D7029E8.4040706@free.fr> <20110304005900.GB31318@ericsson.com>
In-Reply-To: <20110304005900.GB31318-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, nouveau <Nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Le 04/03/2011 01:59, Guenter Roeck a =E9crit :
> On Thu, Mar 03, 2011 at 06:53:12PM -0500, Martin Peres wrote:
> [ ... ]
>>>>> Guenter
>>>> This is a bigger change than we initially aimed for and I didn't dare =
to
>>>> ask for such a heavy modification, but I'm very happy with this soluti=
on
>>>> if you prefer and support it this way.
>>> If done right, it should be much less invasive than the previous
>>> approach - meaning existing drivers would not have to be modified and
>>> can be converted as time permits.
>> The previous solution already permitted that, but anyway, it's good to
>> see you welcome change.
> It touched all drivers. It did not move anything out of drivers, forcing =
drivers
> supporting the new functions to support both sysfs _and_ the new function=
s.
> Significant difference.
>
> The idea here - at least mine - is to move sysfs attribute management
> into core hwmon code.
>
> Guenter
oh, yes, It touched a bit every driver but I already proposed the sysfs=20
management
to be in the hwmon core, the advantage of the solution Matthew Garrett=20
proposed was
good because it allowed the transition from the old to the new API to=20
happen smoothly.

Anyway, I'm really interested in the solution you'll come up with, I=20
don't mean to say
Matthew's solution is the best possible ;)

Martin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

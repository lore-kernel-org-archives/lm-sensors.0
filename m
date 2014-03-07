From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 07 Mar 2014 15:37:17 +0000
Subject: Re: [lm-sensors] Tachometer speed returned rather than absolute fan speed?
Message-Id: <20140307163717.336873f5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOMwXhPXPN+21N11cHBENvw0QZ1qPvo9GTbM9V2SwDmgBQZssw@mail.gmail.com>
	<20140307162524.6abd34be@endymion.delvare>
	<CAOMwXhOB=1HA57jwKCx3-hU8A_ypjrm0J3R9huO25xa4B_gw8w@mail.gmail.com>
In-Reply-To: <CAOMwXhOB=1HA57jwKCx3-hU8A_ypjrm0J3R9huO25xa4B_gw8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laszlo Papp <lpapp@kde.org>
Cc: LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

On Fri, 7 Mar 2014 15:31:44 +0000, Laszlo Papp wrote:
> On Fri, Mar 7, 2014 at 3:25 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > Hi Laszlo,
> >
> > On Fri, 7 Mar 2014 14:48:01 +0000, Laszlo Papp wrote:
> >> In medias res, I find this interface cumbersome:
> >> http://lxr.free-electrons.com/source/Documentation/hwmon/max6650#L31
> >>
> >> It returns tachometer speed rather than actual fan speed when you deal
> >> with the fan1_target interface. That would be way more convenient for
> >> end users like me.
> >>
> >> Is there any reason for not returning absolute fan speed? I guess,
> >> this would break the behavior now. However, that would be a really
> >> useful convenient feature. Is it possible to add a new interface for
> >> that?
> >
> > I'm quite confused. While I admit that the term "tachometer speed" is
> > awkward, the max6650 driver is reporting fan speeds in RPM as every
> > other hwmon driver. So I really have no idea what you think is wrong.
> > What did you think "tachometer speed" was, if not the fan speed? Does
> > the max6650 driver not return correct fan speeds for you?
> 
> I was just writing a patch to improve the documentation. Tachometer
> value is not equal to the fan speed, and using the terms together is
> confusing. It should probably read as follows:
> 
> "absolute fan speed in RPM based on the corresponding tachometer
> value" or something similar. I just did not get the meaning of two
> different values together, and I think that confused me, especially
> since get_fan and get_target are doing slightly different
> computations, so it took me a while to figure this out from the
> datasheet.
> 
> Better wording would have definitely helped in here. Fwiw, I asked
> another kernel hacker person who also got confused telling me that he
> would not know without reading the source code. I think that it is an
> indication to improve the documentation. There might be better
> alternatives than the one I am proposing, but at least that one clears
> up that for me.

I agree. I think I would just go with "measured fan speed in RPM", as
tachometer is quite a technical term and the user doesn't need to know.
Care to send a patch?

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

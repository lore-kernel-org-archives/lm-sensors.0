From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 07 Mar 2014 15:25:24 +0000
Subject: Re: [lm-sensors] Tachometer speed returned rather than absolute fan speed?
Message-Id: <20140307162524.6abd34be@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOMwXhPXPN+21N11cHBENvw0QZ1qPvo9GTbM9V2SwDmgBQZssw@mail.gmail.com>
In-Reply-To: <CAOMwXhPXPN+21N11cHBENvw0QZ1qPvo9GTbM9V2SwDmgBQZssw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laszlo Papp <lpapp@kde.org>
Cc: LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

Hi Laszlo,

On Fri, 7 Mar 2014 14:48:01 +0000, Laszlo Papp wrote:
> In medias res, I find this interface cumbersome:
> http://lxr.free-electrons.com/source/Documentation/hwmon/max6650#L31
> 
> It returns tachometer speed rather than actual fan speed when you deal
> with the fan1_target interface. That would be way more convenient for
> end users like me.
> 
> Is there any reason for not returning absolute fan speed? I guess,
> this would break the behavior now. However, that would be a really
> useful convenient feature. Is it possible to add a new interface for
> that?

I'm quite confused. While I admit that the term "tachometer speed" is
awkward, the max6650 driver is reporting fan speeds in RPM as every
other hwmon driver. So I really have no idea what you think is wrong.
What did you think "tachometer speed" was, if not the fan speed? Does
the max6650 driver not return correct fan speeds for you?

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

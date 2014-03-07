From: Laszlo Papp <lpapp@kde.org>
Date: Fri, 07 Mar 2014 15:08:02 +0000
Subject: Re: [lm-sensors] Tachometer speed returned rather than absolute fan speed?
Message-Id: <CAOMwXhOWdvzPg8yFTBz6UcMENo=h1GmEGa26jnPDsK-RBD51Jg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOMwXhPXPN+21N11cHBENvw0QZ1qPvo9GTbM9V2SwDmgBQZssw@mail.gmail.com>
In-Reply-To: <CAOMwXhPXPN+21N11cHBENvw0QZ1qPvo9GTbM9V2SwDmgBQZssw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>

On Fri, Mar 7, 2014 at 2:48 PM, Laszlo Papp <lpapp@kde.org> wrote:
> Hi,
>
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

It might also just well be a sloppy documentation... 'cause I am
currently struggling to understand how to get the actual fan speed out
of that value ... or is it just so it already returns the absolute fan
speed and there is some logic in the driver (get_fan) function that I
do not understand?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Laszlo Papp <lpapp@kde.org>
Date: Fri, 07 Mar 2014 14:48:01 +0000
Subject: [lm-sensors] Tachometer speed returned rather than absolute fan speed?
Message-Id: <CAOMwXhPXPN+21N11cHBENvw0QZ1qPvo9GTbM9V2SwDmgBQZssw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>

Hi,

In medias res, I find this interface cumbersome:
http://lxr.free-electrons.com/source/Documentation/hwmon/max6650#L31

It returns tachometer speed rather than actual fan speed when you deal
with the fan1_target interface. That would be way more convenient for
end users like me.

Is there any reason for not returning absolute fan speed? I guess,
this would break the behavior now. However, that would be a really
useful convenient feature. Is it possible to add a new interface for
that?

Cheers, L.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

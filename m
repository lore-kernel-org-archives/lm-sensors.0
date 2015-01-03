From: "G. Richard Bellamy" <rbellamy@pteradigm.com>
Date: Sat, 03 Jan 2015 22:30:30 +0000
Subject: Re: [lm-sensors] SuperMicro H8DG6-F-O IPMI BMC and lm_sensors
Message-Id: <CADw2B2OifHO0Pw8cyX-Grnrv7CtmcN336vYwTsRu-Mq0PChzcg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADw2B2PqoMeXkr0yVPbn_R=z17yM6F1QgefYwBmvaqHHqtCDKA@mail.gmail.com>
In-Reply-To: <CADw2B2PqoMeXkr0yVPbn_R=z17yM6F1QgefYwBmvaqHHqtCDKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 2, 2015 at 12:53 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> You should stick with IPMI. The reason that you can not see the w83795 in the
> output of the 'sensors' command is that the memory space for accessing the i2c
> controller (i2c-i801 driver) is reserved by ACPI. You can override that,
> and connect to the controller anyway, but then you risk the above mentioned
> crashes. You would have to disable the BMC (if that is possible) if you want
> to access the chip through lm-sensors.

Thanks Guenter,

So, the next step for me is to see if there's a way to get sysstat to
function without the lm_sensors dependency.

This email was originally going to be directed to the developer of
sysstat, since i had surmised I was out of luck with lm_sensors. I
figured I should do my due diligence before I headed down that path,
but now that I've had confirmation, I'll contact Mr. Godard. That
being said - I welcome any pointers from folks on this list on how
others have solved this same issue.

Regards,
Richard

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

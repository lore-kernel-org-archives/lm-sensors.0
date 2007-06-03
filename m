From: "Roger Lucas" <roger@planbit.co.uk>
Date: Sun, 03 Jun 2007 12:47:25 +0000
Subject: Re: [lm-sensors] Converting vt8231 to a platform driver
Message-Id: <002201c7a5dd$56315ea0$8001a8c0@wolverine>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603135804.3aa2b7fb@hyperion.delvare>
In-Reply-To: <20070603135804.3aa2b7fb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Not a problem - I'll sort it out and put a patch in.  I have a fairly busy
week and will have to put a system together to test it on as all my VT8231
board have been mothballed, so I suspect it will take me about a week to get
it all changed and tested.  Is that timescale OK or do you need it sooner?

Thanks,

Roger.

P.S.  I was sorry to hear that you stepped down as the Hardware Monitoring
System Maintainer, but I'm glad to know that you are still active behind the
scenes.

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: 03 June 2007 12:58
> To: Roger Lucas
> Cc: LM Sensors
> Subject: Converting vt8231 to a platform driver
> 
> Hi Roger,
> 
> I would like to get rid of i2c-isa soon now. One of the last few users
> is your vt8231 driver. It needs to be converted to a platform driver
> before I can delete i2c-isa. Would you possibly take care of it? The
> conversion should be similar to what I did for the via686a driver a few
> days ago:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019838.html
> 
> Thanks,
> --
> Jean Delvare


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

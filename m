From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Sensor results of P4P800
Message-Id: <20031209055735.GA15110@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
In-Reply-To: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mori Hiroyuki <hiro_yuki_mori@yahoo.co.jp> [2003-12-08 01:30:32 +0900]:
> Now, I tried to set vrm to 9.0 based on doc/vid
> information with following command.
> Currently I'm using Petimum4 3GHz. In this case, I should
> be set vrm=9.0. Is this correct?

Yes.

> # echo 9.0 >/proc/sys/dev/sensors/w83627thf-isa-0290/vrm
> 
> After this, I read vid value.
> 
> # cat /proc/sys/dev/sensors/w83627thf-isa-0290/vid
> 0.000
> 
> I still get 0.000. Why?

The w83627thf driver support for VID is broken.  I'll be
fixing that shortly - hopefully in time for the 2.8.2 release.
Please check back in about a week.

> >As for the VCore 1 readings, you might need to divide the
> value by 2.
> >Never see that before though.
> OK. I guessed so.

I think the driver is broken here as well.  Again I hope
to fix this soon.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

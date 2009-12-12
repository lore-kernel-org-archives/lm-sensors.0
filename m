From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Sat, 12 Dec 2009 10:48:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for VIA CPU core
Message-Id: <4B2374F1.7010400@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090609083406.GE25316@prithivi.gnumonks.org>
In-Reply-To: <20090609083406.GE25316@prithivi.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I would
> appreciate if someone could test it and report, just to make sure I
> didn't accidentally break the driver with my clean-ups. Thanks.

I've been using it for the last few hours on an EPIA M700 (1GHz C7) and it 
seems to work fine.

I still don't get any output through "sensors" though:

$ sensors
via-cputemp-isa-0000
Adapter: ISA adapter

I'm guessing because on line 118 the name is set to "via-cputemp" with a dash, 
instead of DRVNAME.

sysfs and GKrellM seem to report accurate temperatures though.

Cheers,
Adam.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

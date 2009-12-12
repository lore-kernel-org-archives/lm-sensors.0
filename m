From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Dec 2009 13:57:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for VIA CPU core
Message-Id: <20091212145712.4faea09f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090609083406.GE25316@prithivi.gnumonks.org>
In-Reply-To: <20090609083406.GE25316@prithivi.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 12 Dec 2009 20:48:17 +1000, Adam Nielsen wrote:
> > I would
> > appreciate if someone could test it and report, just to make sure I
> > didn't accidentally break the driver with my clean-ups. Thanks.
> 
> I've been using it for the last few hours on an EPIA M700 (1GHz C7) and it 
> seems to work fine.
> 
> I still don't get any output through "sensors" though:
> 
> $ sensors
> via-cputemp-isa-0000
> Adapter: ISA adapter
> 
> I'm guessing because on line 118 the name is set to "via-cputemp" with a dash, 
> instead of DRVNAME.

Oops, thanks for reporting. I thought I had fixed it, but obviously
not. This is done now.

But that wouldn't be the reason for your problem. More likely, you're
running an old version of lm-sensors (2.x). You need 3.x.

> sysfs and GKrellM seem to report accurate temperatures though.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

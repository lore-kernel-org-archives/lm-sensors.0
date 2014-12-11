From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 11 Dec 2014 13:47:00 +0000
Subject: Re: [lm-sensors] System Monitor cannot read sensors anymore
Message-Id: <20141211144700.363e2712@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <m6bv17$gsp$1@ger.gmane.org>
In-Reply-To: <m6bv17$gsp$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Richard,

On Thu, 11 Dec 2014 12:26:30 +0100, Richard Llom wrote:
> Hi,
> after a recent kernel update to 3.17.4 in my distro I can't read my sensors 
> anymore with my beloved ksysguard (/System Monitor). Strange thing is, I can 
> still see the sensors with "sensors" (see below).
> 
> So I was wondering if something changed with this kernel or if there are 
> known issues?

We are in the process of converting many drivers to have their
attributes attached to the hwmon class device instead of the physical
device. Any application not relying on libsensors may get confused by
this change. We had reports of this happening already. That being said,
the drivers you are using have not been converted in 3.17. k10temp was
converted in 3.18, while it87 was not converted yet. So I'm a bit
confused. Plus I think ksysguard is using libsensors anyway. Which
verions of ksysguard and libsensors are you using?

> What daemon/service (?) is responsible for providing the sensor data to 
> programs? How can I check if it is running correctly?

No service is doing that. The information is available in sysfs, and
libsensors gets it from there and makes it available to applications in
an easy way.

I'm not too sure how to debug this further. Can you describe the
symptoms better? Can you run ksysguard from a terminal and see if it's
spitting any error message (or logging them somewhere maybe?)

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

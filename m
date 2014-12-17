From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 17 Dec 2014 10:01:31 +0000
Subject: Re: [lm-sensors] System Monitor cannot read sensors anymore
Message-Id: <20141217110131.3153fb66@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <m6bv17$gsp$1@ger.gmane.org>
In-Reply-To: <m6bv17$gsp$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 11 Dec 2014 16:06:02 +0100, Richard Llom wrote:
> Jean Delvare wrote:
> > On Thu, 11 Dec 2014 12:26:30 +0100, Richard Llom wrote:
> System Monitor Version 4.11.14
> Using KDE Development Platform 4.14.3
> 
> pacman -Qo /usr/lib/libsensors.so.4.3.2
> /usr/lib/libsensors.so.4.3.2 is owned by lm_sensors 3.3.5-1

OK, this is recent enough so I don't think there is any problem with
the library.

> >> What daemon/service (?) is responsible for providing the sensor data to
> >> programs? How can I check if it is running correctly?
> > 
> > No service is doing that. The information is available in sysfs, and
> > libsensors gets it from there and makes it available to applications in
> > an easy way.
>
> Where exactly in /sys ? Because here I can't find anything there related to 
> my sensors...

In /sys/class/hwmon.

> > (...)
> > Can you run ksysguard from a terminal and see if it's
> > spitting any error message (or logging them somewhere maybe?)
>
> This is the output from the terminal
> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN COMMAND 
> for:  "lmsensors/k10temp-pci-00c3/temp1?"
> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN COMMAND 
> for:  "lmsensors/it8720-isa-0228/temp1?"
> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN COMMAND 
> for:  "lmsensors/nouveau-pci-0100/temp1?"
> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN COMMAND 
> for:  "lmsensors/it8720-isa-0228/fan1?"
> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN COMMAND 
> for:  "lmsensors/it8720-isa-0228/fan2?"

This should be reported to the maintainers of ksysguardd, this is an
application error after all.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

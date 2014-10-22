From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 22 Oct 2014 07:22:01 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (i5500_temp) New driver for the Intel 5500/5520/X58 chipsets
Message-Id: <20141022092201.7b478288@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141021090337.36b5f33d@endymion.delvare>
In-Reply-To: <20141021090337.36b5f33d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 21 Oct 2014 11:51:47 -0700, Guenter Roeck wrote:
> On Tue, Oct 21, 2014 at 08:25:25PM +0200, Jean Delvare wrote:
> > On Tue, 21 Oct 2014 09:48:39 -0700, Guenter Roeck wrote:
> > > Is it possible to detect that condition and fail to load the driver
> > > if the sensor is disabled, or to enable the sensor in the driver 
> > > in that case ?
> > 
> > We currently have no idea how to enable the sensor, this is the
> > problem :-( If you find out how to do that, please let me know. Or I
> > may ask Intel about it, maybe someone knows there. So far only Intel
> > boards have a working sensor.
> > 
> > We can't cleanly fail to load the driver, as the detection of the
> > faulty condition would happen at device probe time. We could decline
> > the probe though, so that the non-working sensor doesn't show up in
> > "sensors".
> 
> Yes, that is what I meant. Better than loading the driver and report
> bad temperatures.

OK, I'll add detection code to the probe function, in a separate patch.

> > > Personally I would not bother with a timed update function for this driver;
> > > pcie accesses are not as expensive as i2c accesses. Other than that,
> > 
> > What happens if a random user reads from the sysfs files in a tight
> > loop then? Can't he/she saturate the PCIe link and cause higher latency
> > or limited throughput for other PCIe devices?
>
> You won't be able to see an impact on pcie transfers. The cost for
> entering and exiting the kernel is much higher than that of a pcie
> transfer. The data on the bus, even in a tight loop, would be just
> noise. Keep in mind that the lowest possible pcie transfer speed is
> 2.5gbps, on a single-lane bus, and the root bus usually has way more
> than a single lane.

OK, thanks for the explanation. I'll drop the timer and resubmit.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

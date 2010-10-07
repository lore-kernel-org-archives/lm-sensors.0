From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Oct 2010 06:49:42 +0000
Subject: Re: [lm-sensors] local macro
Message-Id: <20101007084942.756ba6ed@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
In-Reply-To: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Wed, 6 Oct 2010 15:04:36 -0700, Paul Thomas wrote:
> > This is the problem with having ADC drivers in drivers/hwmon. These are
> > versatile devices, they can be used for voltage monitoring but also for
> > a variety of other things, and the desired interface depends on that.
> > Runtime gain changes is not desirable at all for a voltage monitoring
> > device.
> >
> > A solution to this may be to move the ADC driver itself somewhere else,
> > and have a dummy driver in hwmon/ merely adding a hwmon-style interface
> > on top of the main driver. Other such dummy driver could be written for
> > other use cases of the ADC. I think this is what the s3c-hwmon driver
> > is doing, and maybe others.
> 
> I think there is slight misunderstanding about where the gain is, and
> how I plan on handling it. inX_input always returns in units of
> volts*10,000.

I'm not sure what you mean with "units of volts*10,000", I seriously
doubt that the ADC's LSB has a weight of 10,000 Volts. Did you mean a
LSB of 0.0001 Volt? If this is the case then the driver is broken and
has to be fixed, as the sysfs ABI requires that inX files expose values
in units of 0.001 Volt.

> If you set the gain to 20 the only difference is that if
> you try and read a voltage over 0.125 then it will be out of range.
> 
> I understand there are hwmon devices that are dependent on external
> amplifiers & dividers, but that is not the case here.

The point isn't whether the gain is internal or external. The point is
whether the gain should change at run-time or not. When doing voltage
monitoring, you expect a result in a specific, short range, so the gain
should be set for the desired range and never changed afterward. There
are a lot of hardware monitoring devices doing exactly that, internally.

The bottom line is that if your needs are different then your driver
doesn't belong to drivers/hwmon.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

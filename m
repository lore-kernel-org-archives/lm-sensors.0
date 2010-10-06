From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Oct 2010 21:45:51 +0000
Subject: Re: [lm-sensors] local macro
Message-Id: <1286401551.9690.101.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
In-Reply-To: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2010-10-06 at 17:32 -0400, Jean Delvare wrote:
> On Wed, 6 Oct 2010 14:02:26 -0700, Guenter Roeck wrote:
> > On Wed, 2010-10-06 at 15:54 -0400, Paul Thomas wrote:
> > > > No, both of those are runtime options internal to the ads7871, and
> > > > because we initiate a read by setting that register anyway there isn't
> > > > any additional setup cost (at least there isn't any spi cost, there is
> > > > a little additional code in show_voltage).
> > > >
> > This isn't a matter of cost, but a matter of maintaining a consistent
> > ABI.
> > 
> > A brief look into the datasheet shows that the chip is a generic adc. So
> > I assume its use is not limited to voltage monitoring, and that you
> > would in fact expect to change the gain during runtime (ie not only at
> > system startup). Is this a correct assumption ?
> 
> This is the problem with having ADC drivers in drivers/hwmon. These are
> versatile devices, they can be used for voltage monitoring but also for
> a variety of other things, and the desired interface depends on that.
> Runtime gain changes is not desirable at all for a voltage monitoring
> device.
> 
> A solution to this may be to move the ADC driver itself somewhere else,
> and have a dummy driver in hwmon/ merely adding a hwmon-style interface
> on top of the main driver. Other such dummy driver could be written for
> other use cases of the ADC. I think this is what the s3c-hwmon driver
> is doing, and maybe others.
> 
Agreed.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

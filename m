From: "Michael S. Zick" <lkml@morethan.org>
Date: Fri, 12 Jun 2009 11:46:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for VIA CPU core
Message-Id: <200906120646.48615.lkml@morethan.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090609083406.GE25316@prithivi.gnumonks.org> <20090611153255.ba8d6c54.akpm@linux-foundation.org> <20090612101200.3fe6d494@hyperion.delvare>
In-Reply-To: <20090612101200.3fe6d494@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Tomaz Mertelj <tomaz.mertelj@guest.arnes.si>, Harald Welte <HaraldWelte@viatech.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri June 12 2009, Jean Delvare wrote:
> On Thu, 11 Jun 2009 15:32:55 -0700, Andrew Morton wrote:
> > On Wed, 10 Jun 2009 17:40:31 +0000 (UTC)
> > Tomaz Mertelj <tomaz.mertelj@guest.arnes.si> wrote:
> > 
> > > Harald Welte <HaraldWelte <at> viatech.com> writes:
> > > 
> > > > 
> > > > This is a driver for the on-die digital temperature sensor of
> > > > VIA's recent CPU models.
> > > > 
> > > > Signed-off-by: Harald Welte <HaraldWelte <at> viatech.com>
> > > > 
> > > 
> > > Harald,
> > 
> > You carefully removed Harald from Cc: so he probably didn't read your
> > email.
> > 
> > > I tested it on 2.6.28.3 kernel on VIA VB7002 motherboard and it does not work 
> > > correctly.
> > > 
> > > Output form sensors:
> > > 
> > > via-cputemp-isa-0000
> 
> Harald, dashes in hwmon chip names are _prohibited_. Please change to
> via_cputemp or similar.
> 
> > > Adapter: ISA adapter
> > > Core 0:       +0.0 C
> > > 
> > > On the other hand 
> > > cat '/sys/class/hwmon/hwmon2/device/driver/via-cputemp.0/temp1_input' outputs 
> > > numbers between 25-27. 
> > > 
> 
> Temperature values are supposed to be expressed in millidegrees C, not
> degrees C as it seems to be doing (although 25 degrees C seems pretty
> low for a CPU temperature?) The drivers needs to multiply values by
> 1000 before exporting them to sysfs. Then "sensors" will report the
> correct temperature value.
> 

Ah, 25 degrees C is room temperature - real hard for the junction temperature
to be 25 degrees C with power applied; lacking an infinitely perfect heatsink.

Look for an "off by one" error in shifting or masking the value.

Mike

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

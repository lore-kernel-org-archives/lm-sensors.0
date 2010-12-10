From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Dec 2010 15:15:29 +0000
Subject: Re: [lm-sensors] powerX_alarm sysfs attribute
Message-Id: <20101210151529.GB11777@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101209165858.GA521@ericsson.com>
In-Reply-To: <20101209165858.GA521@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 10, 2010 at 09:37:59AM -0500, Jean Delvare wrote:
> On Thu, 9 Dec 2010 13:26:13 -0800, Ira W. Snyder wrote:
> > On Thu, Dec 09, 2010 at 08:58:58AM -0800, Guenter Roeck wrote:
> > > Hi all,
> > > 
> > > I am looking through libsensors and the hwmon sysfs ABI to identify and fix
> > > inconsistencies.
> > > 
> > > One problem I noticed is powerX_alarm, which is defined as "system is drawing
> > > more power than the cap allows".
> > > 
> > > powerX_cap is defined as " ... The *_cap files only appear if the cap is known
> > > to be enforced by hardware".
> > > 
> > > Now there are conditions where power limits are defined and supported,
> > > but the hardware does not enforce it. Similar, there are devices reporting power
> > > alarms not associated with cap enforcement. Examples are ltc4215 and PMBus devices.
> > > powerX_alarm is supported by the ltc4215 driver, but there is no _cap attribute,
> > > and the alarm is not associated with a maximum, thus a reported alarm doesn't
> > > really reflect the ABI.
> > 
> > In the ltc4215, the power1_alarm occurs when the output voltage of the
> > chip is outside a certain range. This range is specified by external
> > resistors, specific to each application. They are not required to be a
> > specific value by the hardware.
> 
> I am confused. Did you just write _output_ voltage? 
> 
output is probably an inexact statement here. The chip controls the voltage
to a board using an external transistor, and it can monitor the output voltage 
of that transistor.

> > I guess that the ltc4215 driver's use of powerX_alarm doesn't follow the
> > ABI document.
> 
> I can confirm that. For one thing, if this has to do with voltage, it's
> not a power limit. For another, if it is a voltage _output_ limit, it
> has nothing to do with hardware monitoring.
> 
I disagree; please also see my other reply.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

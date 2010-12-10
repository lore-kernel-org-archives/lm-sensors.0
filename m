From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Fri, 10 Dec 2010 00:07:08 +0000
Subject: Re: [lm-sensors] powerX_alarm sysfs attribute
Message-Id: <20101210000708.GD26602@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101209165858.GA521@ericsson.com>
In-Reply-To: <20101209165858.GA521@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 09, 2010 at 01:48:33PM -0800, Guenter Roeck wrote:
> On Thu, 2010-12-09 at 16:26 -0500, Ira W. Snyder wrote:
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
> > > 
> > 
> > In the ltc4215, the power1_alarm occurs when the output voltage of the
> > chip is outside a certain range. This range is specified by external
> > resistors, specific to each application. They are not required to be a
> > specific value by the hardware.
> > 
> > I guess that the ltc4215 driver's use of powerX_alarm doesn't follow the
> > ABI document.
> > 
> > In essence, the power1_alarm is connected to the chip's power good
> > output (negated). Should the ABI have a powerX_good or powerX_fail
> > attribute?
> > 
> I think powerX_alarm pretty well covers it. My concern is with the ABI
> description/definition, which is not in line with other _alarm
> attributes.
> 
> Question for the ltc4215 driver, though, is if power1_alarm is
> appropriate in the first place. After reading the datasheet, I noticed
> that it does not really report a power problem, but "output voltage
> low". So I wonder it the attribute in the driver should be "in2_alarm"
> or possibly "in2_min_alarm" instead of power1_alarm, and if the power
> attributes should be dropped entirely.
> 

Reviewers (probably Jean) suggested the power1_input and power1_alarm
files when I submitted the driver. (I'm not placing blame, just
explaining where they came from.)

In both the ltc4215 and ltc4245 drivers, the power outputs are
calculated purely in software. This is very convenient for users of the
sensors utility.

I would like to keep the power1_input sysfs file. I do not have any
objections to changing power1_alarm to in2_alarm or in2_min_alarm.

Ira

> We could possibly add an inX_fail alarm attribute to cover the condition
> reported by the ltc4215. Not sure if that would be worth it, but it
> might be worth a thought.
> 
> Thanks,
> Guenter
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

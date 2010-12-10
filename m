From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Dec 2010 15:12:09 +0000
Subject: Re: [lm-sensors] powerX_alarm sysfs attribute
Message-Id: <20101210151209.GA11777@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101209165858.GA521@ericsson.com>
In-Reply-To: <20101209165858.GA521@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 10, 2010 at 09:36:46AM -0500, Jean Delvare wrote:
> Hi Ira, Guenter,
> 
> On Thu, 9 Dec 2010 16:07:08 -0800, Ira W. Snyder wrote:
> > On Thu, Dec 09, 2010 at 01:48:33PM -0800, Guenter Roeck wrote:
> > > Question for the ltc4215 driver, though, is if power1_alarm is
> > > appropriate in the first place. After reading the datasheet, I noticed
> > > that it does not really report a power problem, but "output voltage
> > > low". So I wonder it the attribute in the driver should be "in2_alarm"
> > > or possibly "in2_min_alarm" instead of power1_alarm, and if the power
> > > attributes should be dropped entirely.
> > 
> > Reviewers (probably Jean) suggested the power1_input and power1_alarm
> > files when I submitted the driver. (I'm not placing blame, just
> > explaining where they came from.)
> 
> Probably not, the ltc4215 driver went upstream through Andrew Morton
> because I lacked the time to do a proper review.
> 
> > In both the ltc4215 and ltc4245 drivers, the power outputs are
> > calculated purely in software. This is very convenient for users of the
> > sensors utility.
> > 
> > I would like to keep the power1_input sysfs file.
> 
> I have no problem with this, at least as long as libsensors doesn't
> offer a way to bind current sensors to voltage sensors.
> 
> > I do not have any
> > objections to changing power1_alarm to in2_alarm or in2_min_alarm.
> 
> in2_* doesn't seem right for a voltage output alarm. I'd say such a
> feature doesn't belong to the hwmon ABI in the first place.
> 
Why not ? You lost me there. It optionally monitors the voltage it controls,
and provides the monitored value(s) to the user. Many of the other recent chips
do the same.  ltc4215, ltc4245, ltc4261, smm655, and pretty much all PMBus devices.
The ltc42xx devices act as voltage switch (on/off) and don't otherwise affect
the controlled voltage.
For ltc4215, in2_input is still connected to a a sensor input (AD2IN or so), as is
the FB pin (which causes the alarm if the voltage connected to it drops below a
certain level). It doesn't make sense to state that the monitored voltage can not
be reported through hwmon just because it may be a voltage it controls.

It gets even more tricky with devices which can be used as voltage controller
or voltage monitor or both. For example, the smm665 and ltc2978 are both a power
supply monitor and controller. I have seen them used for both purposes. But there isn't
a reason to deny hwmon support for such devices just because they also may be used for
voltage control.

Another question (for which I still don't have a clear answer) is if voltage controllers/monitors
such as the smm665 and at least some pmbus devices should also have a matching power_supply
component, and thus if they should be considered mfd devices with hwmon and power_supply
components. I have that on my backburner list; I'll probably get there if someone
actually wants to be able to set a voltage on one of the devices.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

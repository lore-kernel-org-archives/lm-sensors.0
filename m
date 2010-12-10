From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Dec 2010 16:00:23 +0000
Subject: Re: [lm-sensors] powerX_alarm sysfs attribute
Message-Id: <20101210170023.7cbfdad5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101209165858.GA521@ericsson.com>
In-Reply-To: <20101209165858.GA521@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 10 Dec 2010 07:12:09 -0800, Guenter Roeck wrote:
> On Fri, Dec 10, 2010 at 09:36:46AM -0500, Jean Delvare wrote:
> > On Thu, 9 Dec 2010 16:07:08 -0800, Ira W. Snyder wrote:
> > > I would like to keep the power1_input sysfs file.
> > 
> > I have no problem with this, at least as long as libsensors doesn't
> > offer a way to bind current sensors to voltage sensors.
> > 
> > > I do not have any
> > > objections to changing power1_alarm to in2_alarm or in2_min_alarm.
> > 
> > in2_* doesn't seem right for a voltage output alarm. I'd say such a
> > feature doesn't belong to the hwmon ABI in the first place.
> 
> Why not ? You lost me there. It optionally monitors the voltage it controls,
> and provides the monitored value(s) to the user. Many of the other recent chips
> do the same.  ltc4215, ltc4245, ltc4261, smm655, and pretty much all PMBus devices.
> The ltc42xx devices act as voltage switch (on/off) and don't otherwise affect
> the controlled voltage.
> For ltc4215, in2_input is still connected to a a sensor input (AD2IN or so), as is
> the FB pin (which causes the alarm if the voltage connected to it drops below a
> certain level). It doesn't make sense to state that the monitored voltage can not
> be reported through hwmon just because it may be a voltage it controls.

Thanks for clarifying. I didn't read the datasheet, and what Ira wrote
confused me. If the alarm is related to the value of in2_input, then of
course in2_alarm, in2_min_alarm (assuming in2_min is present) or
in2_max_alarm (assuming in2_max is present) makes sense.

BTW, powerX_alarm makes no sense at all if powerX_input is computed, as
is the case for the ltc4215 according to Ira.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

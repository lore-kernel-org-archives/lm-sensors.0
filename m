From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Dec 2010 16:30:25 +0000
Subject: Re: [lm-sensors] powerX_alarm sysfs attribute
Message-Id: <20101210173025.68fa89fa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101209165858.GA521@ericsson.com>
In-Reply-To: <20101209165858.GA521@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 10 Dec 2010 08:18:30 -0800, Guenter Roeck wrote:
> On Fri, Dec 10, 2010 at 11:00:23AM -0500, Jean Delvare wrote:
> > Thanks for clarifying. I didn't read the datasheet, and what Ira wrote
> > confused me. If the alarm is related to the value of in2_input, then of
> > course in2_alarm, in2_min_alarm (assuming in2_min is present) or
> > in2_max_alarm (assuming in2_max is present) makes sense.
>
> Is that an implied requirement for supporting min_alarm ? Reason for asking is that many chips 
> have limit alarms but no matching (readable/settable) limit values. ltc4215, ltc4245, and ltc4261
> are examples. Alarm status is determined by a voltage on a pin exceeding a hardcoded limit,
> and the actual voltage on a pin is determined by external resistor arrays.
> The ltc4245 and ltc4261 drivers already provide min_alarm and/or max_alarm but not min and max.

I had our recent discussion about the "sensors" code in mind. I seem to
recall that the code currently ignores limit-specific alarms if there
is no matching limit.

That being said, if some chip drivers really have to do that, then
probably we'll have to adjust the "sensors" code, rather than the other
way around.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

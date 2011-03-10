From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Mar 2011 17:32:09 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <20110310173209.GA12987@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 10, 2011 at 06:53:28AM -0500, Guenter Roeck wrote:
[ ... ]
> > 
> > So first question is what chip he has.
> > 
> ... answer is NCT6775F, from Robert's log. It uses the "old" registers for the min
> speed settings, so presumably that should be correct. Yet, there must be a reason
> for the alarm. Maybe it is the "maximum RPM" register after all - the NCT6775F
> has that set of registers as well.
> 
Doesn't look like the "maximum RPM" register is the culprit. I have a system with NCT6775F 
(not using its fan controls, though). Looks like one can not write into that register, so it
must be a status register. Maybe it reports the maximum RPM the chip has seen.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

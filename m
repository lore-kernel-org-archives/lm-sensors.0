From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Dec 2010 14:36:46 +0000
Subject: Re: [lm-sensors] powerX_alarm sysfs attribute
Message-Id: <20101210153646.56102e94@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101209165858.GA521@ericsson.com>
In-Reply-To: <20101209165858.GA521@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira, Guenter,

On Thu, 9 Dec 2010 16:07:08 -0800, Ira W. Snyder wrote:
> On Thu, Dec 09, 2010 at 01:48:33PM -0800, Guenter Roeck wrote:
> > Question for the ltc4215 driver, though, is if power1_alarm is
> > appropriate in the first place. After reading the datasheet, I noticed
> > that it does not really report a power problem, but "output voltage
> > low". So I wonder it the attribute in the driver should be "in2_alarm"
> > or possibly "in2_min_alarm" instead of power1_alarm, and if the power
> > attributes should be dropped entirely.
> 
> Reviewers (probably Jean) suggested the power1_input and power1_alarm
> files when I submitted the driver. (I'm not placing blame, just
> explaining where they came from.)

Probably not, the ltc4215 driver went upstream through Andrew Morton
because I lacked the time to do a proper review.

> In both the ltc4215 and ltc4245 drivers, the power outputs are
> calculated purely in software. This is very convenient for users of the
> sensors utility.
> 
> I would like to keep the power1_input sysfs file.

I have no problem with this, at least as long as libsensors doesn't
offer a way to bind current sensors to voltage sensors.

> I do not have any
> objections to changing power1_alarm to in2_alarm or in2_min_alarm.

in2_* doesn't seem right for a voltage output alarm. I'd say such a
feature doesn't belong to the hwmon ABI in the first place.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

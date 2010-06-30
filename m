From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 30 Jun 2010 15:22:48 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: Add support for new hwmon
Message-Id: <20100630172248.2908931d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1277877978-27726-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1277877978-27726-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 30 Jun 2010 07:20:21 -0700, Guenter Roeck wrote:
> On Wed, Jun 30, 2010 at 09:50:51AM -0400, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Tue, 29 Jun 2010 23:06:18 -0700, Guenter Roeck wrote:
> > > This patch adds support for the following new attributes to libsensors and
> > > to the sensors command.
> > >
> > > inX_lcrit
> > > inX_crit
> > > inX_fault
> > > temp_lcrit
> > > powerX_cap
> > > powerX_max
> > > powerX_crit
> > > powerX_alarm
> > > powerX_fault
> > > currX_lcrit
> > > currX_crit
> > > currX_fault
> > 
> > Fair enough, assuming these matches the additions to
> > Documentation/hwmon/sysfs-interface. I'm a little curious about
> > inX_fault, powerX_fault and currX_fault though. _fault files are for
> > hardware failures. While I can imagine a thermal diode failing, how
> > could a voltage or current sensor be broken?
>
> I thought about that myself, ie if it would be better to introduce
> _lcrit_alarm and _crit_alarm instead. My ultimate conclusion was that the chips
> I am working with right now are voltage controllers, and thus exceeding the limits
> points to a fault rather than a critical limit alarm. Action taken by the chip 
> is typically also drastic; raising a fault alarm is only the least drastic action
> possible. More likely the chip will be configured to reset the board or shut down
> power completely.
> 
> This applies to chips which have both "alarm" and "critical" limits.
> 
> So even if the event does not exactly match the "fault" description in the API,
> I concluded that "fault" is a better match to what happens than "crit_alarm" or
> "lcrit_alarm". I don't feel too strongly about that, though, so if you disagree 
> I'll be happy to change the code and API to "lcrit_alarm" and "crit_alarm"
> for those sensors.

Yes, I disagree, and yes, please change. "alarms" in the hwmon
framework are flags raised because of out-of-limits measurements, and
we should stick to this to avoid any confusion. And "faults" are
something else. Let's stick to this.

in[0-*]_fault should probably be removed from
Documentation/hwmon/sysfs-interface altogether, to clear the confusion.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

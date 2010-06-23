From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Jun 2010 17:21:44 +0000
Subject: Re: [lm-sensors] Adding critical/fault limits to hwmon sysfs API
Message-Id: <20100623172144.GA20046@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100620163759.GA7077@ericsson.com>
 <20100623144346.10acd898@hyperion.delvare>
 <20100623133147.GA19143@ericsson.com>
 <20100623162911.2028f817@hyperion.delvare>
 <20100623150325.GA19461@ericsson.com>
 <20100623183437.5a04dedb@hyperion.delvare>
In-Reply-To: <20100623183437.5a04dedb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jun 23, 2010 at 12:34:37PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Wed, 23 Jun 2010 08:03:25 -0700, Guenter Roeck wrote:
> > On Wed, Jun 23, 2010 at 10:29:11AM -0400, Jean Delvare wrote:
> > > I expected a counter-proposal of this kind. The problem I see is that
> > > the new limit we are adding is unrelated to _min. However, the other
> > > _min_* file we have (_min_alarm) expresses something which is relative
> > > to _min. Same as _max_hyst and _crit_hyst, which are relative to _max
> > > and _critn respectively. So I have the feeling that _min_crit sends the
> > > wrong signal to the reader. Especially if we keep _crit for the high
> > > bound, the asymmetry raises questions.
> > > 
> > > This is my rationale for suggesting _crit and _lcrit. Now, I won't
> > > argue forever if others disagree, these is really only a naming
> > > convention and everything will be fine as long as the drivers and
> > > libsensors agree.
> > 
> > Makes sense. No strong opinion on my side, really. Using crit/lcrit is fine for me as well.
> > Maybe we should wait if there is input from others and go with lcrit if there is none.
> 
> OK, fine with me.
> 
> > On a side note, libsensors does not support inX_fault today, even though 
> > it is mentioned in the API, and there is no currX_fault. Likewise, libsensors supports 
> > currX_alarm but it is not mentioned in hwmon/sysfs-interface.
> > Unless there are objections, I'll clean that up when I add support for the _[l]crit objects.
> 
> Yes, please!
> 
> > Also, lib/sensors.conf.5 has a comment "Likewise, tempX_crit often comes with tempX_max_crit".
> > Since tempX_max_crit does not exist, it might make sense to remove that comment.
> 
> Does the sentence make sense if you replace tempX_max_crit with
> tempX_crit_hyst? Looks like a copy-paste-edit mistake (that would be
> from me.)

Yes, I think that is the problem. I'll fix that together with the other changes.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Sep 2008 07:11:07 +0000
Subject: Re: [lm-sensors] hwmon: Add a driver for the ADT7475 thermal sensor
Message-Id: <20080909091107.714a0400@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080908174853.GG24308@cosmic.amd.com>
In-Reply-To: <20080908174853.GG24308@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jordan,

On Mon, 8 Sep 2008 17:43:50 -0600, Jordan Crouse wrote:
> On 06/09/08 12:00 +0200, Hans de Goede wrote:
> > Jordan Crouse wrote:
> > > Resend of the ADT7475 driver.  Jean said he would like to
> > > see a review on this version, even though it had been discussed before.
> > > Therefore I'm CCing Hans for his opinion.. :) I would really like to
> > > see this go into 2.6.28 and get out of my patch stack.
> > 
> > Jordan,
> > 
> > I did do a review although very late (but didn't get very far, as there
> > are some sysfs API issues that need addressing first).
> > 
> > See:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2008-August/023948.html
> 
> Okay - I have generated a new patch.  I implemented all of your suggestions -
> the only one I had any concerns about was the hystersis (hystersis makes
> more sense to me as an offset rather then an absolute), but consistancy
> among hwmon drivers is rather more important.
> 
> There is one possible issue in the patch - I pulled the decimal point
> from the pwmX_freq numbers since I wasn't sure if we wanted to express
> the number in milihertz.  If we do, then it is an easy fix.

You did the right thing, we do not want to express PWM frequencies in
millihertz. The standard resolution is 1 hertz and tt should be totally
sufficient in practice: we don't really care about the exact frequency
values.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Apr 2007 18:26:58 +0000
Subject: Re: [lm-sensors] Need some guidance on adhering to the sysfs
Message-Id: <20070424202658.16587ae6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Sun, 22 Apr 2007 13:58:56 -0700, Juerg Haefliger wrote:
> On 4/22/07, Juerg Haefliger <juergh@gmail.com> wrote:
> > On 4/22/07, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> > > Juerg Haefliger wrote:
> > > > That's not going to work. I can't use temp[1-*]_auto_point[1-*]_temp
> > > > because there are multiple sets of thresholds for a single temp input
> > > > and I can't use pwm[1-*]_auto_point[1-*]_temp either because then the
> > > > "hottest of x,y,z" doesn't work.
> > >
> > > Can't you use pwm[1-*]_auto_channels_temp for that?
> >
> > Yes, I do. OK, I wasn't clear enough in my previous post. The problem
> > is the thermal thresholds. How would you implement the following
> > example with the current sysfs standard?
> >
> > temp3 maps to zone2
> > temp3 maps to zone3
> > zone2 has min and max temp thresholds
> > zone3 has min and max temp thresholds
> > pwm2 is controlled by zone2
> > pwm3 is controlled by hottest of zone2 or zone3
> >
> > See what the problem is? There are 2 sets of thermal thresholds for
> > pwm3 and 2 sets for temp3.
> 
> OK just realized that this is a silly example :-) Let's try again:
> 
> temp1 maps to zone1
> temp3 maps to zone2
> temp3 maps to zone3
> zone1 has min and max temp thresholds
> zone2 has min and max temp thresholds
> zone3 has min and max temp thresholds
> pwm1 is controlled by zone1
> pwm2 is controlled by zone2
> pwm3 is controlled by hottest of zone1 or zone3
> 
> Not sure if that makes more sense but the DME1737 can certainly be
> programmed that way...

If the limits are zone attributes and all sorts of mapping are
possible, then indeed our current interface doesn't support that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 22 Apr 2007 20:54:58 +0000
Subject: Re: [lm-sensors] Need some guidance on adhering to the sysfs
Message-Id: <191fb4ca0704221354y6d24b3e8v5fab6358cf88a8c4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 4/22/07, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> Juerg Haefliger wrote:
> > On 4/22/07, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> >> Juerg Haefliger wrote:
> >>> Hi Jean,
> >>>
> >>> On 4/22/07, Jean Delvare <khali@linux-fr.org> wrote:
> >>>> Hi Juerg,
> >>>>
> >>>> On Thu, 19 Apr 2007 12:04:28 -0700, Juerg Haefliger wrote:
> >>>>> George, Jean,
> >>>>>
> >>>>> I'm struggling with the same issue for the DME1737 I'm currently
> >>>>> working on. This chip also features temp zones and "hottest of x,y,z"
> >>>>> PWM control. The current sysfs standard is not flexible enough to
> >>>>> handle these features, especially the combination of a single PWM
> >>>>> being controlled by multiple temp inputs and multiple PMWs being
> >>>>> controlled by the same temp input. I believe we need another layer of
> >>>>> mapping. I.e. temp->pwm is not sufficient, but rather temp->zone->pwm.
> >>>>>
> >>>>> I therefore propose the add the following sysfs attributes to our standard:
> >>>>>
> >>>>> zone[1-*]_auto_channels_temp   for temp-to-zone mapping
> >>>>> pwm[1-*]_auto_channels_zone   for zone-to-pwm mapping
> >>>>> zone[1-*]_auto_point[1-*]_temp   for zone temp auto points.
> >>>> I don't see what value it adds compared to what we currently have.
> >>>>
> >>>> We have pwm[1-*]_auto_channels_temp, which is a bit vector. We have one
> >>>> file per PWM, one bit per temperature channel, so all in all we have a
> >>>> Npwm x Ntemp matrix, or N-N relation between PWM and temperatures. This
> >>>> already allows us to handle cases such as "the hottest of tempA and
> >>>> tempB control pwmC" or "tempD controls pwmE and pwmF".
> >>> Yes, I understand that.
> >>>
> >>>
> >>>> You propose to add the concept of zone. According to the above, each
> >>>> zone could include any temperature channel, so we have a N-N relation
> >>>> between zones and temperatures. Then you express another N-N relation
> >>>> between PWM channels and zones. As far as I can see, this results in a
> >>>> N-N relation between temperatures and PWM, just expressed differently.
> >>>> Am I missing something? What do you think it would let us express,
> >>>> which the current model doesn't?
> >>> What I can't seem to map to our current standard (or maybe I just
> >>> don't see it) is the concept of multiple sets of thermal thresholds
> >>> for a single temp input. Example: pwm2 is controlled by zone2 and pwm3
> >>> is controlled by zone3 but both zone2 and zone3 are controlled by
> >>> temp3. Both zone2 & 3 have different thermal thresholds.
> >>>
> >>> With the current standard I can only apply one set of thresholds to
> >>> temp3 via temp3_auto_point[1-*]_temp.
> >>>
> >> Thats easy, AFAIK you can have either temp[1-*]_auto_point[1-*]_temp,
> >> or pwm[1-*]_auto_point[1-*]_temp, iow you can couple the autopoints
> >> to either a temp channel or a pwm channel depending on if the
> >> thresholds are set per temp channel or per pwm channel.
> >
> > That's not going to work. I can't use temp[1-*]_auto_point[1-*]_temp
> > because there are multiple sets of thresholds for a single temp input
> > and I can't use pwm[1-*]_auto_point[1-*]_temp either because then the
> > "hottest of x,y,z" doesn't work.
> >
>
> Can't you use pwm[1-*]_auto_channels_temp for that?

Yes, I do. OK, I wasn't clear enough in my previous post. The problem
is the thermal thresholds. How would you implement the following
example with the current sysfs standard?

temp3 maps to zone2
temp3 maps to zone3
zone2 has min and max temp thresholds
zone3 has min and max temp thresholds
pwm2 is controlled by zone2
pwm3 is controlled by hottest of zone2 or zone3

See what the problem is? There are 2 sets of thermal thresholds for
pwm3 and 2 sets for temp3.

...juerg

>
> Regards,
>
> Hans
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

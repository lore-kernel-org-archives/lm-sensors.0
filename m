From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Jun 2007 20:41:57 +0000
Subject: Re: [lm-sensors] [PATCH] Add temperature-tracking mode to f71805f
Message-Id: <20070626224157.7b52e1d0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182285507009@dmwebmail.belize.chezphil.org>
In-Reply-To: <1182285507009@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Phil,

On Mon, 25 Jun 2007 23:37:12 +0100, Phil Endecott wrote:
> Jean Delvare wrote:
> 
> (in the sysfs documentation)
> >> +OR
> >> +
> >> +pwm[1-*]_auto_point[1-*]_temp
> >> +pwm[1-*]_auto_point[1-*]_fan
> >> +		Define the fan speed vs temperature curve for chips which
> >> +		associate trip points to PWM output channels.  Number of trip
> >> +		points is chip-dependent.
> >>  		RW
> >
> > This was discussed some times ago and the consensus was that we did not
> > want to extend this documentation for every new chip doing things
> > differently
> 
> Well currently the file documents 2 of the n ways in which it can work 
> as if they are the only two ways.
>
> Would you not prefer to insert at least some mention that it could work 
> in other ways? 

I agree it can be confusing; adding a statement that other ways are
possible and allowed would be welcome.

>                 Put yourself in the position of someone who has a board 
> with one of these chips, who wants to configure it.  If the method is 
> left undocumented, they have to guess or read the source.
> 
> I would not be pleased if the functionality that I have added goes 
> unused because the documentation for it has been rejected.

Actually, you documented the interesting files in
Documentation/hwmon/f71805f already, and this is what the users should
be reading. Documentation/hwmon/sysfs-interface is aimed at the
developers, not users.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

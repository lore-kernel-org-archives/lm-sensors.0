From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 12 Jan 2015 16:54:00 +0000
Subject: Re: [lm-sensors] hwmon strangeness, no fan control on w83627dhg
Message-Id: <20150112165400.GA3103@amd>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150108202919.GA25118@amd>
In-Reply-To: <20150108202919.GA25118@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu 2015-01-08 21:29:19, Pavel Machek wrote:
> Hi!
>

> Plus, no matter what I do, I can't control the pwm2 (only one used on
> my board):
> 
> root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
> 80
> root@amd:/sys/class/hwmon/hwmon1/device# echo 0 > pwm2
> root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
> 80
> root@amd:/sys/class/hwmon/hwmon1/device#
> 
> I tried playing with other files, too, but no luck. Documentation
> mentions:
> 
> Note: last six functions are influenced by other control bits, not yet
> exported
>       by the driver, so a change might not have any effect.
> 
> 
> Any ideas what bits those are, and what needs to be implemented? (I'm
> currently reading through the documentation).

I have pwm2_mode set to 1. I can set it to 0 and can hear the fan
spinning up, and rpm go to >1500. So I have _some_ kind of
control... But normally fan is around 800, and nothing else seems to
change it...


								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

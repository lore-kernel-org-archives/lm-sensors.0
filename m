From: Alexander Kiel <alexanderkiel@gmx.net>
Date: Fri, 16 Nov 2007 00:41:47 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <1195173707.6275.39.camel@alex>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> > Can you submit this patch? I don't have a reasonable access to the
> > lm-sensors community.
> 
> I'll take a look. I'm pushing out some patches for the kernel driver
> right now, so if you can hang on to that patch for a few days, I'll
> review it.

No problem. I will use Thermal Cruise anyway now. :-) But it would good
for the other people which get worried about this issue.

> > Second: Can you please tell me what echo 2 > pwm1_enable does on this
> > chip? Is it an chip automatic fan control? It works great for me. It
> > puts my fan currently to a 155.
> 
> Yes, it's automatic. Take a look at
> /usr/src/linux/Documentation/hwmon/w83627ehf:
> pwm[1-4]_enable - this file controls mode of fan/temperature control:
>         * 1 Manual Mode, write to pwm file any value 0-255 (full speed)
>         * 2 Thermal Cruise
> 
> There are two more modes (RPM cruise and SmartFan III) which are not
> supported by the driver yet. That's mainly because 2 (Thermal Cruise)
> works so well, I've focused on other things.

Oh. That's fine. This reminds me for the ASUS Q-Fan (BIOS setting)
modes. There you have Performance, Optimal and Silent.

It would be good if pwmconfig could tell one that ones chip have such a
automatic. Than I don't see any need for a software controller ala
fancontrol. In such a case pwmconfig should write a startup script which
sets the right enable mode and that's it.

Regards
Alex


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

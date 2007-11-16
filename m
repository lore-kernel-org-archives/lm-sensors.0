From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Fri, 16 Nov 2007 00:24:21 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <4dfa50520711151624j238a2effle6e753aba8817a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

> Ok the problem with pwmconfig is the following:
>
> echo 0 > $ENABLE 2> /dev/null outputs actually 0. This is the 0 from the
> echo. echo 3 > $ENABLE 2> /dev/null would output 3. I have no clue why
> this is the case.
>
> This 0 causes the line echo $MAX > $1 to set pwm1 to 0 instead of 255.
> If I add a > /dev/null to the line echo 0 > $ENABLE 2> /dev/null it
> works as it should.
>
> So the diff is:
> ----------------------------------------------------------------------
> 127c127
> <               echo 0 > $ENABLE > /dev/null 2> /dev/null
> ---
> >               echo 0 > $ENABLE 2> /dev/null
> ----------------------------------------------------------------------
>
> Can you submit this patch? I don't have a reasonable access to the
> lm-sensors community.

I'll take a look. I'm pushing out some patches for the kernel driver
right now, so if you can hang on to that patch for a few days, I'll
review it.

> Second: Can you please tell me what echo 2 > pwm1_enable does on this
> chip? Is it an chip automatic fan control? It works great for me. It
> puts my fan currently to a 155.

Yes, it's automatic. Take a look at
/usr/src/linux/Documentation/hwmon/w83627ehf:
pwm[1-4]_enable - this file controls mode of fan/temperature control:
        * 1 Manual Mode, write to pwm file any value 0-255 (full speed)
        * 2 Thermal Cruise

There are two more modes (RPM cruise and SmartFan III) which are not
supported by the driver yet. That's mainly because 2 (Thermal Cruise)
works so well, I've focused on other things.

Thanks,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

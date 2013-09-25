From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Sep 2013 17:45:01 +0000
Subject: Re: [lm-sensors] Problems with set in5_max in nct6776-isa-0290
Message-Id: <20130925174501.GA28432@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALmZR2NiQ3yhvYzmRz49YW7S=2RmkeTyRGdb3rPqqnNJZ57-Ow@mail.gmail.com>
In-Reply-To: <CALmZR2NiQ3yhvYzmRz49YW7S=2RmkeTyRGdb3rPqqnNJZ57-Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 25, 2013 at 06:01:47PM +0200, Kent Larsson wrote:
> I want to change in5_min and in5_max. First I check that I have the right
> value names:
> 
>     sensors -u
>     ...
>     in5:
>       in5_input: 2.040
>       in5_min: 1.224
>       in5_max: 2.040
>       in5_alarm: 1.000
>     ...
> 
> Yes it looks that way. I try to set them in my configuration file
> 
>     test@debianstick:~$ cat /etc/sensors.d/custom
>     chip "nct6776-isa-0290"
>             ...
>             set in5_min 1.224
>             set in5_max 2.540
> 
> There seem to be no problem interpreting the configuration file, but only
> in5_min takes affect
> 
>     test@debianstick:~$ sudo sensors -s
>     test@debianstick:~$ sensors
>     ...
>     nct6776-isa-0290
>     Adapter: ISA adapter
>     ...
>     in5:            +2.04 V  (min =  +1.22 V, max =  +2.04 V)  ALARM
>     ...
> 
> A reboot does not help. I suspect that this is a bug, but I hope that I am
> the bug. :-)
> 
You can not go above 2.04V; that is the maximum supported by the ADC.
I would be a bug if you can not set the maximum to, say, 1.9V.
Question is if the input is connected to anything. Can you map it
to a voltage shown in the BIOS ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 25 Jul 2007 01:55:56 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707241855l2ef9582eyb5edf268fbc849e1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi cilly,


> Hi Juerg,
>
> > Who knows? There are other things the VIA engineers did that I don't
> > understand. For example not implementing fan control on the M10000.
>
> Well, according to specs on via site, my board should have fancontrol:
>
> http://www.via.com.tw/en/products/mainboards/motherboards.jsp?
> motherboard_idE1

Ah, you're right. That page does mention fan control. So maybe VIA did
learn something. You would be a perfect candidate to test the fan
control features of the vt1211 driver, if you had a fan...


> however:
>
> /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed

Not sure what pwmconfig does but the vt1211 chip is capable of
adjusting the fan speeds by itself and automatically based on temp
readings. The driver does support that (although it hasn't been
tested), it's just a matter of setting up the sysfs attributes
correctly.


> but, I think I do not care, since I don't have any fans connected. I
> now it pwmconfig did work while I had everything as a module, now I
> compiled the vt1211 stuff into the kernel. Probably, pwmconfig is
> using modprobe...
>
> > Uh-huh, very nice case!
>
> yes, but I had to dig many holes into it, since the heat didn't leave
> the case.
>
> > I'm using the default:
> > compute temp1  (@ - 73.869) / 0.9528,  (@ * 0.9528) + 73.869
> >
> > Even though it's for an Ezra and I don't really trust the readings. I
> > couldn't get an answer from VIA whether this is the correct
> > computation for the Nehemiah CPU or not.
> >
> > A while ago, somebody wrote to the list about not being happy with the
> > default and investigating further. Maybe you can search the archives
> > and contact that person to figure out what he found out. Or there's
> > always the possibility of attaching a thermal probe to CPU case and
> > use the thermal resistance values in the Nehemiah datasheet to
> > correlate driver and voltmeter readings.
>
> With that line the temperature readings are too low, at least for my
> board.
>
> I use:
>
> compute temp1 (@ - 65) / 0.9686, (@ * 0.9686) + 65
>
> which I used for PD 6000 (Samuel) and now for my new PE 10000
> (Nehemiah), both have the same bridge.

What do you mean by bridge? The temp reading comes straight from the
CPU. There's an internal thermal diode in the CPU that's connected to
the vt1211. There's no bridge involved here. It's only a function of
the CPU thermal diode properties (which are unknown for Nehemiah, at
least to me).

...juerg


> Regards,
>
> c.
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 25 Jul 2007 02:29:30 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707241929ud718cd1kdf53b0c799d3f0ac@mail.gmail.com>
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
> > Ah, you're right. That page does mention fan control. So maybe VIA did
> > learn something. You would be a perfect candidate to test the fan
> > control features of the vt1211 driver, if you had a fan...
>
> Would be not a problem to connect a fan... may be I will try it one
> day...
>
> > Not sure what pwmconfig does but the vt1211 chip is capable of
> > adjusting the fan speeds by itself and automatically based on temp
> > readings. The driver does support that (although it hasn't been
> > tested), it's just a matter of setting up the sysfs attributes
> > correctly.
>
> So you say, the fan will be adjusted by the cpu itself? Hm, so I
> should give it a try... do you recommend shutting down before
> connecting the fan?

No, I'm saying the fan will be adjusted by the vt1211 itself. No
interaction from the CPU required, all done in HW. Basically you can
set 4 temp and pwm points to control the behavior. Read
Documentation/hwmon/vt1211 and let me know if you still have
questions.

...juerg


> > What do you mean by bridge? The temp reading comes straight from the
> > CPU. There's an internal thermal diode in the CPU that's connected to
> > the vt1211. There's no bridge involved here. It's only a function of
> > the CPU thermal diode properties (which are unknown for Nehemiah, at
> > least to me).
>
> Ah okay, I am talking about southbridge, etc...
>
> Regards,
>
> c.
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

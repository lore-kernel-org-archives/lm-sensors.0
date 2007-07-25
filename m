From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 25 Jul 2007 04:26:12 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707242126k761d025fqa733d858d2bceaca@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > No, I'm saying the fan will be adjusted by the vt1211 itself. No
> > interaction from the CPU required, all done in HW. Basically you can
> > set 4 temp and pwm points to control the behavior. Read
> > Documentation/hwmon/vt1211 and let me know if you still have
> > questions.
>
> Okay, I connected the fan to the cpu fan plug and sensors lists it as
> a case fan.
>
> pwmconfig refuses to work with statically compiled into kernel:

Are you saying you compiled the vt1211 statically into the kernel and
not as a module?


> /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed

Hmm... What does 'ls /sys/class/hwmon*/*' return?

...juerg


> probably, this is a bug?
>
> Btw, I really miss a reply to header on that mailing-list. Second
> time the mail didn't go to the list.
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Fri, 26 Dec 2008 14:58:19 +0000
Subject: Re: [lm-sensors] Problems with fan speed control - chip w83627ehf
Message-Id: <4dfa50520812260658u7739b66dp8a42afeb7aeebaca@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9f8c28980812240937w6a12c0d6s90cba0242c0e2db9@mail.gmail.com>
In-Reply-To: <9f8c28980812240937w6a12c0d6s90cba0242c0e2db9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

It appears you can't control them with the w83627ehf. Good motherboard
documentation will sometimes say this (Asus motherboards admit it when
the fan can't be controlled). It sounds like your motherboard
documentation isn't going to be helpful.

You have done everything right to control the output of the w83627ehf.
All I can do is suggest that you start with the BIOS settings and try
to determine if the BIOS thinks it can control the fan speed.
Sometimes the southbridge has PWM output.

Good luck, and happy holidays,
David

On Wed, Dec 24, 2008 at 10:37 AM, Alex van der Molen
<alexvdmolen@gmail.com> wrote:
> Hello all,
>
> I have  a kino-lx mini-itx motherboard. Connected to it are two 3-pin fans.
> The chip for sensors and pwm control is w83627ehf, according to
> sensors-detect.
> The module reads all sensor values just fine, but when I try to alter the
> fan speed, nothing happens. After the lm-sensors applications didn't seem to
> do anything I dived into the kernel documentation and tried to do it
> manually. But no matter what I write to the pwm device files, the fans keep
> running on full speed, and when I put it in thermal cruise mode I can
> actually see that it alters pwm value, but again nothing happens.
>
> The motherboard documentation mentions that it should have this feature, but
> it looks like that documentation just copied all specifications of the
> hardware monitor chip (for example, it mentions being able to measure the
> speed of 5 fans, while only 2 can be connected to the board).
> Is it possible that this functionality just isn't available? Is it even
> possible to do fan speed control with a 3-pin fan (unfortunately our only
> option since we can't connect a 4-pin fan)?
> And if it's possible, what could I be doing wrong?
>
> Thanks in advance for any help and happy holidays!
>
> Alex
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

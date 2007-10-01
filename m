From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 01 Oct 2007 17:44:24 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <191fb4ca0710011044w253817f8icaa89162c529a842@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juergen,


On 9/25/07, Juergen Bausa <Juergen.Bausa@web.de> wrote:
> What does this mean (taken from /var/log/messages)?
>
> Sep 23 12:11:22 lisa kernel: dme1737 0-002e: Write to register 0x30 faile=
d! Please report to the driver maintainer.

What exactly is unclear about the message? The write fails (for
whatever reason). I should probably print out the return value as
well...
More interestingly is the register address. 0x30 is the current PWM
duty-cycle. It only gets written during driver initialization or if
userland does manual PWM control.


> I get this sometimes (every some hours). I use the dme1737.ko without on =
my asus system
> (Pundit P1-AH2) with Athlon BE-2350.

What apps are you running that touch the driver? Are you doing manual
PWM control?

...juerg


>
> Juergen
> _______________________________________________________________________
> Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
> kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=022220
>
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

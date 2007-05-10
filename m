From: Dieter Rogiest <dieter.rogiest@telenet.be>
Date: Thu, 10 May 2007 17:36:47 +0000
Subject: Re: [lm-sensors]
Message-Id: <200705101936.47212.dieter.rogiest@telenet.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thursday 10 May 2007 18:36:31 Dieter Rogiest wrote:
> Core0 Temp:
>              +17=B0C
> Core1 Temp:
>              +25=B0C
>
> How come temperature of Core0 is so low? Does this mean that Core0 is not
> used by my kernel (uname -r: 2.6.20.11-tmb-desktop-1mdvsmp )?
> What programs should I use so that Core0 is also used
> Are there shell commands by which I can let Core0 and Core1 work to their
> maximum?

I tried KPovModeler (Povray) and rendered a Pinocchio scene (am_pinoc.kpm).
I ran sensors while it was rendering:
Core0 Temp:
             +29=B0C
Core1 Temp:
             +36=B0C
Now I think Core0 is used by the povray rendering.

Dieter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

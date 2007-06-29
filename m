From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Jun 2007 06:04:11 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <20070629080411.4f86ffef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 28 Jun 2007 09:32:10 +0200 (CEST), Christian Emmerich wrote:
>  >Thus this algorithm actually return sane RPM values for you? Now I
>  >remember why I did not use this - Here the "Count" rises linear, which
>  >makes "RPM =3D(1.5=D710^6)/ Count" *lower* when fan speed increases. OT=
OH it
>  >might be the fan is just too small and thus rotates too fast to be
>  >reliably measured..
> =20
>  During implementation i tested  different values for pwm here are my res=
ults:
>  pwm1  fan1      fanspeed ( using: fanspeed =3D(1.5=D710^6)/ fan1-value )
>  value value
>   13   2600      ~570 rpm
>   14   1900       :
>   15   1900       :
>   23   1100       :
>   34    770     ~1950 rpm
>    :     :        :
>   90    385     ~3900 rpm
>   95    375     ~4000 rpm
>  100    365     ~4180 rpm
>  105    360     ~4230 rpm
>  110    345     ~4360 rpm
>  115    345     ~4360 rpm
>  120    335     ~4500 rpm
>  125    330     ~4630 rpm
> =20
> =20
>  So if i start my pc the pwm is at ~32 and the fan is turning at ~1800rpm=
. If i increase
>  the pwm value the value of the counter decreased!

Yes, this is expected. The counter value is proportional to the time
the fan needed to achieve one revolution, so a greater counter means a
slower fan and vice versa.

>  So if the pwm value is ~110 the van turns at >4000rpm
>  and the fan1 value is ~365.
>  The pc i use is a barebone by AOpen with an special mainboard and fan, b=
oth comes with the barebone.

It seems to work OK. So the conversion from count to RPM should be
moved to the kernel driver.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

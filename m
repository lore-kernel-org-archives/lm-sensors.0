From: Marcelo Coelho <marcelocoelho@gmail.com>
Date: Sun, 29 May 2011 21:59:15 +0000
Subject: Re: [lm-sensors] Working configuration for intel D945GCLF
Message-Id: <BANLkTin8nyh1mw4qndcJLKaNf0+-V-yfkw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTikVJz5rUrtdHEY82Lc8yoggnyA8HA@mail.gmail.com>
In-Reply-To: <BANLkTikVJz5rUrtdHEY82Lc8yoggnyA8HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,


>> chip "smsc47m1-*"
>> =A0 =A0 label fan1 "fan case"
>> # The minimum speed for fans with this chip is 1300. So, if you have a
>> disconnected fan
>> # your best option is to ignore it
>
> This statement is incorrect. The minimum speed actually depends on the
> fan clock divisor value, which can be 1, 2, 4 or 8. With a divisor
> value of 8, the minimum is 650 RPM.

Didn't know this. Thanks for the heads-up, although my idea was to set
the min to zero, because that fan is disconnected, and the driver said
it was an invalid value. Just wanted to avoid having ALARM in front of
it ...


> Updated, thanks.

You're welcome :)


Best regards,
Marcelo Coelho

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

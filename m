From: Carlos Olalla =?iso-8859-1?Q?Mart=EDnez?= <com.ea@tinet.org>
Date: Mon, 28 May 2007 12:37:19 +0000
Subject: Re: [lm-sensors] hwmon/w83627hf pwm_freq support
Message-Id: <1089.140.93.65.31.1180355839.squirrel@webmail.tinet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075.140.93.65.31.1179669141.squirrel@webmail.tinet.org>
In-Reply-To: <1075.140.93.65.31.1179669141.squirrel@webmail.tinet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> > +	u8 i;
> > +	/* Only 5 dividers (1 2 4 8 16)... Search for the nearest available
frequency */
> > +	for (i =3D 0; i < 5; i++) {
> > +		if (val > (((W83627HF_BASE_PWM_FREQ >> i) + (W83627HF_BASE_PWM_FREQ
>> (i+1))) / 2))
> > +			break;
> > +	}
> > +	return i;
> > +}

> This could return with i =3D 5, which isn't correct.

Hi Jean,

I dont agree on your statement; I think

for (i =3D 0; i < 5; i++)

is the same as

for (i =3D 0; i <=3D 4; i++)

so maximum i returned is 4. Am I wrong?=BF

Carlos



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

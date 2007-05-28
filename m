From: "Dmitry Bely" <dmitry.bely@gmail.com>
Date: Mon, 28 May 2007 12:54:32 +0000
Subject: Re: [lm-sensors] hwmon/w83627hf pwm_freq support
Message-Id: <90823c940705280554k6bd1c4ecya8f88d9b88d4f952@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075.140.93.65.31.1179669141.squirrel@webmail.tinet.org>
In-Reply-To: <1075.140.93.65.31.1179669141.squirrel@webmail.tinet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 5/28/07, Carlos Olalla Mart=EDnez <com.ea@tinet.org> wrote:
> > > +   u8 i;
> > > +   /* Only 5 dividers (1 2 4 8 16)... Search for the nearest availab=
le
> frequency */
> > > +   for (i =3D 0; i < 5; i++) {
> > > +           if (val > (((W83627HF_BASE_PWM_FREQ >> i) + (W83627HF_BAS=
E_PWM_FREQ
> >> (i+1))) / 2))
> > > +                   break;
> > > +   }
> > > +   return i;
> > > +}
>
> > This could return with i =3D 5, which isn't correct.
>
> Hi Jean,
>
> I dont agree on your statement; I think
>
> for (i =3D 0; i < 5; i++)
>
> is the same as
>
> for (i =3D 0; i <=3D 4; i++)
>
> so maximum i returned is 4. Am I wrong?

Of course, wrong:

for (i =3D 0; i < 5; i++){
}
// i =3D 5 here

- Dmitry Bely

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

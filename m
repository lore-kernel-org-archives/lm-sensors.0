From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 18 Jun 2007 15:52:12 +0000
Subject: Re: [lm-sensors] question about dyn chip support generic temp print
Message-Id: <191fb4ca0706180852v18005c2ata2e657afaba6034e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46767C9D.8040006@hhs.nl>
In-Reply-To: <46767C9D.8040006@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 6/18/07, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> Hi all,
>
> As said already I'm working on the fintek 71882 driver, I've currently gi=
ven it
> a tempX_input tempX_max tempX_max_hyst and a tempX_crit, with the current=
 dyn
> chip + generic print support this results in:
> CPU:            +38.0=B0C  (high =3D +80.0=B0C, hyst =3D  +4.0=B0C)  sens=
or =3D transistor
> temp1_crit:     +81.0=B0C
>
> This is because currently for max + hyst chips the first line gets printe=
d, and
> then for chips which have a crit to a sensors_get_label_and_valid is done=
 on
> the sensors_feature_data describing tempX_crit. Wouldn't it be better to =
reuse
> the main temp label and value, resulting in:
> CPU:            +38.0=B0C  (high =3D +80.0=B0C, hyst =3D  +4.0=B0C)  sens=
or =3D transistor
> CPU:            +38.0=B0C  (crit =3D +81.0=B0C)
>
> Maybe change the label into all whitespace / "CPU (continued)"? The curre=
nt
> printout seems very wrong, but my suggested one doesn't feel right either.

Hmm... Neither looks right to me. I can see user comments/bug reports
flying in...
Isn't there a way to make the print routine collect all the data and
print in on a single line?

And our sysfs standard defines hyst to be an absolute value, not relative.


> Also as already "explained" in my previous question, this chip has one
> hysteresis for both max and crit, now to make the current code work I wou=
ld
> need to put that twice into sysfs, which would result in to both changing=
 if
> one gets written (I can make only one rw to make this obvious).

That should be OK. I did something similar in the vt1211 where a
single register was exported twice and one of the attributes was
read-only.

...juerg


> Or we need to add a tempX_hyst type, and update the generic temp print co=
de to
> handle this scenario too.
>
>
> Regards,
>
> Hans
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

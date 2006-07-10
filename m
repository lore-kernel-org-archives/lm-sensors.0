From: bezaur@gmail.com (Charles Spirakis)
Date: Mon, 10 Jul 2006 17:40:04 +0000
Subject: [lm-sensors] Patch to fully support W81791D
Message-Id: <5bfe43f80607101040q5fe64dfdi4e7e2ce349407d62@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sven --

I'm a little confused. There is a patch already going into the 2.6
tree to include 83791d support (see
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-June/016638.html).

Looking at this patch you are touching the w83781d driver and you
mention the 2.1.18 kernel. Is this meant for an older kernel? Was this
meant for the 2.6 kernel? And if it is meant for the 2.6 kernel, does
it do something more or better than the one listed in the url above?

-- charles


On 7/10/06, Sven Anders <anders at anduras.de> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> Hello!
>
> I've attached a patch to fully support the W81791D chip, which is part of the
> coming kernel 2.1.18.
>
> Partial support was alredy implemented, but it was missing IN9/FAN4/FAN5 output.
>
> Please add it to the SVN.
>
> Thanks,
>  Regards
>    Sven
>
> - --
>  Sven Anders <anders at anduras.de>                 () Ascii Ribbon Campaign
>                                                  /\ Support plain text e-mail
>  ANDURAS service solutions AG
>  Innstra?e 71 - 94036 Passau - Germany
>  Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 50-55
>
> Rechtsform: Aktiengesellschaft - Sitz: Passau - Amtsgericht Passau HRB 6032
> Mitglieder des Vorstands: Sven Anders, Marcus Junker, Michael Sch?n
> Vorsitzender des Aufsichtsrats: Dipl. Kfm. Thomas Tr?ger
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2.1 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQFEsjPI5lKZ7Feg4EcRAuCfAJ4py+TYmbnRSzQhOW8g7mls2juCUACfQ+Dg
> 4Wc9L9KsPo1BvYB8VNaWzws> vbb
> -----END PGP SIGNATURE-----
>
>
>


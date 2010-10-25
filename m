From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Oct 2010 14:53:10 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <20101025165310.6dc49ee2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Please don't top-post.

On Mon, 25 Oct 2010 07:45:16 -0700 (PDT), Mahmood Naderan wrote:
> What does this statement mean in the wiki page:
> (2009-12-06) Embedded sensors are known to be unreliable on the DR-BA, DR=
-B2,=20
> DR-B3, RB-C2 and HY-D0 revisions of the family 10h CPU, which will never =
be=20
> supported. Driver contributed by Clemens Ladisch, reviewed by Jean Delvar=
e.

It means exactly what is written, what else?

> Should I download and install=A0the=A0stand=A0alone driver (Makefile and =
k10temp.c)=20
> separetly?

If your kernel doesn't include this driver, yes.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

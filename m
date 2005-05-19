From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [freddy2_es@yahoo.com: a question about i2c]
Message-Id: <20040706185549.GA1840@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

----- Forwarded message from Alfredo Quesada S?nchez <freddy2_es@yahoo.com>=
 -----

From: Alfredo Quesada S?nchez <freddy2_es@yahoo.com>
Subject: a question about i2c
To: frodol@dds.nl
X-Virus-Scanned: clamd / ClamAV version 0.73, clamav-milter version 0.73a
	on morannon.frodo.local
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on morannon.frodo.lo=
cal
X-Spam-Status: No, hits=3D-4.9 required=3D5.0 tests=BAYES_00 autolearn=3Dha=
m=20
	version=3D2.63
X-Spam-Level:=20

hi

i've downladed i2c-2.8.7 and i was trying to compile it, but i
receive this error message:

kernel/i2c-philips-par.c: En el nivel principal:
kernel/i2c-philips-par.c:141: error: el elemento inicializador
no es constante
kernel/i2c-philips-par.c:141: error: (near initialization for
`bit_lp_data.timeout')
kernel/i2c-philips-par.c:150: error: el elemento inicializador
no es constante
kernel/i2c-philips-par.c:150: error: (near initialization for
`bit_lp_data2.timeout')
make: *** [kernel/i2c-philips-par.o] Error 1

at this point we can find the next:

static struct i2c_algo_bit_data bit_lp_data =3D {
        .setsda         =3D bit_lp_setsda,
        .setscl         =3D bit_lp_setscl,
        .getsda         =3D bit_lp_getsda,
        .getscl         =3D bit_lp_getscl,
        .udelay         =3D 80,
        .mdelay         =3D 80,
        .timeout        =3D HZ
};

i'm not sure but i think it should be so:

..
        .timeout        =3D HZ,
};

but this constant is found at <linux/hz.h> and not at the
included header files (at least here in my suse 9.0 distro)

how can i solve this problem?

thx :)

regards


	=09
______________________________________________
Renovamos el Correo Yahoo!: ?100 MB GRATIS!
Nuevos servicios, m?s seguridad
http://correo.yahoo.es

----- End forwarded message -----

--=20
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~fr=
odol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually follow=
ed
  by the installation of Linux or some other Unix-like operating system.

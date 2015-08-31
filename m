From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 31 Aug 2015 07:37:04 +0000
Subject: Re: [lm-sensors] compilation under musl
Message-Id: <20150831093704.49a86e24@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+BsyQ7oUSF73bHio+L9pZGTTzsYbWmSVifgXTR_4zRrABShMA@mail.gmail.com>
In-Reply-To: <CA+BsyQ7oUSF73bHio+L9pZGTTzsYbWmSVifgXTR_4zRrABShMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Brendan,

On Sun, 30 Aug 2015 22:21:00 +0100, Brendan Heading wrote:
> You may be aware of the musl C-library implementation, which tries to
> be strictly standards compliant, avoids non-standard extensions, etc.
> Some distributions have adopted it as their standard C library, in
> others (such as buildroot) it is a configuration alternative.
>=20
> Vanilla lm-sensors does not compile under musl, due to the following
> excerpt which appears in four different places. The code is checking
> that the glibc version is greater than 2.0.
>=20
> #if defined(__GLIBC__) && __GLIBC__ =3D 2 && __GLIBC_MINOR__ >=3D 0
> #include <sys/io.h>
> #else
> #include <asm/io.h>
> #endif
>=20
> This fails under musl does not define __GLIBC__ (in fact, by design,
> it doesn't provide any way to identify itself at all) - which causes
> it to try to include <asm/io.h> rather than <sys/io.h>.
>=20
> It's a long time since glibc 2.0.1 was released - 1997. Accordingly,
> it seems to make little sense at this stage to try to retain
> compatibility with very old libcs - so maybe it should be removed
> entirely as per the following patch ? :
>=20
> http://git.alpinelinux.org/cgit/aports/plain/main/lm_sensors/musl-fix-inc=
ludes.patch?id=FEce1d19448dbd3a56fd8ac70443116187141848
>=20
> Is there any chance that this patch could be considered for inclusion
> in the main lm-sensors tree ?

Agreed. Patch committed with further cleanups (moving <sys/...>
includes to the top of the list):
http://www.lm-sensors.org/changeset/6314

Thanks for your contribution.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Brendan Heading <brendanheading@gmail.com>
Date: Sun, 30 Aug 2015 21:21:00 +0000
Subject: [lm-sensors] compilation under musl
Message-Id: <CA+BsyQ7oUSF73bHio+L9pZGTTzsYbWmSVifgXTR_4zRrABShMA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi guys,

You may be aware of the musl C-library implementation, which tries to
be strictly standards compliant, avoids non-standard extensions, etc.
Some distributions have adopted it as their standard C library, in
others (such as buildroot) it is a configuration alternative.

Vanilla lm-sensors does not compile under musl, due to the following
excerpt which appears in four different places. The code is checking
that the glibc version is greater than 2.0.

#if defined(__GLIBC__) && __GLIBC__ =3D 2 && __GLIBC_MINOR__ >=3D 0
#include <sys/io.h>
#else
#include <asm/io.h>
#endif

This fails under musl does not define __GLIBC__ (in fact, by design,
it doesn't provide any way to identify itself at all) - which causes
it to try to include <asm/io.h> rather than <sys/io.h>.

It's a long time since glibc 2.0.1 was released - 1997. Accordingly,
it seems to make little sense at this stage to try to retain
compatibility with very old libcs - so maybe it should be removed
entirely as per the following patch ? :

http://git.alpinelinux.org/cgit/aports/plain/main/lm_sensors/musl-fix-inclu=
des.patch?id=FEce1d19448dbd3a56fd8ac70443116187141848

Is there any chance that this patch could be considered for inclusion
in the main lm-sensors tree ?

regards

Brendan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: kevin@labsysgrp.com (Kevin P. Fleming)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Patch for lm_sensors-2.6.3 Makefile to support user specified CFLAGS  and CPPFLAGS
Message-Id: <000a01c1ee6f$c3a5ad40$6caaa8c0@KPFW2K>
List-Id: <lm-sensors.vger.kernel.org>
References: <007d01c1ed3c$b2c0b940$6caaa8c0@KPFW2K>
In-Reply-To: <007d01c1ed3c$b2c0b940$6caaa8c0@KPFW2K>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Nope, CPPFLAGS is for the c preprocessor (all your -D defines, -I
directories, etc.). CFLAGS is for the actual  C compiler. Granted, most of
the time both of those steps are done in one pass, but this change makes it
so someone can override CPPFLAGS, say, to just add another -D define without
messing with the CFLAGS for optimization settings or anything.

I almost went through the same steps for LDFLAGS (for the linker), but most
people don't mess with those much. In my case, I was just be anal and
compiling everything in sight with -O3 -mcpu=athlon =march=athlon to see
what broke :-) (so far, nothing has, it all works, even GCC 3.0.4 itself,
amazing :-)

----- Original Message -----
From: "Mark D. Studebaker" <mds@paradyne.com>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: <sensors@stimpy.netroedge.com>
Sent: Saturday, April 27, 2002 9:32 PM
Subject: Re: Patch for lm_sensors-2.6.3 Makefile to support user specified
CFLAGS and CPPFLAGS


> good idea - but isn't CPPFLAGS for c++?
> Why do we need both CFLAGS and CPPFLAGS?
>
> "Kevin P. Fleming" wrote:
> >
> > The attached patch allows the user to add CFLAGS and CPPFLAGS entries
(via
> > the environment or the make command line) and have them actually get
used
> > compiling the lm_sensors objects... I used this because I wanted to try
> > other optimization settings without massaging the Makefile every time.
> > Enjoy!
> >
> >
> >                                 Name: lm_sensors-Makefile.patch
> >    lm_sensors-Makefile.patch    Type: unspecified type
(application/octet-stream)
> >                             Encoding: quoted-printable
>
>

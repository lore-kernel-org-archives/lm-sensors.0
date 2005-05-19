From: thomas.jarosch@intra2net.com (Thomas Jarosch)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [patch] i2c 2.9.1 compile fix
Message-Id: <200504302324.58234.thomas.jarosch@intra2net.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504291721.34111.thomas.jarosch@intra2net.com>
In-Reply-To: <200504291721.34111.thomas.jarosch@intra2net.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > attached is a patch to fix i2c-algo-bit.c compilation.
> > It was lacking the KERNEL_VERSION macro.
> >
> > Please CC: comments.
>
> Great catch. For some reason it wasn't blocking the compilation for me,
> nor anyone else I guess, or we would have heard of it before - but that
> was still bad.

Now comes the funky part: I compile my kernel with MODVERSIONS.
Only the compilation of the ".ver" file failed during the build process.
This results in mismatching module symbols for i2c-core and i2c-algo-bit 
afterwards, so I was unable to load the module and had to take a closer look.

> I opted for a different fix, dropping the conditional altogether. This
> branch of i2c is meant for Linux 2.4 only, so there's no point in
> keeping Linux 2.5+ compatibility code in there.

Nice.

Cheers,
Thomas

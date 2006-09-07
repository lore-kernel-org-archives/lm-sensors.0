From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 07 Sep 2006 14:27:16 +0000
Subject: [lm-sensors] libsensors config file scanner speed
Message-Id: <20060907162716.2304cca8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060906033418.GA7775@jupiter.solarsys.private>
In-Reply-To: <20060906033418.GA7775@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Mark,

> I've committed all of my work to date on the libsensors config file scann=
er
> to SVN.  It is on the branch called scanner-opt-branch.  I'm pretty happy
> about the results so far...
>=20
> # w/ w83627hf loaded
> # also, use DEBUG:=3D1 in the Makefile
>=20
> $ valgrind --tool=CAllgrind sensors -u -c etc/sensors.conf.eg
> $ kcachegrind callgrind.out.NNNN
>=20
> Total cycles before:		~11.2M
> Total cycles after:		~ 7.3M
> Total speedup:		~ 1.5x
>=20
> Scanner cycles before:	~ 5.9M
> Scanner cycles after:		~ 2.0M
> Scanner speedup:		~ 3.0x

Really nice. I've been doing some measurements on my machine and here
are my results. I assumed that what you call "scanner cycles" is the
cycle count for sensors_yylex, and "total cycles" is the cycle count
for main.

Total cycles before:	~11.3M
Total cycles after:	~ 8.2M
Total speedup:		~ 1.4x

Scanner cycles before:	~ 5.1M
Scanner cycles after:	~ 1.9M
Scanner speedup:	~ 2.7x

This is on x86_64.

Another interesting point of comparison is when using the dedicated
configuration file I have for this test machine, instead of the
fat default one:

Total cycles before:	~ 4.7M
Total cycles after:	~ 4.5M
Total speedup:		~ none

Scanner cycles before:	~ 267k
Scanner cycles after:	~ 138k
Scanner speedup:	~ 1.9x

I guess the result isn't a surprise, if the configuration file is
smaller, the amount of time spent in the scanner has to be smaller as
well, thus the overall speed improvement is lower.

If we anaylze the benefit of the configuration file change (without
taking your scanner optimizations in consideration) we obtain:

Total cycles before:	~11.3M
Total cycles after:	~ 4.7M
Total speedup:		~ 2.4x

Scanner cycles before:	~ 5.1M
Scanner cycles after:	~ 267k
Scanner speedup:	~  19x

Not to discourage you from working on the scanner, every additional
improvement is welcome... But just to underline the well known fact
that sensors.conf.eg has grown much larger than the original authors of
libsensors thought it ever would, and as a result 95% of the
configuration file we install by default is useless for each user, and
ruins the "sensors" performance. This means that we really need
dedicated configuration files for people to use instead of the default
configuration file.

Other possible approachs:
* Having a smaller dedicated configuration file which would only
  contain the safest defaults (chip manufacturer recommended compute
  lines and labels). The rest could be moved to documentation.
* Having a separate default file for each chip, and copying it (or
  merging them) to /etc/sensors.conf when the user runs sensors-detect.
* Delaying the scanning of the configuration data until after we know
  which chips have been found of the system. So we could happily skip
  the data which has not been found.

Or maybe it's more interesting to put our energy in the configuration
files database, and let the default configuration file as is in the
hope that people won't use it anymore anyway.

BTW, if anyone wants to compile kcachegrind (very impressive tool,
thanks for making me discover it) on x86_64, the key for me was to pass
--enable-libsuffixd to the configure script. Without it, configure
would fail to find the right libraries.

> I'm going to keep it on the branch until (1) we release 2.10.1, and (2) I
> create some sort of regression test for it.  For now at least, it has no
> *known* bugs.  Give it a try; let me know if you have trouble.

Sounds like a good plan to me, thanks for working on this.

--=20
Jean Delvare


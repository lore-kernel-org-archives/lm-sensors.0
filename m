From: killers_soul@hotmail.com (Jason Longland)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: nforce2 i2c module compilation
Message-Id: <000a01c35bf7$d5cdcd30$0100a8c0@downstairs>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c35b57$0985ec80$0100a8c0@downstairs>
In-Reply-To: <000f01c35b57$0985ec80$0100a8c0@downstairs>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

cool... ok...

> 1* Did you compile and install i2c-2.8.0 before trying to compile
> lm_sensors? Did it produce any error or warning?
>

yes i certainly did in all cases, in one case where i had been using
2.4.21-ck3 i patched the kernel and set it up as modules that way just to
try when running sensors-detect although i know that it doesn't patch the
nforce2 i2c module in that way although i did find that alan cox included it
in his 2.6.0-test1-ac3 patch, shame no one else does for 2.4 or any other
kernel


> 2* Is /lib/modules/2.4.20-19.9/build pointing to a real directory, with
> sources that match your running kernel? Does this dir have a .config
> file that also match your current config?
>

by default with recent rh kernels it seems /lib/modules/<insert version
here...>/build is actually a real directory, no symlinks involved,
containing all the necessary headers and configuration bits and pieces to
compile the 3rd party modules (or whatever the case may be)

at the moment though my kernel version is 2.4.21-something-or-ther... as i'm
using severn, or trying to...

> 3* Is /usr/include/asm a real directory or a symlink? To what?
>

yes /usr/include/asm IS a real directory, again no symlinks containing i
assume are the include headers for building asm related programs

> 4* What if you disable the i2c-nforce2 module (edit
> kernel/busses/Module.mk)? Does the compilation fail on next module, or
> goes on?

no idea at the moment as i'm in windblows but will let you know when i give
it a shot shortly



*********************************************************************

All messages originating from me are digitally signed to
ensure authenticity.

If any message is not signed it could be due to one of the following to
reasons:

1.  my email client isn't working and I've had to use the web browser
2.  it isn't from me and could be a virus

All content contained herein is copyright (or copyleft...) of the sender.

All messages are scanned using the latest virus definitions
for Norton Antivirus 2003 prior to sending.

*********************************************************************
-----BEGIN PGP SIGNATURE-----
Version: PGP 8.0

iQA/AwUBPzDBWk9XUfpwf1ScEQKwvQCfckdTWILz8mcssDW1NgTg5sa1bogAnjOJ
97Wog3ory/3gFY64tF1pmYfi
=9vtA
-----END PGP SIGNATURE-----


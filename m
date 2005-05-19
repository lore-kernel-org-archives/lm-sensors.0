From: ishikawa@yk.rim.or.jp (Ishikawa)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: Compiling lm_sensors module with gcc 3.3. (A problem and
Message-Id: <3EFCC2C4.5D68A02E@yk.rim.or.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF4DD25.6000802@yk.rim.or.jp>
In-Reply-To: <3EF4DD25.6000802@yk.rim.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thank you for the great softwar packages.

In a post a few days ago, I mentioned
about a strange problem caused by 
locale setting during i2c compilation.
 
I tracked down the cause of a strange include header
problem when I tried the lm_sensors CVS version (with
the proper i2c lk24). This has to do something to do with
the Makefile.

Again this is with GCC 3.3.

First thing first, a short work around.

Tell the users that
always compile i2c/lm_sensors using the following environment variable setting.

	LANG=C
	LC_ALL=C

But a short rewrite of Makefile also saves the day.

Detailed Analysis (and another remedy):

(I can't easily include the problem output from make since
it contains Japanese strings, so I explain
the background analysis and remedy here.)

The new rules of  GCC's include header handling is such that

 - so called local "system header" directories are not
   included despite explicit -I specficiation 
   e.g. -I/usr/local/include is not handled. It is ignored.

 - however using -nostdinc we can override the 
   above behavior and then -I specification is properly handled.

	-nostdinc -I/usr/local/include

GCC "-print-search-dirs" option prints out the
searched directories for GCC's "standard" headers.
So if we specify -nostdinc, and still want to
search for the default headers AFTER our directories given by
-I specifications,
then we can add the directories printed by -print-search-dirs
AFTER our own local "system" headers given by -I specifications.

Now there is a hitch with the internationalization (I18N)/
localization (L10N) of GCC command itself. Some messages from GCC are
now translated into local languages.

In particular, the normal output of

	gcc -print-search-dirs

get slightly modified depending on the setting of environment variable
LC_ALL (and possibly LANG as well) (!).

Case in point.

Under the standard C locale, this is what we get.

ishikawa@duron$ export LC_ALL=C LANG=C
ishikawa@duron$ gcc -print-search-dirs
install: /usr/lib/gcc-lib/i386-linux/3.3/
programs: =/usr/lib/gcc-lib/i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/:/usr/lib/gcc/i386-linux/3.3/:/usr/lib/gcc/i386-linux/:/usr/lib/gcc-lib/i386-linux/3.3/../../../../i386-linux/bin/i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/3.3/../../../../i386-linux/bin/
libraries: =/usr/lib/gcc-lib/i386-linux/3.3/:/usr/lib/gcc/i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/3.3/../../../../i386-linux/lib/i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/3.3/../../../../i386-linux/lib/:/usr/lib/gcc-lib/i386-linux/3.3/../../../i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/3.3/../../../:/lib/i386-linux/3.3/:/lib/:/usr/lib/i386-linux/3.3/:/usr/lib/

Now comes the interesting part.

Under Japanese locale, here is what
we get. (I modify a few strings since I know many e-mail readers
mangle Japanese characters.)

ishikawa@duron$ export LC_ALL=ja_JP.ujis LANG=ja_JP.ujis
ishikawa@duron$ gcc -print-search-dirs
[[Install]]: /usr/lib/gcc-lib/i386-linux/3.3/
[[Program]]: =/usr/lib/gcc-lib/i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/:/usr/lib/gcc/i386-linux/3.3/:/usr/lib/gcc/i386-linux/:/usr/lib/gcc-lib/i386-linux/3.3/../../../../i386-linux/bin/i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/3.3/../../../../i386-linux/bin/
[[Library]]: =/usr/lib/gcc-lib/i386-linux/3.3/:/usr/lib/gcc/i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/3.3/../../../../i386-linux/lib/i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/3.3/../../../../i386-linux/lib/:/usr/lib/gcc-lib/i386-linux/3.3/../../../i386-linux/3.3/:/usr/lib/gcc-lib/i386-linux/3.3/../../../:/lib/i386-linux/3.3/:/lib/:/usr/lib/i386-linux/3.3/:/usr/lib/
ishikawa@duron$ 

Actually in the above, I rewrote the three strings that come before the ":"
into ASCII strings since many won't be able to read them.

	[[Install]] ... Originally, it was a non-ascii Japanese
			character string that stands for `install'.

	[[Program]] ... A non-ascii Japanese character string that stands 
	                for `program'.

	[[Library]] ... A non-ascii Japanese character string that stands 
	                for `library'.
	

(Please note that there a few variations of
Japanese locale, especially the choice of character coding system, 
and the above setting is a particular
setup I use under Debian GNU/Linux. LC_ALL=ja_JP.euc / LC_ALL=ja_JP.sjis /
LC_ALL=japanese are what I have observed on other unices.
So if you talk to other Japanese developers, you will find that
they may use slightly different locale settings).

So, why is this a problem?

In the i2c/Makefile, we have the following snipet of code to
deal with the GCC's handling of header files: we need to
specify our own "local" system header file first, and
still want to include the standard header directories afterward.

Please note the use of string literal "install" in the
SED command to look for the standard include directory in
GCC -print-search-dirs output.

--- begin quote ---
# This magic is from the kernel Makefile.
# Extra cflags for kbuild 2.4.  The default is to forbid includes by kernel code
# from user space headers.
kbuild_2_4_nostdinc := -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
MODCPPFLAGS += $(CPPFLAGS) $(kbuild_2_4_nostdinc)
--- end quote

This doesn't work well under Japanese locale since
string literal "install" doesn't appear in the fist line of
GCC -print-search-dirs (!).

As a result, during compilation of i2c,
this caused a non-found header files problems. (That is,
header files given
in i2c source files as #include targets,
and not found under linux kernel header files,
but available in the GCC's standard header files. Got it?).

[Remedy] So what should we do?

1. In README/INSTALL,  we may want to warn the users to use  the following
   environment setting before compilation.
	
   export LC_ALL=C LANG=C (Bourne-shell, bash)

   setenv LC_ALL C	(C-shell)
   setenv LANG C

   But how many people in non-ASCII usage world 
   will complain about the problem
   without reading the fine prints in these documentation?

   So I prefer the second choice in the following.

2. We may rewrite the above Makefile snippet to
   use env LC_ALL=C LANG=C $(CC) ...   as follows.

   kbuild_2_4_nostdinc := -nostdinc $(shell env LC_ALL=C LANG=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')

  I just checked the operation and this indeed solved strange problem
  observed locally here under Japanese locale setting.

  Since this may be bullet-proof as far as I can tell, this is
  the preferred solution.
  (UNLESS, of course, the GCC maintainer in their infinite wisdom
   change the output format of -print-search-dirs. However, this is unlikely.
   Many embedded programming folks, who use GCC under
   cross compiler setting,
   depend on this feature very much. I am sure that
   many scripts depending on the output have been written. But who knows?! 
   Come to think of it, in the unlikey case that the output format changes, 
   the current makefile will break anyway under the default locale, though. )


3. I am going to write to GCC maintainers that
   at least THIS PARTICULAR OUTPUT from GCC should be saved from the mangling 
   done by I18N/L10N  translation scheme
   since some program depends on the particular format of output (!).
  (Actually I don't like the translated output of other parts of GCC
   since it may break other programs/scripts...)

   Now, as to why Linux kernel doesn't seem to suffer from this
   LANG/LC_ALL problem,  I am not sure...
   Maybe they don't grep the output from GCC? (Or probably resets LC_ALL
   somewhere in the chain of commands before the particular
   $(CC) -print-search-dirs is invoked.

   At least, it is known that the timestamp string buried in 
   Linux's "uname -a" output follows the LC_ALL/LANG setting at the
   time of kernel compilation. So under my linux setting,
   "uname -a" contains Japanese date/time string and
   this causes a problem when I try to report some kernel/application
   bugs to maintainers : not all editors are equipped to handle
   Japanese characters well. So I have to remove the Japanese strings from
   uname output.

Anyway, I hope the remedy suggested by [2] above
is included in Makefile somehow.

Happy Hacking,

Ishikawa, Chiaki

PS: It took me several hours of scratching my head
and doubting the operation of bash, sed, make and gcc
under different locale settings until
I found why the output left in kernel/i2c-*.d
are different under different locale settings.
(Sun's Solaris 2.5.1 broke some programs
under Japanese locale settings and so I am not
that surprised to find breakage caused by
more I18N/L10N programs. We just eradicate bugs
one by one...)

PPS: In the previous post,
I noted that asm/system.h caused a lot of
warning which we can't do a thing during
compilation of lm_sensors CVS modules.

I wrote to linux-kernel mailing list a suggestion to
patch asm/system.h (for x86). I am not sure
if such rewriting will be done or not.

At the same time,
I have found out why the linux kernel compilation
itself doesn't complain about this header.
Adding -fno-strict-alias to GCC shuts up this
particular warning. But I am not sure
if this is a good idea or not for i2c/lm_sensors
compilation.

Obviously the linux kernel maintainer decided
to shut up the warnings for now rather than
tackle the potential (real and bogus) problem of various
tricky C code accumulated over the years.
It would be some time before GCC's such new warnings
can be effectively enabled for linux kernel compilation.
(Maybe version 3.0 or 4.0?!)

Again thank you for the great packages.

-- 
int main(void){int j 03;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */

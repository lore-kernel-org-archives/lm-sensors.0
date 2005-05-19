From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: Compiling lm_sensors module with gcc 3.3. (A problem and
Message-Id: <20030630150918.679ae52b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF4DD25.6000802@yk.rim.or.jp>
In-Reply-To: <3EF4DD25.6000802@yk.rim.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(BTW, GCC 3.2 suffers the same problem.)

> [Remedy] So what should we do?
> 
> 1. In README/INSTALL,  we may want to warn the users to use  the
> following
>    environment setting before compilation.
> 	
>    export LC_ALL=C LANG=C (Bourne-shell, bash)
> 
>    setenv LC_ALL C	(C-shell)
>    setenv LANG C
> 
>    But how many people in non-ASCII usage world 
>    will complain about the problem
>    without reading the fine prints in these documentation?
> 
>    So I prefer the second choice in the following.

Same for me. I don't expect the users to read the docs. I usually don't
read them first, and look at them only when I really have to. Solution
#2 is much more elegant IMHO.

> 2. We may rewrite the above Makefile snippet to
>    use env LC_ALL=C LANG=C $(CC) ...   as follows.
> 
>    kbuild_2_4_nostdinc := -nostdinc $(shell env LC_ALL=C LANG=C $(CC)
>    -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
> 
>   I just checked the operation and this indeed solved strange problem
>   observed locally here under Japanese locale setting.
> 
>   Since this may be bullet-proof as far as I can tell, this is
>   the preferred solution.
>   (UNLESS, of course, the GCC maintainer in their infinite wisdom
>    change the output format of -print-search-dirs. However, this is
>    unlikely. Many embedded programming folks, who use GCC under
>    cross compiler setting,
>    depend on this feature very much. I am sure that
>    many scripts depending on the output have been written. But who
>    knows?! Come to think of it, in the unlikey case that the output
>    format changes, the current makefile will break anyway under the
>    default locale, though. )

OK for that. It's rather easy. Another user reported the problem to me
this morning, and the fix worked. I'll commit it to CVS (for both i2c
and lm_sensors). One question however. It seemed to me that setting
LC_ALL=C was sufficent. In which case do you believe LANG also has to be
set? I'm not a locale expert (never used them for myself), so I may be
missing something obvious. Also should we use =C or =POSIX? Is there a
difference?

> 3. I am going to write to GCC maintainers that
>    at least THIS PARTICULAR OUTPUT from GCC should be saved from the
>    mangling done by I18N/L10N  translation scheme
>    since some program depends on the particular format of output (!).
>   (Actually I don't like the translated output of other parts of GCC
>    since it may break other programs/scripts...)
> 
>    Now, as to why Linux kernel doesn't seem to suffer from this
>    LANG/LC_ALL problem,  I am not sure...
>    Maybe they don't grep the output from GCC? (Or probably resets
>    LC_ALL somewhere in the chain of commands before the particular
>    $(CC) -print-search-dirs is invoked.
> 
>    At least, it is known that the timestamp string buried in 
>    Linux's "uname -a" output follows the LC_ALL/LANG setting at the
>    time of kernel compilation. So under my linux setting,
>    "uname -a" contains Japanese date/time string and
>    this causes a problem when I try to report some kernel/application
>    bugs to maintainers : not all editors are equipped to handle
>    Japanese characters well. So I have to remove the Japanese strings
>    from uname output.

I agree. I don't like translations anyway. Never used french
translations when I could avoid them, since I hardly can understand what
the translations mean. I believe english is the natural language of
computer science, and it will stay that way for a long time (my
opinion).

> Anyway, I hope the remedy suggested by [2] above
> is included in Makefile somehow.

Work in progress (waiting for your answer actually).

There is a fourth solution we could think of. If the "install" list is
always the first one returned by gcc -print-search-dirs (and I guess it
is) then we don't need to match the label. The following does the job:
  gcc -print-search-dirs | head -1 | sed -ne 's/[^:]*: \(.*\)/-I
\1include/gp'
Now, is it more or less robust than solution #2? That I can't say. Both
solutions work on systems I tested them on, but that doesn't mean
anything for the million systems out there.

> Happy Hacking,

Thanks a lot for your help!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

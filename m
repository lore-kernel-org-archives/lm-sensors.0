From: ishikawa@yk.rim.or.jp (Ishikawa)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: Compiling lm_sensors module with gcc 3.3. (A problem and
Message-Id: <3F009FE5.DA7241F3@yk.rim.or.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF4DD25.6000802@yk.rim.or.jp>
In-Reply-To: <3EF4DD25.6000802@yk.rim.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
Jean Delvare wrote:

> Same for me. I don't expect the users to read the docs. I usually don't
> read them first, and look at them only when I really have to. Solution
> #2 is much more elegant IMHO.

Agreed for now.

> > 2. We may rewrite the above Makefile snippet to
> >    use env LC_ALL=C LANG=C $(CC) ...   as follows.
> >
> >    kbuild_2_4_nostdinc := -nostdinc $(shell env LC_ALL=C LANG=C $(CC)
> >    -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
> >
> >   I just checked the operation and this indeed solved strange problem
> >   observed locally here under Japanese locale setting.
> >
> >   Since this may be bullet-proof as far as I can tell, this is
> >   the preferred solution.
> >   (UNLESS, of course, the GCC maintainer in their infinite wisdom
> >    change the output format of -print-search-dirs. However, this is
> >    unlikely. Many embedded programming folks, who use GCC under
> >    cross compiler setting,
> >    depend on this feature very much. I am sure that
> >    many scripts depending on the output have been written. But who
> >    knows?! Come to think of it, in the unlikey case that the output
> >    format changes, the current makefile will break anyway under the
> >    default locale, though. )
> 
> OK for that. It's rather easy. Another user reported the problem to me
> this morning, 

Glad to hear that it was not only me.
I wrote to GCC mailing list and ended up on promising to create a patch
to print the directory info WITHOUT I18N/L10N alteration.
(I don't know how many will use it, but let us see.) 

>and the fix worked. I'll commit it to CVS (for both i2c
> and lm_sensors). One question however. It seemed to me that setting
> LC_ALL=C was sufficent. In which case do you believe LANG also has to be
> set? I'm not a locale expert (never used them for myself), so I may be
> missing something obvious. Also should we use =C or =POSIX? Is there a
> difference?

I am not locale expert myself, but
setting both LC_ALL=C and LANG=C on this particular CC invocation should
not
hurt.
(It was mentioned in the GCC mailing list that setting
LC_MESSAGES=C alone  should suffice, but I simply decided to
go to the extreme of setting both LANG=C and LC_ALL=C.

As for C and POSIX, I am not sure if there is an official POSIX locale,
but
"C" locale seems to be the default choice.

I18N/L10N means that the program is supposed to be friendly in terms
of modifiability 
to potential users across the world (I18N), and
then the programmers of each region/language are supposed
to localize the software to fit the need of local users (L10N).

So actually, I am only familiar with the locale setting of
C or NONE (LANG="", LC_ALL="") , and Japanese setting.

BTW, usually, if LC_MESSAGES is not set, then LC_ALL setting is used for
it.

> > 3. I am going to write to GCC maintainers that
> >    at least THIS PARTICULAR OUTPUT from GCC should be saved from the
> >    mangling done by I18N/L10N  translation scheme
> >    since some program depends on the particular format of output (!).
> >   (Actually I don't like the translated output of other parts of GCC
> >    since it may break other programs/scripts...)
> >
> >    Now, as to why Linux kernel doesn't seem to suffer from this
> >    LANG/LC_ALL problem,  I am not sure...
> >    Maybe they don't grep the output from GCC? (Or probably resets
> >    LC_ALL somewhere in the chain of commands before the particular
> >    $(CC) -print-search-dirs is invoked.
> >
> >    At least, it is known that the timestamp string buried in
> >    Linux's "uname -a" output follows the LC_ALL/LANG setting at the
> >    time of kernel compilation. So under my linux setting,
> >    "uname -a" contains Japanese date/time string and
> >    this causes a problem when I try to report some kernel/application
> >    bugs to maintainers : not all editors are equipped to handle
> >    Japanese characters well. So I have to remove the Japanese strings
> >    from uname output.
> 
> I agree. I don't like translations anyway. Never used french
> translations when I could avoid them, since I hardly can understand what
> the translations mean. I believe english is the natural language of
> computer science, and it will stay that way for a long time (my
> opinion).

Well, said. But given the
eager people who translate syntax error messages of GCC, for example,
I am not sure if your and my opinion is in the minority.

In any case, I think the output of --print-search-dirs is meant
for OTHER PROGRAMS to handle, and not meant for humans to
read, it seems to be silly to try to change the tag
field depending on locale setting. But some would disagree...

> > Anyway, I hope the remedy suggested by [2] above
> > is included in Makefile somehow.
> 
> Work in progress (waiting for your answer actually).

As I mentioned above, we can safely put both LC_ALL=C and
LANG=C although the latter maybe redudant *IF* you have not
set LANG yourself.
  
> There is a fourth solution we could think of. If the "install" list is
> always the first one returned by gcc -print-search-dirs (and I guess it
> is) then we don't need to match the label. The following does the job:
>   gcc -print-search-dirs | head -1 | sed -ne 's/[^:]*: \(.*\)/-I
> \1include/gp'
> Now, is it more or less robust than solution #2? That I can't say. Both
> solutions work on systems I tested them on, but that doesn't mean
> anything for the million systems out there.

Problem with the above script is that *WE HAVE NO GURANTEE* that,
no one in his/her right, in any locale of the
world, would put a ":" in the locale-dependent tag.
Sure such translation is bogus/buggy, but there is nothing to
stop such suicidal translation. This is I don't like about the
the current state of the translation done by  I18N/L10N.
E.g. Someone not realizing the nature of the output *MIGHT* put
GCC:[[Install] instead of simple `install'. Oh well.

I shudder to recall  that Sun Microsystems solaris 2.4 (or possibly
earlier)
release contained I18N/L10N *TRANSLATION* of certain Bourne Shell output
and this broke myriads of scripts, and I believe it was fixed in the
next
minor upgrade. Such is the peril of I18N/L10N translation.
Human readable text is OK to alter, but under UNIX, there are many
output forms from various programs, 
the format of which are now hard-coded into OTHER programs for
further processing and so we are in a really difficult position.
We can't simply change the output of one program without affecting
others.

> Thanks a lot for your help!

You are very welcome and
thank you for the great package.

Happy Hacking!


-- 
int main(void){int j 03;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */

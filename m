From: morris@wolfman.com (Jim Morris)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: solution to tickets 1263 & 1223
Message-Id: <20030610203816.140C.MORRIS@wolfman.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030610154737.1df7cc8c.khali@linux-fr.org>
In-Reply-To: <20030610154737.1df7cc8c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

khali> 1* Does actually setting LANG=en_US before running the script solve the
khali> problem? I seriously doubt it. I have LANG=C here and the warnings show
khali> (with Perl 5.8.0 only).

Yes it did when I run the unmodified detect script with LANG=en_US the
script detects my chip as it should.

khali> 2* Does the sensors-detect script behave differently with and without
khali> your patch (masking)? Please check this with both a UTF locale and a
khali> non-UTF locale. Apart from issuing a warning, Perl 5.8.0 is supposed to
khali> convert the value to a byte by itself, so I don't expect any fix we can
khali> think of to solve anything beyond removing the warnings. But you seem to
khali> pretend the patch did actually have an effect. I really wonder...

It works with the 0x7f patch in the UTF case, I haven't checked it with
the non-UTF case but I presume it does work. However 0x7f is obviously
not the right thing to do, it was just a workaround for me.

When it fails it issues a warning and DOES NOT detect my chip. This
caused me a lot of headaches, because I could not figure out what sensor
chip my board actually used.  I posted a help to the via asus BBS, and
someone told me, so then I wondered why the detect script failed, and
that is how I came upon the workaround.

khali> 3* Does the official Red Hat package of lm_sensors (2.6.5) work for you?
khali> (I don't mean "does it support your hardware" but "does sensors-detect
khali> issue warnings or miss to detect hardware it is supposed to know and
khali> that is present".)

I haven't tried that, I went straight to the latest version of lmsensors.

khali> 4* What mask should we use? Red Hat people use 0xff, which seems natural
khali> if you understood what I explained so far. On the other hand, you
khali> pretend it should be 0x7f. Can you explain why? This last question is
khali> tightly linked to question #2, as you may realize.

FYI I tried 0xFF instead of 0x7F and it did not fix the warnings or the
non-detect problem. However 0x7F is NOT the right value unless you know
everything you are trying to writ to the ISA bus is >= 0x7F, it just
happened to work in my case and for my sensor chip.



On Tue, 10 Jun 2003 15:47:37 +0200
Jean Delvare <khali@linux-fr.org> wrote:

khali> 
khali> > Redhat 9 set the LANG to US_en- UTF8
khali> > 
khali> > Th eoperative word here is UTF8, which means that characters are not
khali> > always one byte. Also I think there is a bug in th eversion of perl
khali> > they ship, so the pack "C", $_[1] is taking an 16 bit character (which
khali> > should be one byte) and compalins of an overflow error.
khali> > 
khali> > Many programs are suffering from this bug it seems.
khali> > 
khali> > I'm not sure of the solution to your script, except the work around is
khali> > probably not the patch I sent you, but instead to do an export
khali> > LANG=US_en before running your script.
khali> > 
khali> > Probably everything that calls outb should check it is sending a byte
khali> > not a char. Or put a warning about redhat9 in the Readme or FAQ.
khali> > 
khali> > I would actually recommend you take out the patch I sent.
khali> 
khali> Ok folks, I've investigated the whole morning and I think I have the
khali> explanation, if not a solution.
khali> 
khali> Our Perl code in sensors-detect is faulty. In many places, we actually
khali> call outb() with non-byte values, and this is in no way related to UTF
khali> (a proof being that I can reproduce the error on my non-UTF system).
khali> Let's take a look at our LM78 detection code, for example.
khali> 
khali> <snip>
khali>   $val = inb($addr + 5) & 0x7f;
khali>   outb($addr+5,~ $val);
khali> </snip>
khali> 
khali> The problem here is the bitwise not (~). In our minds, we are working on
khali> bytes, so the bitwise not should keep the value on a byte (8 bits). But
khali> it is actually an integer for Perl and as such the bitwise not occurs on
khali> more than 8 bits (usually 32). So we actually send outb() a value that
khali> looks like 4294967222. Wow, that's much.
khali> 
khali> I think that previous versions of Perl (5.6.1 and previous ones, maybe
khali> 5.7.x but I can't tell for sure) were silently ignoring the problem.
khali> They accepted to pack() large values as an unsigned byte ("C"). I think
khali> that the behaviour was intentionally changed in Perl 5.8.0 so that
khali> people stop using "C" instead of "U" in pack(). People sending large
khali> values to be packed as a byte could in fact be sending Unicode chars
khali> without realizing it wouldn't work as intended. So, Perl 5.8.0's pack()
khali> is now complaining about this. Our code was bad and working, now it is
khali> still bad but it's visible.
khali> 
khali> Masking with 0x7f (or 0xff, see below) in outb() is a solution. It is
khali> what's done in lm_sensors' version Red Hat packages and distributes, and
khali> this is also what Jim Morris had been suggesting. Yes, they have a patch
khali> that's almost the same as the one Jim sent. I really think they *should*
khali> have told us about it. Strangely enough, they call it an UTF fix, as Jim
khali> also did, though I still believe the issue is not directly UTF-related.
khali> Anyway, doing so is by far the more simple solution, it requires a
khali> single line to be changed.
khali> 
khali> But I don't think it's clean. What we actually should do is make sure we
khali> *never* call outb() with more-that-byte values. Of course, this requires
khali> tracking each and every time we have been using bitwise not in our code.
khali> This is a much more difficult task, but that's not unfeasable.
khali> 
khali> Jim, here are four questions that are still left unanswered. I'd like to
khali> ear you on these:
khali> 
khali> 1* Does actually setting LANG=en_US before running the script solve the
khali> problem? I seriously doubt it. I have LANG=C here and the warnings show
khali> (with Perl 5.8.0 only).
khali> 
khali> 2* Does the sensors-detect script behave differently with and without
khali> your patch (masking)? Please check this with both a UTF locale and a
khali> non-UTF locale. Apart from issuing a warning, Perl 5.8.0 is supposed to
khali> convert the value to a byte by itself, so I don't expect any fix we can
khali> think of to solve anything beyond removing the warnings. But you seem to
khali> pretend the patch did actually have an effect. I really wonder...
khali> 
khali> 3* Does the official Red Hat package of lm_sensors (2.6.5) work for you?
khali> (I don't mean "does it support your hardware" but "does sensors-detect
khali> issue warnings or miss to detect hardware it is supposed to know and
khali> that is present".)
khali> 
khali> 4* What mask should we use? Red Hat people use 0xff, which seems natural
khali> if you understood what I explained so far. On the other hand, you
khali> pretend it should be 0x7f. Can you explain why? This last question is
khali> tightly linked to question #2, as you may realize.
khali> 
khali> OK, anyone wanting to share an opinion on this please speak up. I
khali> volunteer to fix the problem, but I'd like to make sure everyone agrees
khali> on what should be done before changing anything.
khali> 
khali> -- 
khali> Jean Delvare
khali> http://www.ensicaen.ismra.fr/~delvare/
khali> 

--
Jim Morris morris@wolfman.com

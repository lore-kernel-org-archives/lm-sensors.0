From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: solution to tickets 1263 & 1223
Message-Id: <20030610154737.1df7cc8c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Redhat 9 set the LANG to US_en- UTF8
> 
> Th eoperative word here is UTF8, which means that characters are not
> always one byte. Also I think there is a bug in th eversion of perl
> they ship, so the pack "C", $_[1] is taking an 16 bit character (which
> should be one byte) and compalins of an overflow error.
> 
> Many programs are suffering from this bug it seems.
> 
> I'm not sure of the solution to your script, except the work around is
> probably not the patch I sent you, but instead to do an export
> LANG=US_en before running your script.
> 
> Probably everything that calls outb should check it is sending a byte
> not a char. Or put a warning about redhat9 in the Readme or FAQ.
> 
> I would actually recommend you take out the patch I sent.

Ok folks, I've investigated the whole morning and I think I have the
explanation, if not a solution.

Our Perl code in sensors-detect is faulty. In many places, we actually
call outb() with non-byte values, and this is in no way related to UTF
(a proof being that I can reproduce the error on my non-UTF system).
Let's take a look at our LM78 detection code, for example.

<snip>
  $val = inb($addr + 5) & 0x7f;
  outb($addr+5,~ $val);
</snip>

The problem here is the bitwise not (~). In our minds, we are working on
bytes, so the bitwise not should keep the value on a byte (8 bits). But
it is actually an integer for Perl and as such the bitwise not occurs on
more than 8 bits (usually 32). So we actually send outb() a value that
looks like 4294967222. Wow, that's much.

I think that previous versions of Perl (5.6.1 and previous ones, maybe
5.7.x but I can't tell for sure) were silently ignoring the problem.
They accepted to pack() large values as an unsigned byte ("C"). I think
that the behaviour was intentionally changed in Perl 5.8.0 so that
people stop using "C" instead of "U" in pack(). People sending large
values to be packed as a byte could in fact be sending Unicode chars
without realizing it wouldn't work as intended. So, Perl 5.8.0's pack()
is now complaining about this. Our code was bad and working, now it is
still bad but it's visible.

Masking with 0x7f (or 0xff, see below) in outb() is a solution. It is
what's done in lm_sensors' version Red Hat packages and distributes, and
this is also what Jim Morris had been suggesting. Yes, they have a patch
that's almost the same as the one Jim sent. I really think they *should*
have told us about it. Strangely enough, they call it an UTF fix, as Jim
also did, though I still believe the issue is not directly UTF-related.
Anyway, doing so is by far the more simple solution, it requires a
single line to be changed.

But I don't think it's clean. What we actually should do is make sure we
*never* call outb() with more-that-byte values. Of course, this requires
tracking each and every time we have been using bitwise not in our code.
This is a much more difficult task, but that's not unfeasable.

Jim, here are four questions that are still left unanswered. I'd like to
ear you on these:

1* Does actually setting LANG=en_US before running the script solve the
problem? I seriously doubt it. I have LANG=C here and the warnings show
(with Perl 5.8.0 only).

2* Does the sensors-detect script behave differently with and without
your patch (masking)? Please check this with both a UTF locale and a
non-UTF locale. Apart from issuing a warning, Perl 5.8.0 is supposed to
convert the value to a byte by itself, so I don't expect any fix we can
think of to solve anything beyond removing the warnings. But you seem to
pretend the patch did actually have an effect. I really wonder...

3* Does the official Red Hat package of lm_sensors (2.6.5) work for you?
(I don't mean "does it support your hardware" but "does sensors-detect
issue warnings or miss to detect hardware it is supposed to know and
that is present".)

4* What mask should we use? Red Hat people use 0xff, which seems natural
if you understood what I explained so far. On the other hand, you
pretend it should be 0x7f. Can you explain why? This last question is
tightly linked to question #2, as you may realize.

OK, anyone wanting to share an opinion on this please speak up. I
volunteer to fix the problem, but I'd like to make sure everyone agrees
on what should be done before changing anything.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

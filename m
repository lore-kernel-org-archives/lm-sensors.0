From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: RFC scaling/constraining user-space input
Message-Id: <3d4n31l7ac0v73pb79qcr2bti1b4oopmbo@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <lllk31p1cgiaao96a5vn16edoda4tkmt19@4ax.com>
In-Reply-To: <lllk31p1cgiaao96a5vn16edoda4tkmt19@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Mar 2005 16:32:05 +0100 (CET), "Jean Delvare" <khali@linux-fr.org> wrote:

(re-edit reply sent to Jean D. and not the list)
. . .
usual temp, voltage scaling okay
. . .
re: fan divisor
>> Overkill?
>
>That's the correct way to do it for all discrete values. Rounding +
>range constraints is fine for continuous (voltages) or pseudo-continuous
>(fans) values. Returning an error for these would make no sense. But for
>discrete values, it is better to let the user-space know that the value
>it tried to write was not valid.
Okay, agree :)
>
>The reason why many drivers don't do it is that it was not previously
>possible to do that (with 2.4 kernels and procfs interface). Now with
>2.6 kernels and sysfs it is possible, so new drivers do it that way, but
>some older drivers still need to be updated.

Perhaps I should do that?  Gain knowledge of system while making 
smaller changes that shouldn't break anything, nor require testing 
with particular chip to be valid?  

>> Apart from the use of a confusing term 'ripple' for
. . .
>Ripple is not fan clock dividers, it means more like "pulse per
>revolution". I think that another driver has "ppr" for this. That

Abbreviation for: "the period of the fan revolution is
measured by gating an on-chip 22.5 kHz oscillator into the
input of an 8-bit counter for two periods of the fan tacho" --adm9240

Ripple?  Seemed odd to me, but it is so frequently used in source 
it becomes 'official', a known label :)  

>There is no "limits" for fan clock dividers
. . .
Agree, see your point now.  

>> Coupled with setting fan divisor, why take special action to
>> adjust fan speed limit when divisor change?  Why not simply
>> tell user-space to set divisor prior to changing fan speed
>> limit?
>
>Because people do not read the docs. So they'll do it the wrong way
>around, then complain that our drivers are broken. We have to protect
>ourselves against users that don't read the docs.
. . .
Okay, agree.  Makes sense too.

>> Then we get to the odd VID reporting
..
>Why do you say it's odd? I like the ways things are done now. Raw VID
>bits are read from the chips, VRM version is guessed from the CPU and
>possibly overwritten by the user, nominal VCore voltage is exposed
>through sysfs. How could it be better than that?

1. because I looped around the code several times before thinking 
to ask if there was a documentation error re: one read-only (VRM)
appearing to influence another read-only (VID).

2. because I like simple, obvious solutions, such as VID sense being 
an index into a lookup table, and VRM selecting which table to lookup, 
instead I find 'clever' coding obscuring a simple lookup.  Especially 
the 8.2 vrm 50mV or 100mV per lsb interpretation.  

3. because I had trouble discovering why this function reported 
so differently by the drivers.  a distraction, confusion :)

>I hope I answered your questions.
That you have.  Thanks

Cheers,
Grant.

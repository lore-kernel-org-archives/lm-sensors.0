From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: RFC lmsensors sysfs interface documentation
Message-Id: <6pki4116mqff5m7svkdmk8vdgels3f05uo@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9kug41tbmj5kp8bmadk4t7bupgvnl15q0m@4ax.com>
In-Reply-To: <9kug41tbmj5kp8bmadk4t7bupgvnl15q0m@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Tue, 29 Mar 2005 10:26:08 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:
>> I've started a little documentation project here:
>>
>>   http://scatter.mine.nu/lmsensors/sysfs-names/

>> I don't know if anyone has a cross-reference which driver uses
>> what name but I'm thinking of producing one, perhaps a table,
>> X = drivers, Y = sysfs names, * marks the spot?  This been done?
>
>> Worth doing?
>
>Certainly, but only if you find a way to automate this. If not, the
>drivers are changed and added as such a fast pace these days that you
>would certainly regret the time you spent doing it manually quite
>quickly.

It would be automated, just kick data extraction after unpack latest 
-whatever.  Complete with live x-y cursor highlighting with CSS :o) 
At least I've weaned myself from client based javascript web pages.

Only a couple hundred sysfs names by few dozen drivers by one char, 
not a lot of data. Less than 9kB char data makes it seem doable. 
Web presentation via mouse-over labels would be user friendly, 
easy to do, easy to automate page generation.

Started off out of curiosity, thought I'd document idea to gauge 
interest. 

>First, you would probably make things easier to read and analyze by
>collapsing names changing only by their channel number. Where the
>documentation says temp[1-4]_input, it really (almost) means
>temp[anynumber]_input. The "1" is valuable because some counts start
>at 0 (most notably voltage channels and CPUs) and it's better to know
>which
In that case documentation collapses to zero or one based 
reference, unbounded limit.

>rt[1-3] is now gone thanks to your patch to w83781d.c.
Not gone upstream as far as I know, thought you'd ack it or 
something.  

>fan[1-3]_ripple is NOT fan[1-3]_div. As explained in a previous post,
>ripples are the number of pulses per revolution. They are a kind of fan
>divider, but fundamentally different from fan[1-*]_div which are fan
>*clock* dividers. A more "standard" name for fan[1-3]_ripple would
>probably be "fan[1-*]_ppr". I think I remember that some 2.4 driver
>exported these.

So is this the difference?
Increase ripple -> increase reading due to longer clock count period.
Increase divider -> decrease reading due to lower clock frequency.

I have an interest in the fan divider issue anyway, as you discussed 
in other thread.  Stalled on fan_div conversions as code is murky in 
some drivers.

>wdog_* should definitely be changed to watchdog_*, and these should be
>documented. That being said, maybe it'd be even better to look at real
>watchdog drivers and use the standard interface rather than our own.

Whatever, I don't want to look too far yet.  

>revision and die_code are the same thing. Both should be removed IMHO,
>revision should not be needed by user-space, and it's cheaper to just
>printk it on driver load (if this is of any use at all).

>
>Almost each item on your nondoc list would require specific treatment.
>That's quite a lot of work...

Broken namespace is always a lot of work to fix.  That's not 
going to happen anytime soon.  Collecting opinion -> requirements 
analysis is a background task -- if people contribute, something 
may happen.  If not, the idea will die of malnourishment. 

>I really appreciate that you tackle issues that affect all the drivers at
>once, but at some point you might find more fun and interest in going on
>with your adm9240 driver port.

But that would mean getting lmsensors going?  :o)  and 2.6.tomorrow

>                               Once you have a working driver you can
>play with, you will most probably have an even better understanding of
>the subsystem as a whole, which will help you focus on points you think
>need fixing.

Soon, suffering a severe case of C overload right now.  So I 
do other stuff.  Built a new computer to play with too.

Cheers,
Grant.

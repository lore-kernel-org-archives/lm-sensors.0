From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 04 Jul 2007 04:52:42 +0000
Subject: Re: [lm-sensors] concentrate efforts on libsensor-3.x or also add
Message-Id: <468B279A.8040005@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <468915CD.5020300@hhs.nl>
In-Reply-To: <468915CD.5020300@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 02 Jul 2007 17:12:13 +0200, Hans de Goede wrote:
>> I'm wondering when are libsensors-3.x alpha / beta releases planned? I'm 
>> tending towards not adding support for the abituguru3 and the f71882fg to 
>> lm_sensors-2.10.x because 3.x will hopefully soon be available and I can spend 
>> my time only once. OTOH, the 2.10.x line may continue to exist and be used for 
>> a while so it might be a good idea to add support there too, what do you guys 
>> think?
> 
> This is a very valid question. The problem is that there is no release
> date planned for 3.x. Originally, Mark wanted to release it on July
> 2007, i.e. now... and as you can see it didn't happen. I changed the
> milestone to September 2007 in trac, but the truth is, I simply don't
> know if I'll be able to put enough time into libsensors by then to make
> it really happen. There's still a lot to do, despite the fact that
> things look good from the outside, and seem to work. I want us to
> review the library interface entirely, killing what's not needed, and
> reworking what needs to be. As we're going for a new major .so number,
> we really need to start from a clean design, not quickly adjusted code
> based on the old library.
> 

<sigh>

This may sound a bit more harsh then its intended, but thats just my writing 
style + me writing in a foreign language, so please read this as its intented, 
much more as feedback then as criticism.

First of all who is running the show here you or Mark? Having 2 captains on a 
ship doesn't work all that well IMHO.

Second, this is not what was agreed too when the generic chip support was first 
merged, I argued that it should go to the 2.x branch, which it could have (and 
still can) since if its added to the 2.x branch as was suggested, so that it 
only gets used for new / unknown chips, then it cannot cause regressions for 
existing users, as those will never enter a codepath which uses it.

Also the generic chip support was designed exactly to stop the mind numbing 
pain of having to write similar but subtile different printing routines for 
each chip, pain which now is being induced upon all of us be delaying a release 
of libsensors with generic chipsupport added.

With that said, I must say I agree with the cleaning happening for the 3.x 
branch. I also technically agree with taking a good look at the API+ABI before
releasing a new soname version, I would like to notice though this wasn't on 
the original roadmap and working on features only to have them delayed by new 
stuff being put on the roadmap makes me grumpy. Esp. because this (thinking of 
new things todo for release) is a process which can be repeated endlessly, thus 
delaying the release of said new features endlessly.

So can we please create a new (short) roadmap + timeline for 3.x and stick to it?

> 2.10.4 will be released very soon. And after that I think we'll have at
> least 2.10.5 before the 2.x branch can go to sleep. And distributions
> need time before they switch to a new branch of a product. So I don't
> think you can spare the time needed to add support for your chips to
> the 2.10.x branch, unless you don't want distribution users to use your
> drivers before another 6 months, at best. Only after 3.x is released,
> we can stop adding support for new chips in 2.x, methinks.
> 

Unfortunately I agree. I say Unfortunately because that means I have to write 
libsensors + sensors 2.x support for the abituguru3 and the fintek f71882fg.

I see 2 options here:
1) I'll scramble to write abituguru3 and fintek f71882fg support for 2.10.x
    before the july 8th deadline. If we go this way, is it ok to directly
    commit this to svn? (I might need slightly more time in which case I would
    like to ask for a short delay, but I'll try to make the july 8th deadline)

2) Do a 2.11.0 (with RC / beta first) soon after 2.10.4 with the current
    generic chip support code from 3.x merged in the way it was originally
    intented (iow only comes into play for unknown chips)

I prefer 2, because that means that we will have a 2.x for more conservative 
users, which will automatically work with new chips as they are added to the 
kernel, and this might save us from having todo a 2.10.6 (2.11.0 is about as 
much work as 2.10.5 I guess).

Please let me know which one it will be, then I'll start working on the choosen 
path.

> Not to say that you shouldn't ask your testers to try branch 3.x now as
> well, just to make sure it works as intended - but that's not what
> regular users will have in their distributions before a while.
> 

I'm asking and they are testing it with success.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

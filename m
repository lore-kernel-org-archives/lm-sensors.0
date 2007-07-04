From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Wed, 04 Jul 2007 18:22:23 +0000
Subject: Re: [lm-sensors] concentrate efforts on libsensor-3.x or also add
Message-Id: <4dfa50520707041122x6fd8623cu25376bbf65492e94@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <468915CD.5020300@hhs.nl>
In-Reply-To: <468915CD.5020300@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'll chime in with my opinion, but take it with a pinch of salt... or
a bucket full.

> <sigh>
>
> This may sound a bit more harsh then its intended, but thats just my writing
> style + me writing in a foreign language, so please read this as its intented,
> much more as feedback then as criticism.
>
> First of all who is running the show here you or Mark? Having 2 captains on a
> ship doesn't work all that well IMHO.

I think the change over to having Mark in charge is going very well.
Jean is still a big contributor. As in, he contributes a hundred times
more to the project than I do. For example, he had a week to devote to
moving sensors 3.x forward. I haven't had the time to do that!

> Second, this is not what was agreed too when the generic chip support was first
> merged, I argued that it should go to the 2.x branch, which it could have (and
> still can) since if its added to the 2.x branch as was suggested, so that it
> only gets used for new / unknown chips, then it cannot cause regressions for
> existing users, as those will never enter a codepath which uses it.
>
> Also the generic chip support was designed exactly to stop the mind numbing
> pain of having to write similar but subtile different printing routines for
> each chip, pain which now is being induced upon all of us be delaying a release
> of libsensors with generic chipsupport added.
>
> With that said, I must say I agree with the cleaning happening for the 3.x
> branch. I also technically agree with taking a good look at the API+ABI before
> releasing a new soname version, I would like to notice though this wasn't on
> the original roadmap and working on features only to have them delayed by new
> stuff being put on the roadmap makes me grumpy. Esp. because this (thinking of
> new things todo for release) is a process which can be repeated endlessly, thus
> delaying the release of said new features endlessly.
>
> So can we please create a new (short) roadmap + timeline for 3.x and stick to it?
>
> > 2.10.4 will be released very soon. And after that I think we'll have at
> > least 2.10.5 before the 2.x branch can go to sleep. And distributions
> > need time before they switch to a new branch of a product. So I don't
> > think you can spare the time needed to add support for your chips to
> > the 2.10.x branch, unless you don't want distribution users to use your
> > drivers before another 6 months, at best. Only after 3.x is released,
> > we can stop adding support for new chips in 2.x, methinks.
> >
>
> Unfortunately I agree. I say Unfortunately because that means I have to write
> libsensors + sensors 2.x support for the abituguru3 and the fintek f71882fg.
>
> I see 2 options here:
> 1) I'll scramble to write abituguru3 and fintek f71882fg support for 2.10.x
>     before the july 8th deadline. If we go this way, is it ok to directly
>     commit this to svn? (I might need slightly more time in which case I would
>     like to ask for a short delay, but I'll try to make the july 8th deadline)
>
> 2) Do a 2.11.0 (with RC / beta first) soon after 2.10.4 with the current
>     generic chip support code from 3.x merged in the way it was originally
>     intented (iow only comes into play for unknown chips)
>
> I prefer 2, because that means that we will have a 2.x for more conservative
> users, which will automatically work with new chips as they are added to the
> kernel, and this might save us from having todo a 2.10.6 (2.11.0 is about as
> much work as 2.10.5 I guess).
>
> Please let me know which one it will be, then I'll start working on the choosen
> path.

I remember the original discussion about generic chip support. I think
adding it to sensors 2.x would smooth the transition to 3.x, but IIRC
Jean was right, we would duplicate the code in 2.x and 3.x. I think
it's completely within reason to put generic chip support in 2.x and
keep it carefully under control so it doesn't cause maintenance
headaches.

I'm not in any position to really contribute to the abit uguru3 or
fintek f71882fg drivers, so all of this is probably irrelevant.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

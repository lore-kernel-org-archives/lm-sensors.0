From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jul 2007 12:26:49 +0000
Subject: Re: [lm-sensors] concentrate efforts on libsensor-3.x or also add
Message-Id: <20070705142649.7c908d91@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <468915CD.5020300@hhs.nl>
In-Reply-To: <468915CD.5020300@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 04 Jul 2007 06:52:42 +0200, Hans de Goede wrote:
> First of all who is running the show here you or Mark? Having 2 captains on a 
> ship doesn't work all that well IMHO.

Who said there was a captain? ;)

Mark initiated the lm-sensors-3.0.0 branch. You populated it with your
student's work and fixed it a bit. I am now reviewing it and cleaning
it up. Everyone of us has spent time and energy when he could. This is
how small open-source projects work, you shouldn't be surprised.

Mark has limited time to work on the lm-sensors project. Well, we all
do, but I think I can assert that I have more time for the project than
Mark does, at the time being. And Mark agreed to take over me as the new
hwmon subsystem maintainer. All the time he puts there, he can't put in
libsensors.

I'm not sure what worries you. I don't think that Mark and myself are
in disagreement on the course of action we should take.

> Second, this is not what was agreed too when the generic chip support was first 
> merged, I argued that it should go to the 2.x branch, which it could have (and 
> still can) since if its added to the 2.x branch as was suggested, so that it 
> only gets used for new / unknown chips, then it cannot cause regressions for 
> existing users, as those will never enter a codepath which uses it.

You forget to mention that the generic chip support relies on the new
sensors_feature_get_type interface. This means that not only
libsensors needs to be modified, but also sensors and all the other
tools which rely on libsensors. I am not willing to ask the developers
of these tools to add support for a preliminary version of the generic
chip support now, and then again for libsensors.so.4 (as we already
know it will not be compatible.) And having support in only sensors and
not the other tools isn't really an option either, users would complain
loudly.

When I proposed to add generic chip support to the 2.x branch, I had
not realized the compatibility issues that were involved. I agree that
it added unneeded constraints to your student's work and I'm sorry
about that. But now that we decided to add the code to the 3.x branch
and the biggest part of the work is done there, there's no way we step
back and start it all over again. A decision was made and we will stick
to it.

> Also the generic chip support was designed exactly to stop the mind numbing 
> pain of having to write similar but subtile different printing routines for 
> each chip, pain which now is being induced upon all of us be delaying a release 
> of libsensors with generic chipsupport added.

The pain is mainly on the user's side, not ours. Adding support for a
new chip to libsensors.so.3  and sensors is not that difficult. It's a
matter of 15 minutes for us, I'd say. Copy and paste isn't funny, but
it's not difficult.

> With that said, I must say I agree with the cleaning happening for the 3.x 
> branch. I also technically agree with taking a good look at the API+ABI before
> releasing a new soname version, I would like to notice though this wasn't on 
> the original roadmap and working on features only to have them delayed by new 
> stuff being put on the roadmap makes me grumpy. Esp. because this (thinking of 
> new things todo for release) is a process which can be repeated endlessly, thus 
> delaying the release of said new features endlessly.

I don't plan to wait for libsensors.so.4 to be perfect before we
release it. All I want is that the interface is clean enough so that we
can be reasonably certain we won't have to change it in the next 8
years. The rest can be improved endlessly, but later. I was hoping to
have the time to look at the interface last week, but I did not. This
is still at the top of my todo list, but I have a lot to do for my day
job again.

> So can we please create a new (short) roadmap + timeline for 3.x and stick to it?

See http://www.lm-sensors.org/roadmap

This is the roadmap, in terms of remaining tasks. It can be argued
whether these are all blockers for 3.0.0. Some of the items could
probably be postponed to 3.0.1. For example, #2174 (Add 'include'
functionality for sensors.conf) is in no way required for 3.0.0.

If there are other things you think need to be done for 3.0.0, please
add them. And feel free to create a new 3.0.1 milestone and propose
moving some of the items from 3.0.0 to 3.0.1 if they don't look like
blockers to you.

> > 2.10.4 will be released very soon. And after that I think we'll have at
> > least 2.10.5 before the 2.x branch can go to sleep. And distributions
> > need time before they switch to a new branch of a product. So I don't
> > think you can spare the time needed to add support for your chips to
> > the 2.10.x branch, unless you don't want distribution users to use your
> > drivers before another 6 months, at best. Only after 3.x is released,
> > we can stop adding support for new chips in 2.x, methinks.
> 
> Unfortunately I agree. I say Unfortunately because that means I have to write 
> libsensors + sensors 2.x support for the abituguru3 and the fintek f71882fg.

As I wrote above, it's not that difficult.

> I see 2 options here:
> 1) I'll scramble to write abituguru3 and fintek f71882fg support for 2.10.x
>     before the july 8th deadline. If we go this way, is it ok to directly
>     commit this to svn? (I might need slightly more time in which case I would
>     like to ask for a short delay, but I'll try to make the july 8th deadline)

If you need more time, just tell me. The deadline is not set in stone,
we can change it.

> 2) Do a 2.11.0 (with RC / beta first) soon after 2.10.4 with the current
>     generic chip support code from 3.x merged in the way it was originally
>     intented (iow only comes into play for unknown chips)

Please, no. This would be a waste of your time and mine. The current
2.x method is bad (otherwise we wouldn't be working on 3.x) but it is
mastered by us and well understood by distributions, application
authors and users. We have been living with it for 8 years, a couple
additional months really aren't a problem. If you have time to put in
the project, please contribute to 3.x (or help with support so that I
can contribute to 3.x) rather that starting your own development
branch. 3.x isn't not that far from being ready, if we all work on it.

> I prefer 2, because that means that we will have a 2.x for more conservative 
> users, which will automatically work with new chips as they are added to the 
> kernel, and this might save us from having todo a 2.10.6 (2.11.0 is about as 
> much work as 2.10.5 I guess).
>
> Please let me know which one it will be, then I'll start working on the choosen 
> path.

Option 1, definitely.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

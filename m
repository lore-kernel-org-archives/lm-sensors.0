From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 13 Feb 2014 12:57:31 +0000
Subject: Re: [lm-sensors] [RFC PATCH] hwmon: (max6650) Convert to be a platform driver
Message-Id: <20140213135731.139b23aa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392281438-31836-1-git-send-email-lpapp@kde.org>
	<20140213095817.GD32508@lee--X1>
	<20140213111530.2a2b4982@endymion.delvare>
	<CAOMwXhML8LvDCzmk1ZVT+7cARj9C3VtxERWBgOPM9vTc6qQXZQ@mail.gmail.com>
	<CAOMwXhOv-as1W69wcSno49jEXsXWZZ7odnu8og-vgnDwRTJ4sA@mail.gmail.com>
	<20140213113313.GL32508@lee--X1>
	<CAOMwXhMNHqXnzR0YHF9rx710JbaL3YFn=3cLf_WdNkCx7hbZug@mail.gmail.com>
In-Reply-To: <CAOMwXhMNHqXnzR0YHF9rx710JbaL3YFn=3cLf_WdNkCx7hbZug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laszlo Papp <lpapp@kde.org>
Cc: Lee Jones <lee.jones@linaro.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Laszlo,	

On Thu, 13 Feb 2014 12:27:28 +0000, Laszlo Papp wrote:
> On Thu, Feb 13, 2014 at 11:33 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > Right, I've had enough. I'm removing your patch from the MFD tree.
> >
> > I've asked too many people to give you a second chance and asked you
> > privately to behave yourself and treat others with respect. So far I
> > haven't seen an ounce of self control or depomacy from you.
> >
> > This is how it's going to work from now on:
> >
> >  - You submit a patch
> >  - It gets reviewed                            <----\
> >  - You fix up the review comments as requested -----/
> >  - Non-compliance or arguments with the _experts_ results in:
> >     `$INTEREST > /dev/null || \
> >       grep "From: Laszio Papp" ~/.mail | xargs rm -rf`
> 
> http://comments.gmane.org/gmane.linux.kernel/1645251
> 
> Step 2 did not happen. I did not get any review for my change. I
> literally submitted that within a couple of hours after the request.

Yes, twice even, and broken each time. And without a changelog on v2
(despite Documentation/SubmittingPatches explaining this is a good
practice - see section 15.)

> Could you please tell me what was wrong with that change, and why I
> did not get any respect not to "xargs rm -rf" my work in that area? I
> believe I was ignored instead of improving the change, and someone
> else tried to address the same thing. There was no argument in that
> thread. It was a technical change. I personally do not feel happy
> about it.

The change itself was so wrong that I don't even know where to start.

But the main problem really was you. You had pissed me (and I suspect,
everybody else) off so much that day that I really didn't want to deal
with your rants or code any longer. As you can imagine, I have more
than enough on my plate, so I just moved on to another task.

Then by the time I may have been willing to give you another chance and
review your code, Guenter wrote a more complete, better patch set. So I
thought I'd just review that one. And it was good, and it took me less
time to review and test it than to (attempt to) teach you how to behave.

Working with Guenter is a pleasure. Working with you is a pain, really.
And guess what, I get to choose who I'm working with.

If people no longer want to work with you, well, blame it on yourself.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

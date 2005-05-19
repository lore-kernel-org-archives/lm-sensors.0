From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: 2.8.1
Message-Id: <20031115201815.GA23877@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6484BA.24E78516@paradyne.com>
In-Reply-To: <3F6484BA.24E78516@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 14, 2003 at 10:55:16PM +0100, Jean Delvare wrote:
> 
> > > > Is it split up into small, incremental patches, each patch only
> > > > doing one thing?  That is what is going to be required if it will
> > > > be accepted into the kernel tree.
> > > 
> > > Basically, it's all or nothing.
> > 
> > Hm, with that attitude, your patch will go nowhere, sorry.
> 
> Interesting. Sleepless nights building these patches to drivers I mostly
> don't use, writing an installation guide, setting a place up for
> download, answering questions and fixing bugs. Highly questionable
> attitude indeed.

Um, I'm referring to your "Take it or leave it, here's the big patch
that syncs up with our CVS tree" attitude.  I'm not referring to all of
the work you have done for the project at all.  I think you have done a
lot of very good, very needed work for the sensors project, and thank
you for it.

But when you try to ignore the way kernel development works, I don't
have much sympathy.  Please read Documentation/SubmittingPatches for how
to send patches into the kernel.  It states that you have to split them
up.  Also read Documentation/CodingStyle and see that numerous drivers
in the current cvs tree do not follow this basic style.  For that reason
alone, the patch will be rejected.

And the argument that this is a "resync" with an external CVS tree, or
that thousands of users love the result doesn't fly either.  See the
numerous posts by Linus on linux-kernel about how he does not accept big
code dumps.  I'm not going to reiterate the reasons why here again.

Also realize that you are trying to modify a very stable kernel tree,
that is nearing it's end of life cycle.  2.6 will be shipping in distros
in 6 months, and in it, the sensors code.  Because of this it is going
to be a very hard sell to do such a massive code dump, and api change in
2.4.  Now I'm not saying that the api change is not a good thing
technically, just realize that you are very late to this tree, and so
the ability to change things is harder and harder.

This is one of the main reasons I worked so hard to get the sensors code
into 2.5, as that was the proper time to do it.  I also fixed the coding
style issues, and logic issues and submitted patches in small,
incremental chunks to introduce these changes.  In short, I followed the
rules, and the patches were accepted.

Please don't be frustrated.  The rules are spelled out in very nice
detail, don't be surprised at resistance when you try to ignore them.

> Which side are you on, Greg?

I think I'll let my kernel work, done on my own time, speak for itself.

thanks,

greg k-h

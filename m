From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Apr 2011 18:03:50 +0000
Subject: Re: [lm-sensors] [RFC PATCH] hwmon: Add SubmittingHwmonPatches to
Message-Id: <20110405180350.GB19316@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1301760379-13038-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1301760379-13038-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Mon, Apr 04, 2011 at 12:15:29PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sun, 3 Apr 2011 14:21:13 -0700, Guenter Roeck wrote:
> > On Sun, Apr 03, 2011 at 11:37:48AM -0400, Jean Delvare wrote:
> > > Hi Guenter,
> > > 
> > > On Sat, 2 Apr 2011 09:06:19 -0700, Guenter Roeck wrote:
> > > > When writing hardware monitoring drivers, there are some common pitfalls which
> > > > keep coming up in code reviews. This patch provides a document describing all
> > > > those pitfalls and how to avoid them.
> > > 
> > > FWIW, for the i2c subsystem I decided to publish my recommendations on
> > > a wiki, rather than in the kernel tree:
> > >   https://i2c.wiki.kernel.org/index.php/Linux_2.6_I2C_development_FAQ
> > > 
> > > We could have a similar wiki for the hwmon subsystem if you think this
> > > would be useful. It would also be possible to create a page in the
> > > lm-sensors.org wiki, as both projects are tightly related anyway.
> > > 
> > Yes, I think that would be useful. I think we should have the document
> > in the kernel as well, though, since many people won't read the wiki,
> > and because having it in the kernel makes it official (or at least more so).
> 
> Meaning we'd have to maintain the document in two different places?
> Maybe... but think twice before you go that route.
> 
Good point. Your I2C document is a bit higher level anyway. I'll stick
with the kernel version.

> > > > (...)
> > > > +* Avoid function macros. While it may save a line or so in the source, it
> > > > +  obfuscates the code and makes code review more difficult. It may also result
> > > > +  in code which is more complicated than necessary.
> > > 
> > > See my review of your max16065 driver ;)
> > > 
> > Guess you mean to avoid complex maros as well. Ok, no problem.
> 
> Maybe I misunderstood "function macros" in your sentence. Did you mean
> functions with parameters, or macro-generated functions? I thought the
> first, but maybe you meant the second. Well, this point needs
> clarification apparently ;)
> 
I meant macro-generated functions. I rephrased it to "Avoid calculations
in macros and macro-generated functions".

> > (...)
> > Overall this was mostly to initiate a discussion. Maybe it would make sense to add it
> > to the wiki first, and copy it into the kernel after it stabilizes. This way it would
> > not just be my document, but give the community a chance to participate.
> > What do you think ?
> 
> We two are the maintainers of the hwmon subsystem, so this
> documentation must be ours. Don't ask the community at large how they
> want to contribute, you won't like the answer ;) In fact, the reason
> you felt the need to write this document is, in part, because you want
> to set the rules contributors should follow to make you (and me) happy.
> 
Plus to generate a checklist for myself.

> I'm fine with the document (both its existence and its content. In fact
> I find it curious that I wrote a guidance document to i2c subsystem
> contributors and never felt the need to do the same for hwmon subsystem
> contributors. I can't really explain it.
> 
Sweet little mysteries of life ;)

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

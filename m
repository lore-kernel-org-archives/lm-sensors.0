From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Call for 2.8.1
Message-Id: <200308232252.32546.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815233532.3e147cce.khali@linux-fr.org>
In-Reply-To: <20030815233532.3e147cce.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Saturday 23 August 2003 22:40, Jean Delvare wrote:
> > I agree with releasing 2.8.1 soon.
> >
> > But why wait for 2.8.1 to submit a patch?
> > I don't see anything in our changelog that looks critical.
> > And I'd rather submit a patch based on a release
> > that's seen several weeks' testing by users.
> >
> > So why not submit 2.8.0?
>
> Because 2.8.0 has bugs that have been fixed in 2.4.22-rc2, among some
> others. The bugs are fixed in CVS, of course.
>
> The i2c CVS repository has no features added since 2.8.0, but it as a
> few bugfixes, and some new IDs too. This is the reason why I believe
> that submitting CVS (which at this point will have to be 2.8.1 for
> convenience) instead of 2.8.0 is the right thing to do. The "not tested
> by users" doesn't apply here IMHO because only few fixes have been made,
> and they are under control AFAICS.
>
> > p.s. If you want me to look at Makefile problems please point
> > me to the two reports. thanks.
>
> OK, here you are:
> http://archives.andrew.net.au/lm-sensors/msg03570.html
>
> And I can't find the second one... :(
> I hope it'll cross my path again someday.

the second one is the bug in i2c-sis630 that was fixed after 2.8.0 ...

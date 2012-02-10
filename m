From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Feb 2012 14:47:18 +0000
Subject: Re: [lm-sensors] questions about lm-sensors development
Message-Id: <20120210144718.GA603@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F34E2D5.6080900@gmail.com>
In-Reply-To: <4F34E2D5.6080900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David,

On Fri, Feb 10, 2012 at 04:26:45AM -0500, David Kremer wrote:
> Hello,
> 
> cheers everyone. Thank you for your lm-sensor programs.
> 
> I asked recently in a thread if you support a LTS version for the kernel 
> 3.0, and I had a positive answer. Nevertheless, things are not quite 
> clear for me, and it seems your website is lacking of informations on 
> how to contribute.
> 
... and now things get confusing. Earlier we talked about kernel development,
now your headline says "lm-sensors". Are you talking about the lm-sensors package,
or are you talking about the kernel hwmon subsystem ? Both are completely 
different (though one uses the other), and managed differently.

Specifically, it is up to a distribution maintainer to decide if a new version
of lm-sensors should be included, if any bug fixes should be included, etc,
while it is largely up to kernel maintainers to maintain kernel subsystems.

> Guenter uses a git repository, not sure how it interacts with the main 
> kernel tree.
> 
I have several git repositories on github, plus one on kernel.org.

> I would be glad to have a clear explanation of where are the 
> repositories for the
> different parts of lm-sensors and the development routines you all follow.
> 
What "parts" do you refer to ? Again, do you refer to lm-sensors or to the hwmon
subsystem ?

I have two kernel repositories, one on kernel.org, one on github. The latter is
a shadow of the first. The repository on kernel.org is used to send pull requests
upstream, and to serve as feed for the -next tree.

There are three branches:
	hwmon, for bug fixes
	hwmon-next, for patches queued up for the next version
	hwmon-staging, for patches not ready for upstream submission

Also, there may be a signed tag named hwmon-for-linus, which is used to reference
pull requests.

> Especially I dont't understand very well why your patch are numbered 
> 0/4, 1/4, etc.
> 
I would suggest to look into Documentation/SubmittingPatches for an explanation
on how the patch submit process works. Also, have a look into
Documentation/hwmon/submitting-patches for additional guidelines.

Guenter

> Thank you a lot in advance, I hope to be able to test and report things 
> efficiently after you answered me.
> 
> Actually I would like to gain experience in linux kernel development, 
> and I would like to watch closely your project in which I have personal 
> interest but that I find also great because it is really useful for 
> everyone. I expect to become a good kernel dev after following this 
> project that I find interesting.
> 
> Thank you very much.
> 
> David Kremer
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

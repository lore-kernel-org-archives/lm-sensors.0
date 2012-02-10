From: Nikolaus Schulz <mail@microschulz.de>
Date: Fri, 10 Feb 2012 20:28:14 +0000
Subject: Re: [lm-sensors] questions about lm-sensors development
Message-Id: <20120210202814.GA12904@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F34E2D5.6080900@gmail.com>
In-Reply-To: <4F34E2D5.6080900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 10, 2012 at 06:47:18AM -0800, Guenter Roeck wrote:
> I have two kernel repositories, one on kernel.org, one on github. The latter is
> a shadow of the first. The repository on kernel.org is used to send pull requests
> upstream, and to serve as feed for the -next tree.
> 
> There are three branches:
> 	hwmon, for bug fixes
> 	hwmon-next, for patches queued up for the next version
> 	hwmon-staging, for patches not ready for upstream submission
> 
> Also, there may be a signed tag named hwmon-for-linus, which is used to reference
> pull requests.

Excellent, so I guess this[1] is the repository to prepare patches for,
right?

I was already wondering, but forgot to ask.

Nikolaus

[1] git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

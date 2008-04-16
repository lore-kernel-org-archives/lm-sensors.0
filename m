From: David Brownell <david-b@pacbell.net>
Date: Wed, 16 Apr 2008 17:27:49 +0000
Subject: Re: [lm-sensors] lm75: Convert to new-style I2C driver
Message-Id: <200804161027.49943.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
In-Reply-To: <200804161434.54335.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 16 April 2008, Jean Delvare wrote:
> Note that David Brownell (Cc'd) had been working on this back in
> September 2007:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021270.html
> Unfortunately he never got around to addressing all my comments, so his
> patch didn't go anywhere. Maybe you can work with David on getting
> something in shape that would be suitable for upstream submission.

ISTR just getting tired of all the iterations ... plus, I
never heard back about the associated SMBALERT# support patch.
(I was using a TMP75, which supports 12-bit temperature sense
as well as SMBALERT# based alarms.)

I'll repost current versions of those patches as followups to
this reply, to aid discussions ...

- Dave



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

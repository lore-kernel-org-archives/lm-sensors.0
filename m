From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 22:02:10 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <1328738530.2261.351.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-08 at 16:17 -0500, Patrick Marty wrote:
> > Patrick, where do you get the 4.4.6 compiler from ? Is it from debian or
> > from a different distribution ?
> 
> The compiler comes from ubuntu 11.10 ( with default packages repositories ).
> 
> 
> > Do you know the exact package version
> > (the latest debian version is 4.4.6-14, for example) ?
> 
> The package version is 4.4.6-11ubuntu2
> 
Hi Patrick,

guess that explains the version differences. I run 11.10 as well, but I
have "backports" in my list of repositories, which means I automatically
ended up with gcc 4.6.1. I reverted to 4.4.6, and with that I can
reproduce the problem. Unfortunately, I managed to "kill" my server
while testing it, meaning there is nothing else I can do until tonight
since that system is at home and I am at work :(.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

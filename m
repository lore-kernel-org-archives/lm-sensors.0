From: David Kremer <david@david-kremer.fr>
Date: Wed, 08 Feb 2012 14:59:16 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <4F328DC4.7000906@david-kremer.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/02/2012 15:49, Guenter Roeck wrote:
> Ubuntu 11.10 is not a LTS release. [...] There seems to be
> some magic in deciding which kernel releases are going to be LTS, my
> predictions usually turn out to be wrong, and I gave up trying.
The 3.0 branch is flagged as a LTS version in archlinux. Knowing their 
way to do thing and to prefer vanilla packages, the 3.0 kernel is a long 
term support version I guess (at least only candidate for bug fixes and 
security patches).

For the ubuntu version, you are probably right, and one shouldn't care 
about ubuntu in particular I guess. But as it concerns the LTS support, 
it could be nice if hwmon drivers could be stable and not broken at each 
security and bugfixes update of the kernel. As well, I wonder if you 
plan to follow this new development guideline.

Thanks to you.

See you later.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 14:49:20 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <20120208144920.GC21061@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 08, 2012 at 09:21:44AM -0500, David Kremer wrote:
> On 08/02/2012 15:11, Guenter Roeck wrote:
> > The latest Ubuntu 11.10 kernel is 3.0.0-15, so it is not that old.
> > Not sure how they count version numbers, if the Ubuntu folks even
> > take the latest upstream kernel, or if they maintain their own
> > independent set of patches. I am running 3.0.0-15 on one of my home
> > systems, and I have -12 as well as -14 installed as well. My laptop
> > at work currently runs -14. All are working fine. So I think it is
> > unlikely to be related to the kernel version
> 3.0.0 is designed to be a LTS (long time support) release as well as 
> this ubuntu version I guess. It means that it should only include 

Ubuntu 11.10 is not a LTS release. The next Ubuntu LTS will be 12.04.
I don't know what kernel is going to be used as base - 3.2 was suggested
earlier, but 3.2 is not going to be a LTS kernel release. 3.3 may be too
late, and who knows if it is going to be LTS anyway. There seems to be
some magic in deciding which kernel releases are going to be LTS, my
predictions usually turn out to be wrong, and I gave up trying.

We'll see, but it may just be that Ubuntu and kernel LTS releases don't match.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

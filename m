From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Wed, 10 Dec 2008 10:30:15 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (k8temp) adapt cpuid handling,
Message-Id: <20081210103015.GL19144@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081205174612.GB5581@alberich.amd.com>
In-Reply-To: <20081205174612.GB5581@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 10, 2008 at 11:03:33AM +0100, Andreas Herrmann wrote:
> On Tue, Dec 09, 2008 at 11:12:39PM +0100, Rudolf Marek wrote:
> > Please tell me why it is not necessary or why you changed that ;)

To be more specific.

There are following CPUID checks necessary in k8temp:

>= K8 RevC

to check for support of temperature reporting at all.

>= RevF

to check for erratum #141

>= RevG (desktop)

to check for temperature skew

(In the future we might have additional checks for
family 0x10 >= RevC to check for erratum 319.)

This devides K8 CPUs into 4 classes (and family 10h CPUs into
2 classes).

Now it is important to notice that (by chance) you can't combine
processors of different classes in a mixed silicon setup.
See the relevant CPU revision guides for those CPUs.
E.g., combining RevC with RevF is not supported.

Thus it suffices to check CPUID of boot CPU.
We don't need to care about unsupported processor combinations.


Regards,
Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

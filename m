From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: p4b_smbus driver reworked
Message-Id: <20040718225756.7a4cc6bf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088267921.8247.3.camel@localhost>
In-Reply-To: <1088267921.8247.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henning,

> this is a reworked and extended version of the prog/hotplug/p4b_smbus
> driver. I needed to add support for the ICH3-M (as found in my Toshiba
> Satellite 5200 Laptop) and did some work on the program logic. I
> didn't want to kill the p4b code so I renamed the source, README and
> Makefile, but basically this is the same as p4b.

This doesn't make much sense to me. As you noticed, the p4b_smbus module
is reaching the end of its life since all 2.6 kernels and newer 2.4
kernels don't need it anymore. So let's not have an additional driver
doing the same now.

We would take a patch against p4b_smbus that adds the support you need.
As for the "work on the program logic", unless this significantly
shorten or clarifies the code, or otherwise adds real value, I see
little to no benefit. What exactly do you intend to do?

Please send unitary patches against lm_sensors 2.8.7 with details of
what they add if you want us to apply them. And remember that major
changes without a solid reason are unlikely to be accepted.

Thanks,

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Sep 2013 19:14:50 +0000
Subject: Re: [lm-sensors] Backporting updated lm85 on RHEL5
Message-Id: <20130912211450.135ba7d0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5229DE5D.7060104@elrepo.org>
In-Reply-To: <5229DE5D.7060104@elrepo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 Sep 2013 19:46:42 +0100, Phil Perry wrote:
> On 12/09/13 19:26, Jean Delvare wrote:
> > Thanks for the report. I have committed the patch to the legacy tree,
> > after all others might be interested...
> 
> In addition to your patch, I also added the following to sensors-detect:
> 
> --- lm_sensors-2.10.8.orig/prog/detect/sensors-detect	2008-12-15 
> 08:36:09.000000000 +0000
> +++ lm_sensors-2.10.8/prog/detect/sensors-detect	2013-09-12 
> 13:25:29.000000000 +0100
> @@ -681,7 +681,7 @@ use vars qw(@pci_adapters_sis5595 @pci_a
>          i2c_detect => sub { lm85_detect(0x41, @_); },
>        },
>        {
> -       name => "SMSC EMC6D100, EMC6D101 or EMC6D102",
> +       name => "SMSC EMC6D100, EMC6D101, EMC6D102 or EMC6D103",
>          driver => "lm85",
>          i2c_addrs => [0x2c..0x2e],
>          i2c_detect => sub { lm85_detect(0x5c, @_); },
> 

Committed, thanks.

> Where can I find that legacy tree? There might be other bits there I can 
> use, or there may be bits I can also contribute. For example, my 
> backported lm85 should also support the adt7468 chip but presumably that 
> would also require support to be backported to lm-sensors.

As documented on http://www.lm-sensors.org/wiki/Download :
$ svn checkout http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-2.10 lm-sensors-2.10

> We also backport support for k10temp into our lm_sensors-2.10.8 package 
> to support our kmod-k10temp driver and would happily contribute that if 
> you don't already have it.

I don't. That being said, this is a legacy branch, so we are only
accepting bug fixes and trivial additions. Any change requiring a
significant amount of new code would not be accepted, at least not by
me. If you really want it in and plan to contribute more to the legacy
branch then I'd rather create a subversion account for you and let you
become the maintainer of the legacy branch.

Frankly, if your users have to install a non-standard lm_sensors
package, you might as well package version 3 and have all the support
for new chips for free.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

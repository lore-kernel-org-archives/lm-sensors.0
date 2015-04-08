From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Apr 2015 18:52:55 +0000
Subject: Re: [lm-sensors] Kernel Panic when running sensors on new CentOS kernel (3.10.0-229.1.2)
Message-Id: <20150408185255.GA10281@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <55256D66.1000400@winfirst.com>
In-Reply-To: <55256D66.1000400@winfirst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 08, 2015 at 11:27:05AM -0700, Guenter Roeck wrote:
> On Wed, Apr 08, 2015 at 11:03:18AM -0700, Mark Hansen wrote:

[ ... ]
> > 
> I would guess that some patch from a later kernel version was back-ported,
> but is missing a critical part. Do you know if the source code for that kernel
> is available somewhere ?
> 

Never mind, I found the source and had a look. It turns out that the
hardware monitoring code in drivers/gpu/drm/radeon/radeon_pm.c (which
is what affects you) is broken in 7.1. You might want to open a case
with the CentOS community (or possibly Fedora / Redhat).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

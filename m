From: Tomas Winkler <tomas.winkler@intel.com>
Date: Wed, 26 Dec 2012 07:56:26 +0000
Subject: Re: [lm-sensors] RFC: Intel QST driver
Message-Id: <CA+i0qc6K-dXDFbTLaxH7VUMOsGKCpUr_yG-1-1vis+D4wEcJDA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <50D81465.9060802@mose.org.uk>
	<20121224193038.GA7786@roeck-us.net>
In-Reply-To: <20121224193038.GA7786@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Simon J. Rowe" <srowe@mose.org.uk>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Samuel Ortiz <samuel.ortiz@intel.com>

> >
> > 4) I don't believe the MEI (HECI) implementation that Intel have
> > already submitted to the mainline kernel is usable by other kernel
> > modules. I have re-implemented it in a way that is accessible to
> > either the kernel or userspace.
> >
> 2.6.39 does not include the new mei driver, so I don't think you can make
> that claim.
>
 We are working on adding possibility of stacking another drivers
above the MEI
in these days. I cannot commit to specific time line yet but it is on the way.


Thanks
Tomas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

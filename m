From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Mar 2014 03:06:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon, k10temp: Add support for AMD F16 M30h processor
Message-Id: <531FCF3D.8020409@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1394573159-2317-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
In-Reply-To: <1394573159-2317-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, clemens@ladisch.de, jdelvare@suse.de, rob@landley.net, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andre@andrep.de

On 03/11/2014 02:25 PM, Aravind Gopalakrishnan wrote:
> Adding new PCI ID to support AMD F16 M30h processor (Mullins).
> While at it, modify Kconfig and Doc files to reflect the
> support for newer processors
>
> Note: PCI ID for this processor will make it into pci_ids.h
> as part of this patch:
> http://marc.info/?l=linux-kernel&m9291362126057&w=2
> which should be pulled into 3.15 when merge window opens
> (It currently sits in 'for-next' branch of bp.git-
> https://git.kernel.org/cgit/linux/kernel/git/bp/bp.git/log/?h=for-next)
>
> Signed-off-by: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>

Looks good. We'll have to see how we can apply this; probably after 3.15-rc1
comes out. I'll put it into my -staging branch for now and pull in the other
patch as well to make sure it compiles.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

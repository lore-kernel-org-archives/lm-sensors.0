From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 12 Mar 2014 09:25:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon, k10temp: Add support for AMD F16 M30h processor
Message-Id: <20140312102511.77faa6ff@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1394573159-2317-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
	<531FCF3D.8020409@roeck-us.net>
In-Reply-To: <531FCF3D.8020409@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, clemens@ladisch.de, rob@landley.net, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, andre@andrep.de

On Tue, 11 Mar 2014 20:06:37 -0700, Guenter Roeck wrote:
> On 03/11/2014 02:25 PM, Aravind Gopalakrishnan wrote:
> > Adding new PCI ID to support AMD F16 M30h processor (Mullins).
> > While at it, modify Kconfig and Doc files to reflect the
> > support for newer processors
> >
> > Note: PCI ID for this processor will make it into pci_ids.h
> > as part of this patch:
> > http://marc.info/?l=linux-kernel&m9291362126057&w=2
> > which should be pulled into 3.15 when merge window opens
> > (It currently sits in 'for-next' branch of bp.git-
> > https://git.kernel.org/cgit/linux/kernel/git/bp/bp.git/log/?h=for-next)
> >
> > Signed-off-by: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
> 
> Looks good. We'll have to see how we can apply this; probably after 3.15-rc1
> comes out. I'll put it into my -staging branch for now and pull in the other
> patch as well to make sure it compiles.

I've updated the wiki accordingly, as well as sensors-detect.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

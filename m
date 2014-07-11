From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 11 Jul 2014 04:22:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon, fam15h_power: Remove needless pci dev id
Message-Id: <53BF66A2.2040109@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405030560-2128-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
In-Reply-To: <1405030560-2128-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, herrmann.der.user@googlemail.com, jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 07/10/2014 03:16 PM, Aravind Gopalakrishnan wrote:
> PCI_DEVICE_ID_AMD_16H_NB_F4 can be obtained from it's
> definition in pci_ids.h. So we don't have to define it
> again here.
>
> Signed-off-by: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

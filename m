From: Jean Delvare <jdelvare@suse.de>
Date: Sat, 25 Jul 2015 16:30:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k10temp) remove duplicate pci-id define
Message-Id: <20150725183040.11f4d262@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437133879-5352-1-git-send-email-adamm@zombino.com>
In-Reply-To: <1437133879-5352-1-git-send-email-adamm@zombino.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 20 Jul 2015 07:45:06 -0700, Guenter Roeck wrote:
> On 07/17/2015 04:51 AM, Adam Majer wrote:
> > PCI_DEVICE_ID_AMD_15H_M60H_NB_F3 is now defined in pci_ids.h
> >
> > Signed-off-by: Adam Majer <adamm@zombino.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Jean, do you want to take that one, or should I take it ?

I picked it.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

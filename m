From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: [PATCH 2.4] sis5595 and lm78 drivers improvements
Message-Id: <20050126204557.78c7cf28.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050126175741.GA16224@bode.aurel32.net>
In-Reply-To: <20050126175741.GA16224@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aurelien,

> Please find attached a patch that improve sis5595 and lm78 drivers for
> 2.4 kernels. It is based on the 2.6 patches that have been sent on the
> mailing list.

Thanks. A couple notes though. First, please do not prefix the subject
with [PATCH 2.4] for such patches. They do not apply to Linux 2.4 in any
way.

About the patch itself:

> -			PCI_DEVICE_ID_SI_5598,
> -			0x645,
> -			0x735,
> -                          0 };
(...)
> +			PCI_DEVICE_ID_SI_5598
> +                          };

You killed the list termniator! Restored.

Rest of my changes were minor, after which I applied the patch. Thanks
again.

-- 
Jean Delvare
http://khali.linux-fr.org/

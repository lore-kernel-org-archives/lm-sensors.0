From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 06 Sep 2006 19:43:04 +0000
Subject: [lm-sensors] i2c_nforce2 on ASUS K8N-DRE
Message-Id: <20060906214304.aa1e9574.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E7EB4A8D5B2C8F498A269F0963C8BB8E038328@mail.atipa.com>
In-Reply-To: <E7EB4A8D5B2C8F498A269F0963C8BB8E038328@mail.atipa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Brady,

> I forgot to mention that the PCI ID  worked on Tyan 2891 did
> not work for the ASUS k8n-dre.

If that's the same device, that's the same ID, so if you use the same
kernel on both and it works for one board it must work for the other.

You can check the exact ID with "lspci -n".

-- 
Jean Delvare


From: bchang@atipa.com (Brady Chang)
Date: Wed, 06 Sep 2006 19:58:33 +0000
Subject: [lm-sensors] i2c_nforce2 on ASUS K8N-DRE
Message-Id: <E7EB4A8D5B2C8F498A269F0963C8BB8E03832C@mail.atipa.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E7EB4A8D5B2C8F498A269F0963C8BB8E038328@mail.atipa.com>
In-Reply-To: <E7EB4A8D5B2C8F498A269F0963C8BB8E038328@mail.atipa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I imagine that should be the case.
I have another computer with supermicro board. That seems to work once I added the newIDs.
 
on k8n-dre:
lspci -n
00:01.1 Class 0c05: 10de:0052 (rev a2)
 
on H8DCE-HTE
lspci -n 
00:01.1 Class 0c05:  10de:0052 (rev a2)
 
Check with ASUS for now.
 
thanks
-Brady

________________________________

From: Jean Delvare [mailto:khali at linux-fr.org]
Sent: Wed 9/6/2006 2:43 PM
To: Brady Chang
Cc: lm-sensors at lm-sensors.org
Subject: Re: [lm-sensors] i2c_nforce2 on ASUS K8N-DRE



Brady,

> I forgot to mention that the PCI ID  worked on Tyan 2891 did
> not work for the ASUS k8n-dre.

If that's the same device, that's the same ID, so if you use the same
kernel on both and it works for one board it must work for the other.

You can check the exact ID with "lspci -n".

--
Jean Delvare


-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/9c3ce58b/attachment.html 

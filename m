From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 06 Sep 2006 21:19:05 +0000
Subject: [lm-sensors] i2c_nforce2 on ASUS K8N-DRE
Message-Id: <20060906231905.a80f40d9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E7EB4A8D5B2C8F498A269F0963C8BB8E038328@mail.atipa.com>
In-Reply-To: <E7EB4A8D5B2C8F498A269F0963C8BB8E038328@mail.atipa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I imagine that should be the case.
> I have another computer with supermicro board. That seems to work once I added the newIDs.
>  
> on k8n-dre:
> lspci -n
> 00:01.1 Class 0c05: 10de:0052 (rev a2)
>  
> on H8DCE-HTE
> lspci -n 
> 00:01.1 Class 0c05:  10de:0052 (rev a2)
>  
> Check with ASUS for now.

Is it the same kernel? You need hotplug support, else adding the new id
on the fly doesn't work.

Please provide the output of "lspci -xxx -s 00:01.1" on the failing
machine.

Nothing in the logs when you add the new id? The driver should complain
if something goes wrong.

-- 
Jean Delvare


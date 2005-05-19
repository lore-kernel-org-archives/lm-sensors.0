From: ilya@total-knowledge.com (Ilya A. Volynets-Evenbakh)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-Id: <41DD9313.4030105@total-knowledge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de> <20050106192701.GA13955@linux-mips.org>
In-Reply-To: <20050106192701.GA13955@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, greg@kroah.com, Ladislav Michl <ladis@linux-mips.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com, linux-mips@linux-mips.org

Ralf Baechle wrote:

>On Thu, Jan 06, 2005 at 07:15:20PM +0100, Adrian Bunk wrote:
>
>  
>
>>There's no reason for offering a MIPS-only driver on other architectures 
>>(even though it does compile).
>>
>>Even better dependencies on specific MIPS variables might be possible 
>>that obsolete this patch, but this patch fixes at least the !MIPS case.
>>    
>>
>
>Please make that depend on SGI_IP22 || SGI_IP32 instead; the only machines
>actually using it.
>
>Ladis, is VisWS using this algo also?
>  
>
Since MACE is common part, it most likely does.

>  Ralf
>
>  
>

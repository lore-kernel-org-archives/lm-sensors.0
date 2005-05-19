From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: drivers/w1/: why is dscore.c not ds9490r.c ?
Message-Id: <1101108672.2843.55.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041121220251.GE13254@stusta.de>
In-Reply-To: <20041121220251.GE13254@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 01:02, Adrian Bunk wrote:
> Hi Evgeniy,

Hello, Adrian.

> drivers/w1/Makefile in recent 2.6 kernels contains:
>   obj-$(CONFIG_W1_DS9490)         += ds9490r.o 
>   ds9490r-objs    := dscore.o
> 
> Is there a reason, why dscore.c isn't simply named ds9490r.c ?

dscore.c is a core function set to work with ds2490 chip.
ds9490* is built on top of it.
Any vendor can create it's own w1 bus master using this chip, 
not ds9490.


> TIA
> Adrian
-- 
	Evgeniy Polyakov

Crash is better than data corruption. -- Art Grabowski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041122/266ea6f1/attachment.bin

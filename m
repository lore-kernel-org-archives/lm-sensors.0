From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Sep 2008 20:25:37 +0000
Subject: Re: [lm-sensors] on a "via686a-*" sensors reports always the same
Message-Id: <20080929222537.0437125c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7cd7a3e80809290142w32aea211l3b35834000a1cbef@mail.gmail.com>
In-Reply-To: <7cd7a3e80809290142w32aea211l3b35834000a1cbef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 29 Sep 2008 21:00:10 +0200, Pierre Bauduin wrote:
> Hi there,
> 
> More information regarding the previous message:
> 
> I forgot to tell you I had this error message when booting:
> via686a 0000:00:07.4: base address not set - upgrade BIOS or use
> force_addr=0xaddr
> so I had to add the following line:
> options via686a force_addr=0x6000
> in the file /etc/modprobe.d/options
> 
> ... I guess that's where I am wrong.
> 
> Perhaps isn't 0x6000 the right value ? I googled for "via686a base address
> not set" and in most cases the value was 0x6000

Forcing the address to anything that is free is OK (check
in /proc/ioports). However, if the manufacturer didn't set the address,
it most certainly means that they didn't make use of the hardware
monitoring features of the VIA south bridge. This explains why you
can't get any reading out of it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

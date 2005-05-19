From: charles@defenderhosting.com (Charles Galpin)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <BE6CAC27-6BA1-11D8-96BE-000A958E5EF8@defenderhosting.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Again

On Mar 1, 2004, at 10:53 AM, Jean Delvare wrote:
>
> FYI, the problem is not with the ADM1027 itself (if that's what it is)
> but with activating the AMD-8111 bus it is supposed to be connected
> to.
>
> This much ressembles the hidden SMBus problem seen on ICH2 and ICH4
> chips, as well as some ALi chips if I remember correctly. But we've
> never seen it on AMD's so far, and I don't know how we can get
> information about it.
>
> If you know anything about how we could activate that hidden 8111 bus,
> please let us know!

I really appreciate your efforts here guys. This is is what I got back 
from the vendor, who said this was from the motherboard engineer ( 
assume from MSI). Those locations look like physical locations from the 
manual or something.

How can I explain the concept of "activating the AMD-8111 SMBus" to 
him? What do you need - memory locations to address the chip with?

thanks
charles


> --------------------------
>
> Please see the picture file attached below. The location where (A) is
> pointing is the 6649MUA chip(location U30, U66), this is where we read
> the CPU temperature from. the other one is (B) is ADM1027(location U07,
> U21) chip where our other motherboard system health info(fan speed,
> voltage) is derived.
>
> --------------------------


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 9245.jpg
Type: image/jpeg
Size: 345954 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040301/2ac6efb0/9245.jpg

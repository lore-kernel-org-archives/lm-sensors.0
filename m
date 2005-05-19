From: charles@defenderhosting.com (Charles Galpin)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <D762CF1A-68A4-11D8-972E-000A958E5EF8@defenderhosting.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Feb 26, 2004, at 4:04 PM, Jean Delvare wrote:
>
> I tried to forcibly enable the device. Looks like I did not break
> anything, but the supposed address of the device (0x200) is empty :( So
> it is probably not there at all.
>
> There's nothing more I can do at the moment.
>
> Two possible tracks:
>
> 1* Open the case and look for your monitoring chip. Maybe we are not
> looking for the right thing. Visual confirmation would help.
>
> 2* Enable the AMD8111 SMBus. I have no idea how this can be done, but 
> if
> your monitoring chip is there, we won't reach it else.
>
> Sorry I can't help more, this is simply at the limit of my knowledge of
> the topic (wrong side of the limit, unfortunately...)
>
> Maybe you can ask the motherboard manufacturer, or hardware supplier,
> for information?

Thanks so much for the help. I will try get to look at the physical 
machine myself this weekend to make sure, but the PDFs  clearly show it 
being a 8111. I will also look at the bios (i had someone else look 
before).

thanks
charles

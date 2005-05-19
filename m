From: ckelley@ibnads.com (Craig Kelley)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [PATCH 2.6] new sensors driver: SMSC LPC47B397-NC
Message-Id: <41DAC5E3.1070609@ibnads.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050102212924.GB17759@jupiter.solarsys.private>
In-Reply-To: <20050102212924.GB17759@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:

>Hi Jean:
>
>(CC Craig Kelly who can skip to the very bottom of this message...)
>
>* Jean Delvare <khali@linux-fr.org> [2005-01-03 20:58:54 +0100]:
>  
>
>>Additional question:
>>This driver uses logical device 8, while sensors-detect probes device
>>0x0a. Is this a bug in sensors-detect?
>>    
>>
>
>Yes, and that's a great catch by the way (since that didn't even appear in
>this patch).  I only tested the sensors-detect patch on real h/w once, and
>it worked that way... but in the driver I don't do any activation test 
>anyway (as it's not specified in the "datasheet")... reading further, I see
>that it's claimed to be present on all ISA PnP so I guess it can't hurt to
>have it in sensors-detect.
>
>Craig: I'll commit a patch to sensors-detect tonight.  I would appreciate
>if you try it again on the actual hardware and let me know if it fails.
>  
>
Thanks; just let me know when to sync with CVS and I'll give it a go.

--
Craig Kelley
In-Store Broadcasting Network
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050104/7b2714b8/attachment.html

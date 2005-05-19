From: cheaterjs@gmx.de (Jan Schiefer)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: False detection of sensors on MSI K7N2 Delta-L (NForce2)!
Message-Id: <415C0235.8010903@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <415BD873.8010303@gmx.de>
In-Reply-To: <415BD873.8010303@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare schrieb:

>On Thu, 30 Sep 2004 12:43:26 +0200, Jan Schiefer wrote
>  
>
>>Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no):
>>FATAL: Module i2c_nforce2 not found.
>>Loading failed... skipping.
>>    
>>
>
>Hmm, didn't you compile this one as a module? No SMBus for you without it (but
>maybe you don't care.)
>
>  
>
>>Do you want to scan for secondary Super I/O sensors? (YES/no):
>>(...)
>>Probing for `Winbond W83627HF Super IO Sensors'
>>  Success... found at address 0x0290
>>    
>>
>
>OK, I get it. The chip is on the secondary Super I/O address. The w83627hf
>driver only checks the primary address. Same as ticket #1780.
>http://secure.netroedge.com/~lm78/readticket.cgi?ticket80
>
>There are Super-I/O developments in progress in 2.6. Once they are done, we
>should be able to link the w82627hf driver there and get support for the
>secondary address for free.
>
>For 2.4, we should probably hack the driver directly. I don't have such a
>chip, so it won't be me. We welcome patches :)
>
>Thanks for reporting.
>
>  
>
Ok...well, well.

Temporary you should put a line saying that the w83781d may work too if 
a secondary w82627hf has been found into sensors-detect script.

This may prevent many people from hacking thier heads onto their 
keyboard and will make Linux a bit more perfect. :) This is because 
hearware monitoring is really important.

Thanks and greetings,
Jan Schiefer.

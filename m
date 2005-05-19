From: aj@ectologic.com (Aj Lavin)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: bmc and fan speed control
Message-Id: <4280F320.1020707@ectologic.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <427FF313.7070202@mds.gotdns.com>
In-Reply-To: <427FF313.7070202@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Al,
>  
>
AJ :-)

>>Intel SHG2 motherboard which I believe uses a Sahalee BMC. It also
>>employs an ADM1021 which I think does the fan control. (...)
>>    
>>
>
>Not a chance, as the ADM1021 is a two-temperature chip. It doesn't deal
>with fans at all.
>
>The SHG2 manual mentions an ADM1026 instead, which is a full-featured
>hardware monitoring chip, and has some fan speed control capabilities.
>  
>

You are right, I shouldn't type chip names from memory! I meant I think 
the ADM1026 does the fan speed control for the Intel SHG2 motherboard. 
Notice on page 30 of the SHG2  Technical Product Specification it says 
pin 18 of the ADM1026 is "PWM" : "Pulse width modulation of fan speed".

Now my question is, is it feasible to control the fan speed on an Intel 
SHG2 motherboard from Linux?

Best Regards,
Aj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 2773 bytes
Desc: S/MIME Cryptographic Signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050510/abacebd3/smime.bin

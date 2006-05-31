From: ymu@Winbond.com.tw (Yuan Mu)
Date: Wed, 31 May 2006 01:50:28 +0000
Subject: [lm-sensors] [PATCH] New VID codes for Intel Core and Conroe
Message-Id: <447CF664.3080909@winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <447815E5.5060601@sh.cvut.cz>
In-Reply-To: <447815E5.5060601@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> 
>> I tried ;)
>> vrm:110
>> cpu0_vid:1513
>> cpu1_vid:1225
>>
> 
> The second one looks good. The first one is in fact 001111 which is a 
> bit suspicious value. Please can you check the driver/raw bits reading?
> 

VID0REG: 0x10
VID1REG: 0xbf


cpu0_vid:1513
cpu1_vid:1219

in0_input:1182
in1_input:1188


Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ymu.vcf
Type: text/x-vcard
Size: 56 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/6dbe9cc0/ymu.vcf

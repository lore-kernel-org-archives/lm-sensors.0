From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 29 Aug 2006 20:32:12 +0000
Subject: [lm-sensors] [PATCH] k8temp documentation OT: TjOffset
Message-Id: <44F4A44C.1040804@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Rudolf,
> 
>> I don't know the TjOffset value maybe someone has AM2 K8? (if so then lspci -xxx 
>> please)
> 
> I know Prakash and Juergen do have AM2 K8 systems, maybe they can
> provide the lspci -xxx you are looking for?
> 

Prakash was so kind and I have lspci -xxx now.

e0: 00 00 00 00 24 1b 51 00 19 17 00 00 00 00 00 00

It should be in 0xe7 which happen to be 0x00 this means that TjOffset is 0
Question is if this TjOffset changes during different temperatures or not... I 
guess it remains constant.

Regards
Rudolf


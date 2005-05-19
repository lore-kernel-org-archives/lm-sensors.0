From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: preferred submission method for updated kernel 2.6.X lm85 driver?
Message-Id: <410E87CF.20807@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040802171618.GA27200@penguincomputing.com>
In-Reply-To: <20040802171618.GA27200@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Justin actually works *for* me...  So I'm OK with his work.

:v)

Jean Delvare wrote:

>>I have been busy porting forward the fancontrol bits in the lm85
>>driver to the 2.6.X kernel (and associated /sys/bus/...) architecture.
>> There is a
>>great deal of rewritten code since I tried to make it fit reasonably
>>well with the most recent fan control model.
>>
>>With so much rewritten code, would it be just as well to submit the
>>entire driver code to the list, or is a patch still preferrable?
>>    
>>
>
>Patche_s_ are still prefered. Split the changes in as many patches as
>necessary so that each patch is understable and, if possible, applyable
>by itself.
>
>It would be great if Philip Pokorny could review your work, since he
>wrote the original driver and also reviewed the auto-fan proposals.
>
>Thanks.
>
>  
>


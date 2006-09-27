From: r.marek@assembler.cz (Rudolf Marek)
Date: Wed, 27 Sep 2006 10:38:30 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <451A54A6.2060103@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Michael Nelson wrote:
> On Wed, Sep 27, 2006 at 08:20:51AM +0200, Rudolf Marek wrote:
>
>   
>> Please add this two printk to this code:
>>
>>               data->therm_status = eax;
>>               printk("EAX from  MSR %x\n", eax);
>>
>>                  /* update only if data has been valid */
>>                  if (eax & 0x80000000) {
>> 			printk("in temp condition\n");
>>     
>
> Uhhhh... add them WHERE?
>
>   
Find this line:

  data->therm_status = eax;

on next line add

 printk("EAX from  MSR %x\n", eax);

and find this line:
if (eax & 0x80000000) {
and on next line add

printk("in temp condition\n");


Thanks.

> BTW, the hw monitoring chip on my motherboard (Asus P5B Deluxe WiFi) already
> does report CPU temp.
>   
Yes but I need to test this ;)

Thanks,
Rudolf


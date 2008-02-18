From: Sean MacLennan <seanm@seanm.ca>
Date: Mon, 18 Feb 2008 18:15:14 +0000
Subject: Re: [lm-sensors] [PATCH] Add driver for AD7414 i2c temperature
Message-Id: <47B9CB32.40709@seanm.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <A42C17A8FF150C4DB98BFD6497D1D00007F45D79@ussvlexmbpf1.spansion.com>
In-Reply-To: <A42C17A8FF150C4DB98BFD6497D1D00007F45D79@ussvlexmbpf1.spansion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Sean,
>
> On Sun, 17 Feb 2008 15:33:14 -0500, Sean MacLennan wrote:
>   
>> I tried this driver and it didn't detect my ad7414 chip...  the probe 
>> function is never called
>>
>> I am using the i2c-ibm_iic.c driver for the i2c bus and running 2.6.25-rc2.
>>
>> It works using a different version of the driver and the attach and 
>> detach methods. Could the ibm iic driver be missing something?
>>     
>
> Frank's driver is a "new-style" i2c driver. These drivers do not probe
> the i2c adapters for supported chips automatically. Instead, platform
> code should explicitly instantiate the I2C devices that are present on
> the system. In the case of embedded designs, this is typically done by
> calling i2c_register_board_info() in platform code.
>   
That works, thanks! So the patch works for me.

Cheers,
   Sean

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

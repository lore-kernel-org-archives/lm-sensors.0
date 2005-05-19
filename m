From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: emc6d102 support
Message-Id: <41FFE34E.7040309@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502011003.40803.rafael.espindola@gmail.com>
In-Reply-To: <200502011003.40803.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Rafael Esp?ndola wrote:

>On Tue, 01 Feb 2005 07:45:55 -0800, Philip Pokorny
><ppokorny@penguincomputing.com> wrote:
>  
>
>>Yes, you should add the additional two bits of resolution.
>>    
>>
>Ok. I will take a look during the next weekend. 
>  
>
This is similar to the ADM1027 which also has extended bits of 
resolution.  Support for reading the extended bits exists in the 2.4 
version of the lm85 driver (look for ADM1027_REG_EXTEND_ADC and related 
bits).

Interestingly, the EMC6D102 does things a bit differently than the 
ADM1027.  It actually offer *12* bits of resolution if the chip is 
running in x16 or x32 averaging mode.  The 8-bit register must be read 
*first* before the LSB are read.  It's the other way round on the ADM1027.

It might make sense to change the "extend_adc" member to an array, and 
then have "lm85_update_client" function break the registers into the 
array members depending on if it's an ADM1027 or a EMC6D102.  That way 
you can keep a single function to get the value in a way that adds in 
the extended bits.

:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com

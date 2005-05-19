From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: bmcsensors and strange sensor values.
Message-Id: <4148E16F.5060706@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A0FF82385BEB4C8670E255530B338527B4CE@mssydeb.asi.com.au>
In-Reply-To: <45A0FF82385BEB4C8670E255530B338527B4CE@mssydeb.asi.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In the LM85 driver, I did the following:

   Reading   Indicated Speed
     0         -1
     1         max speed
    ...         ...
    254        min speed
    255         0


:v)

Peter Wilsmore wrote:

>Doh! Yeah your right, I didn't think the r value would ever be zero, but
>it would have been right to check anyway and saved me a lot of time.
>Just has a philosophical question, if I do get a value of 0 returned
>should I be setting the fan speed to 0 (which reflects what happens when
>the fan stops spinning) or to max value (which reflects what is
>happening when the interval between pulses is smaller than the unit
>measured)? In my case it seems the fan is spinning very, very fast so
>the interval between pulses is smaller than the units they are measuring
>so setting the fan speed to 0 does not reflect what is actually
>happening in the chassis.
> 
>Thanks,
>
>Peter Wilsmore
> 
>ASI SOLUTIONS
>Direct: 1300130 837
>
>  
>
>>-----Original Message-----
>>From: Philip Pokorny [mailto:ppokorny@penguincomputing.com]
>>
>>Could it be that you're dividing by zero?  You don't check the value
>>    
>>
>of
>  
>
>>'r' before the division to be sure that it's not zero.  If there is a
>>fan failure and the current fan speed is 0, then perhaps r is returned
>>as 0 instead of it's max value.
>>
>>:v)
>>
>>--
>>Philip Pokorny, Director of Engineering
>>Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
>>PENGUIN COMPUTING, INC.
>>www.penguincomputing.com
>>
>
>
>  
>

-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com

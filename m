From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <42193106.2090403@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Philip,
>
>  
>
>>>Device revision 0x6A. ADM1027 is documented as 0x60+, ADT7463 is
>>>documented as 0x62+, so I would indeed agree that it must be an
>>>ADT7463. Our driver needs to be updated.
>>>      
>>>
>>Where do you see that in the datasheet?
>>
>>The way I read this datasheet:
>>
>>http://www.analog.com/UploadedFiles/Data_Sheets/272624927ADT7463_c.pdf
>>
>>It says that the only valid values for the REVISION register are 0x62 
>>and 0x6A.  (see Table IV on page 32)  It doesn't say that any value 
>>larger than 0x62 is an ADT7463.
>>    
>>
>
>My conclusion was based on the revision B of the datasheet (thanks for
>the pointer to the new one). Revision B didn't mention 0x6A as possible,
>only 0x62.
>
>It is very common that datasheets will document the lowest possible
>revision/stepping for a chip, leaving it up to us to decide which range
>we want to accept. This is what I proposed (and committed), based on
>both the ADM1027 (rev.A) and the ADT7463 (rev.B) datasheets.
>  
>
OK.  I haven't seen a range of revisions documented in a datasheet, but 
I believe that you've read more datasheets than I have.

>>I think it might be safer to just add 0x6A as a valid ADT7463 chip. 
>>    
>>
>
>How exactly is it safer? I obviously don't know the LM85 and compatibles
>family as good as you do, but I don't see what risk we have here. The
>worst that could happen would be that we think the chip has feature it
>doesn't actually have, right? These features will just not work, and
>users will report about it.
>  
>
Or the register bits could have changed in a non-backward compatible 
way.  We could end up disabling something or turning something off that 
causes the system to overheat when we attempt to program the ADT7463 
specific functions.

Witness the recent changes to the config bits on the LM75 driver.  The 
operation of the interrupt output function.

>And even that is unlikely, IMHO. I think I understand that the ADT7463
>has more features than the ADM1027 had, and higher stepping numbers. A
>newer chip in that family would certainly follow the same rules: higher
>stepping number, additional features. My code admittedly assumes that.
>  
>
Each member of the lm85 family has it's additional features implemented 
differently.  Registers above 0x70 are generally completely manufacturer 
specific.  (Register 0x74 and 0x75 are completely different between the 
LM85 and the ADM1027/ADT7463)

And between the ADM1027 and the ADT7463, there is the _THERM_Enable bit 
in Configuration Register 3.  This bit is not defined on the ADM1027 but 
is on the ADT7463.  This bit controls the Interrupt or 
"overheat/shutdown" function of the chip and system.  Not something we 
want to program incorrectly.

Lastly, the ADT7463 datasheet says "DO NOT WRITE TO THESE REGISTERS" in 
the description of registers 0x7e and 0x7f.  These registers are named 
"Test Register 1" and 2.  What other "test registers" might exist in 
future or compatible chips that shouldn't be written to?  What if they 
happen to be at the same address as one of the config registers 
currently implemented in the ADT7463 driver?

>The problem with your method is that it requires a change to the driver
>with every new chip revision. With mine we only have to change the code
>if the new chip revision has new features. In the meantime the driver
>will provide as many features as possible, while with your approach it
>will feature the minimal subset.
>  
>
Shouldn't we investigate each revision of the chip to determine if there 
are new features that should be enabled or bits that have changed rather 
than just blindly assuming the manufacturer made a backward compatible 
upgrade?

I would suggest that the "minimal subset" would be a much better default 
than the "maximum functionality" that your patch produces.

>As a matter of fact, with my code, Christophe's chip would have been
>properly detected. With yours it required a driver update.
>  
>
The driver should have already detected his chip correctly.  There is an 
else/if clause that matches for the Analog Devices manufacturer ID and a 
generic '0x6?' revision ID.  In that case, it should detect the chip and 
provide the basic functionality along with a message to advise them to 
look into the driver for better support.

                } else if( company = LM85_COMPANY_ANALOG_DEV
                    && (verstep & LM85_VERSTEP_VMASK) = 
LM85_VERSTEP_GENERIC) {
                        printk("lm85: Detected Analog Devices chip\n");
                        printk("lm85: Unrecgonized version/stepping 0x%02x"
                            " Defaulting to Generic LM85.\n", verstep );
                        kind = any_chip ;

Did this code not work in this case?

>So unless there is a real risk I am missing, I do believe that the
>change I made is an improvement.
>  
>
And we disagree.  But that is the nature of the open source development 
process.

:v)

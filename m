From: chw@scs.co.uk (Charles Whittington)
Date: Mon, 17 Oct 2005 12:29:02 +0000
Subject: [lm-sensors] lm_sensors 2.9.2 & kernel 2.6.8-24
Message-Id: <43537C9E.3060609@scs.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <434F973D.5080607@scs.co.uk>
In-Reply-To: <434F973D.5080607@scs.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

Thanks - answers inline.

Jean Delvare wrote:

>Hi Charles,
>
>Please answer to the list, not to me only!
>  
>

So sorry - slipped up!

>  
>
>>nport1:~ # i2cdetect 0
>>Error: Could not open file `/dev/i2c-0': No such device
>>nport1:~ #
>>    
>>
>
>modprobe i2c-dev
>
>Sorry for nor telling you, sensors-detect loads it for you and I didn't
>figure out you'd have rebooted since.
>
>  
>
>>>So you have a Super-I/O chip, most probably from National Semiconductor.
>>>Do you happen to know what it is? Our script doesn't seem to know.
>>>Sometimes Super-I/O chips include hardware monitoring capabilities.
>>>      
>>>
>>No - I don't - and I don't really want to go digging under the keyboard
>>to look for the MB unless I have to!!
>>    
>>
>
>Yeah, I understand. I wasn't even able to open my own laptop. But
>sometimes you have some technical documentation which states which chips
>you have. Unfortunately, more often than not, the Super-I/O chip isn't
>listed.
>
>  
>
>>No - not certain at all. It does support ACPI which was off when I did
>>previous results (trying to see if it was causing the problem). I can't
>>seem to turn it on again - removing acpi=off from boot loader should do
>>it I think - but it hangs the system - maybe this is a clue? Or am I
>>being dim?. Therefore no /proc/acpi files at the moment!
>>    
>>
>
>I can't say. ACPI is a very complex area, some laptops need it, some
>don't like it at all, there are quirks required for half of them.
>Depending on the model, it might work on a version and not on another.
>We can't help you with this, see with the linux-acpi folks.
>
>--
>Jean Delvare
>
>  
>
I have decided to go for SuSE 10 which has 2.6.13 which I need for a 
server anyway. I will put it on the laptop and if problems continue I 
will know its probably hardware and try again with lm_sensors on the 
later kernel.

Thanks very much for your help.

Charles Whittington



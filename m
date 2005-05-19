From: mshannon@themattpad.com (Matthew M. Shannon)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c kernel patch issue with bttv-if module
Message-Id: <3F17D8F1.9000300@themattpad.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F16DAEA.1060802@themattpad.com>
In-Reply-To: <3F16DAEA.1060802@themattpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>I think it was user error on my part.
>>
>>I got confused by the links on the page... I downloaded the i2c and
>>not the complete patch.
>>
>>that one took a few minutes to figure out, sorry for any inconvience.
>>    
>>
>
>I updated my page to make it clearer. Tell me if it is clear enough for
>you :)
>  
>
Much better, Thanks! That most likely saved you a lot of emails.


>  
>
>>I've been having a heck of a time with my new iWill  mobo (dual xeon) 
>>and trying to get the lm sensors to work right, I think support for
>>the winbond support is updated in 2.8...
>>    
>>
>
>Almost everything is updated, so it may work for you.
>  
>
It does...sort of, temps are still off, but not by much (vs. BIOS)

>  
>
>>However, if I do notice some temp calc math errors, what's the best
>>way to handle that?
>>    
>>
>
>First read the chip-specific doc file, then read the chip-specific
>section in sensors.conf. Sometimes there are things you can change
>there. If it still doesn't work, try your own formulas in the config
>file (guess work, usually long). If you can't get it to work, contact us
>and we'll try to help.
>  
>
Will do, thanks again!

M

>  
>


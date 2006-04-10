From: Ymu@Winbond.com.tw (Ymu@Winbond.com.tw)
Date: Mon, 10 Apr 2006 10:28:03 +0000
Subject: [lm-sensors] w83792d watchdog
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE0100ECFE@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <442B0C6F.4080604@sh.cvut.cz>
In-Reply-To: <442B0C6F.4080604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,
I have finished the w83793 driver, and i'm testing it.
So i can be the tester if you need testers on watchdog now, 

And i have some questions about the watchdog, please see below.


> 
> I begun to work on the watchdog support for w83792d. I have 
> several questions about the watchdog device in w83792d. Please can
> yuou forward them to responsible person?
> 
> I'm using ver 1.0 of datasheet
> 
> There are 4 watchdog regs:
> 
> CR01 handles the unlock codes
> CR02 "Watch Dog Enable" -> this should be more likely called 
> "Watch Dog Enable Status" - because this regs are RO only
> CR03 is quite mystery for me
>       the "WDT stage" is not described in datasheet at all, I 
> assume this has someting to do with hard mode of watchdog
> 
> 
> the HARD_TO and SOFT_TO have following commnents:
> 
> HARD_TO: 1: a hard timeout occurs. This bit will be cleared 
> while reading.
> 
> What I know:
> 
> 1) this bit is not cleared on reading
> 2) I think the sentece should be: "a hard timeoud had occured"
>      because this is set when there was a timeout/reset it seems
> 
Hmm, you mean reading after reboot will not clear the bit?
Reading use i2cdump after reboot will clear the bit in my computer. 


> This is so far to datasheet, now to real funcs:
> 
> 1) What will happen if I enable hard and soft watchdog same 
> time? (i'm disabling the hard watchdog timer in first place so
> it should not be an issue but you never know)

I tried write 0x33 and 0x55 to CR01, it seems only the last one is
enabled by reading CR02.

> 2) I tried many ways to reset the watchdog timer but only 
> seems to work is to write 0xAA to CR1 and then 0x55 to re-enable it.
>      This seems bit strange because the computer can fail 
> just in between of this two writes Yes I know this is not 
> probable, but
>      the best method is just to re-write the timeout value or 
> rewrite the enable (0x55) - as others might do. Were there
>      some strange reason for this design?
> 

I'm quite confusing about this.... Do you mean you can not set the
timeout value??


> And last thing, It seems that the device registers survive 
> system power cycle. Maybe I was just too fast and the caps powered
> the chip. I will investigate...
> 
> I hope you can understand my thought because I'm quite tired now.




Best Regards
Yuan Mu




=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.


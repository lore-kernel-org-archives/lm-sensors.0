From: anthonyp@lantronix.com (Anthony Petillo)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: I am developing a driver for MAX6900 (RTC chip)
Message-Id: <603BA0CFF3788E46A0DB0918D9AA9510943D01@sj580004wcom.int.lantronix.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <603BA0CFF3788E46A0DB0918D9AA9510943CFD@sj580004wcom.int.lantronix.com>
In-Reply-To: <603BA0CFF3788E46A0DB0918D9AA9510943CFD@sj580004wcom.int.lantronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank-you

As for trying the detect-script, I might not be able to try it because my mips platform does not have enough room in flash to hold perl. I may be able to use an nfs share. I will let you know.

(as for the "reserved" register, I don't see what harm it could have to use it as another way to confirm that the correct chip is present; if a problem shows up in the future, it can be changed)

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Monday, March 08, 2004 3:49 PM
To: Anthony Petillo
Cc: LM Sensors
Subject: Re: I am developing a driver for MAX6900 (RTC chip)


> just to let you know, its okay to put my name on the new drivers list:
> Anthony Petillo and can you please put me on the mailing list.
> 
> I will be developing the driver for Linux kernel version 2.4 only.

OK, I've added this information on our "New drivers" page.

I also added MAX6900 detection to our sensors-detect script. Could you
please give it a try and confirm it works for you?

(BTW, do you think that the "reserved" register at 0x97 could be used
for identification? According to the datasheet, it looks like a
read-only register that should always return 0x07, although it has a
write address too. Strange...)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

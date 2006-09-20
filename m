From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 20 Sep 2006 20:18:14 +0000
Subject: [lm-sensors] DME1737 specsheet dead end.
Message-Id: <20060920221814.5925c7ee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4503968B.8010703@sandeen.net>
In-Reply-To: <4503968B.8010703@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eric,

> FYI, DME1737 specsheet (a.k.a. Asus A8000) is apparently not available to mere 
> mortals... conversation follows:

I didn't know the SMSC DME1737 and the Asus A8000 were the same chip.
How did you find out?

> ---
> 
> REQUEST INFORMATION
> 
> Hi, I'm looking for programming information on
> the SMSC DME1737 SUPER I/O WITH TEMPERATURE chip.
> 
> I've found overview datasheets but no specific information.  Is such a document
> available?   I'd like to extend the sensor monitoring application used in Linux
> to fully support your chip.
> 
> Thanks!
> 
> -Eric
> 
> RESOLUTION INFORMATION
> 
> 07/25/2006 09:00 AM TWalter:
> 
> Eric,
> 
> Who is the end customer requesting the Linux support?
> 
> Our DME1737 Datasheet requires a NDA (Non Disclosure Agreement) with a major OEM
> to process through our legal department.   I can not send it out without their 
> approval.

This is sad news, and not very smart from SMSC. Hardware monitoring
isn't exactly a bleeding edge area, nothing really exciting is going
on. Without a datasheet we can't support their chip, all they'll get is
a bunch of angry users who will make sure to stay away from SMSC chips
in the future.

I've updated our device information page.

-- 
Jean Delvare


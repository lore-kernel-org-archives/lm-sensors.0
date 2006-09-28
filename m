From: Torsten.Richter@eads.com (Richter, Torsten, OPEE42)
Date: Thu, 28 Sep 2006 07:36:20 +0000
Subject: [lm-sensors] question regarding lm-sensors.org - LTC1760
Message-Id: <5E2B5E20-F745-4F63-9B39-C6830F15161C@mimectl>
List-Id: <lm-sensors.vger.kernel.org>
References: <451A1681.7090404@assembler.cz>
In-Reply-To: <451A1681.7090404@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you for your help.



>Von: mohan
>Betreff: Re: [lm-sensors] question regarding lm-sensors.org - >LTC1760
>

>Yes I have the driver which works ok.
>Since I am using this in a propietary embedded system, it may >not be appropriate for general use. 

I also have to use a embedded system. An AMD DBAu1200 is the platform I use.

>The big issue is bus arbitration. At present I simply ignore it.
>
>At present I simply read and control the registers of LTC1760
>and use the "smartbatt" module to read the battery info.

I found out, that I can speak with the LTC1760 just by open the /dev/i2c-0 device and then use the smbus commands from the i2c.h file (With the adresses given in the data sheet). When I start programming like this, I don't think that the result will be a driver for the lm-sensors.org. My way could be very hooked on the used board.

Torsten
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060928/9afc76b9/attachment.html 

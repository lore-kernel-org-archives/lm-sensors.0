From: riwright@vt.edu (Rick Wright)
Date: Tue, 20 Mar 2007 14:29:47 +0000
Subject: [lm-sensors] abituguru3 review
Message-Id: <45FFEFDB.4050505@vt.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703191428p764618c8q104258ee156fd300@mail.gmail.com>
In-Reply-To: <191fb4ca0703191428p764618c8q104258ee156fd300@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:

>Hans,
>
>Here's my review:
>
>  
>
>>This patch adds a new driver for the hardware monitoring features of the third
>>revision of the Abit uGuru chip, found on recent Abit motherboards. This is an
>>entirely different beast then the first and second revision (its again a
>>winbond microcontroller, but the "protocol" to talk to it and the bank
>>addresses are very different.
>>
>>Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>
>>--- linux-2.6.20-rc4-mm1/Documentation/hwmon/abituguru.uguru3	2007-01-18 13:45:20.000000000 +0100
>>+++ linux-2.6.20-rc4-mm1/Documentation/hwmon/abituguru	2007-01-18 16:15:24.000000000 +0100
>>@@ -2,7 +2,7 @@
>> ===========>>
>> Supported chips:
>>-  * Abit uGuru revision 1-3 (Hardware Monitor part only)
>>+  * Abit uGuru revision 1 & 2 (Hardware Monitor part only)
>>     Prefix: 'abituguru'
>>     Addresses scanned: ISA 0x0E0
>>     Datasheet: Not available, this driver is based on reverse engineering.
>>@@ -20,8 +20,8 @@
>> 	uGuru 2.1.0.0 ~ 2.1.2.8 (AS8, AV8, AA8, AG8, AA8XE, AX8)
>> 	uGuru 2.2.0.0 ~ 2.2.0.6 (AA8 Fatal1ty)
>> 	uGuru 2.3.0.0 ~ 2.3.0.9 (AN8)
>>-	uGuru 3.0.0.0 ~ 3.0.1.2 (AW8, AL8, NI8)
>>-	uGuru 4.xxxxx?          (AT8 32X) (2)
>>+	uGuru 3.0.0.0 ~ 3.0.x.x (AW8, AL8, NI8 SLI, AT8 32X, AN8 32X,
>>+				 AW9D-MAX) (2)
>>    
>>
Hans, I just want to add that the Abit Motherboard I successfully tested 
this driver on was the "AT8 Crossfire Edition" (don't have an actual 
part # handy, but it is probably officially "AT8").  This board is 
different than the AT8 32X  board, so I think my board should also be 
listed here as supported.

Thanks both to Hans & Jeurg for the teamwork that hopefully leads to 
getting both of these drivers included soon!


Regards,
Rick
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070320/1c961d99/attachment.html 

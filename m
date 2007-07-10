From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 10 Jul 2007 06:10:39 +0000
Subject: Re: [lm-sensors] Any questions you would like to ask the pc wizard
Message-Id: <469322DF.8030709@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4690AE3A.3090008@hhs.nl>
In-Reply-To: <4690AE3A.3090008@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sun, 08 Jul 2007 11:28:26 +0200, Hans de Goede wrote:
>> I've been contacted by Franck Delattre, the author of a windows utility called 
>> pc wizard, for permission to use my uguru3 code (and I've given him permission 
>> to use it).
>>
>> He has offered to answer any questions he can about things which are supported 
>> by PC wizard but not by lm-sensors. So if you have any questions send them my 
>> way and I'll forward them.
> 
> This is very good news. We had this kind of cooperation with Alex van
> Kaam when he was still working on MBM, and this proved to be very
> useful.
> 
> If Franck happens to have information on how to handle the ICH8 internal
> sensors (HECI controller), that would be interesting.
> 
> http://www.lm-sensors.org/ticket/2134
> 


Here is Franck's answer:

---

Hi Hans,

I unfortunately know little about HECI.
The ICH8 contains two thermal sensors, according to the DS, but nothing 
mentions if they can be accessed by software.
The thermal sensor on P/Q/G965 (and also P35) provides an interface through the 
MCHBAR (some control registers, and a status register).
This may not help you a lot, sorry about that. I'll try to get more 
information, and will keep you informed if I get something interesting.

Best regards,
Franck

---

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

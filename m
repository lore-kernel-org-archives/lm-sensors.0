From: Andre Przywara <andre.przywara@amd.com>
Date: Sun, 25 Sep 2011 21:34:21 +0000
Subject: Re: [lm-sensors] AMD Phenom II Family 16h
Message-Id: <4E7F9E5D.4000407@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201109232108.25627.pablow.1422@gmail.com>
In-Reply-To: <201109232108.25627.pablow.1422@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/24/2011 11:28 PM, Clemens Ladisch wrote:
> Jean Delvare wrote:
>> On Fri, 23 Sep 2011 20:50:22 -0700, Guenter Roeck wrote:
>>> On Fri, Sep 23, 2011 at 08:06:19PM -0400, Pablo Fabian Wagner Boian wrote:
>>>> I've got a question regarding AMD Phenom II Family 16h.
>>>
>>> ... the driver officially only supports up to family 15h as far
>>> as I can see. Did you patch it, or does it just work ?
>>
>> The driver supports PCI devices (north bridge) not CPU families. Just
>> as family 12h and 14h north bridges have the same PCI device ID, I can
>> only guess that family 15h and 16h north bridges have the same PCI
>> device ID. If this is confirmed, we can update the driver documentation
>> accordingly. Andre, Clemens, any comment on this?

In fact the northbridges are quite different, only the temperature 
reporting part has been kept the same. So for the purpose of this driver 
(and only in this case) we can handle the northbridges as if they were 
compatible. But in fact the PCI-IDs changed, so we have to list them 
(and add them if new CPUs are released). But yes, Llano and Brazos 
(Fam12h and Fam14h) share the same northbridge, hence the same PCI-ID.

Regards,
Andre.

>
> Phenom IIs are always Family 10h.
> I'd guess this is decimal/hex confusion and not a super-secret new CPU.

That is true. I await more of this confusion when Fam 15h (aka 
Bulldozer) hits the market, since people may mix it up with family 15 
(0Fh) aka K8 ;-)

Regards,
Andre.

-- 
Andre Przywara
AMD-Operating System Research Center (OSRC), Dresden, Germany
Tel: +49 351 448-3567-12
----to satisfy European Law for business letters:
Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach b. Muenchen
Geschaeftsfuehrer: Alberto Bozzo
Sitz: Dornach, Gemeinde Aschheim, Landkreis Muenchen
Registergericht Muenchen, HRB Nr. 43632


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

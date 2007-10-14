From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 14 Oct 2007 07:13:39 +0000
Subject: Re: [lm-sensors] Abituguru needs force=y
Message-Id: <4711C1A3.5080304@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <470DDE3C.1050209@hhs.nl>
In-Reply-To: <470DDE3C.1050209@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 11 Oct 2007 10:26:36 +0200, Hans de Goede wrote:
>> Graham Murray wrote:
>>> Hans de Goede <j.w.r.degoede@hhs.nl> writes:
>>>
>>>> Interesting, thanks for the notification. The version in 2.6.23 check
>>>> a few DMI strings to make sure its running on an Abit motherboard
>>>> before randomly bit banging some io-ports. So I guess your motherboard
>>>> has different DMI strings then most, can you please mail me the output
>>>> of the dmidecode command? Then I'll make sure this gets fixed in
>>>> 2.6.24.
>>> I think that the problem is that DMI does not work on my system. At boot
>>> I get the message "DMI not present or invalid" and running dmidecode
>>> confirms this. For the i386, there is no user option to disable DMI
>>> during kernel configuration.
>>>
>>> newton ~ # dmidecode
>>> # dmidecode 2.9
>>> # No SMBIOS nor DMI entry point found, sorry.
>>>
>> Hmm,
>>
>> Have you tried updating your BIOS?
> 
> Was there an answer to this question?
> 
Nope.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

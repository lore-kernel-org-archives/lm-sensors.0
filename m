From: Marco <jjletho67-ml@yahoo.it>
Date: Thu, 20 Jan 2011 16:37:21 +0000
Subject: Re: [lm-sensors] asus_atk0110 on a p6td deluxe
Message-Id: <867830.11535.qm@web28502.mail.ukl.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
In-Reply-To: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
i would like to now if there are any news about this old thread. Has the ability 
to read those variables been implemented ?

Thank you

Marco



----- Messaggio originale -----
Da: Hans de Goede <hdegoede@redhat.com>
A: Luca Tettamanti <kronos.it@gmail.com>
Cc: lm-sensors@lm-sensors.org
Inviato: Mer 28 luglio 2010, 11:32:16
Oggetto: Re: [lm-sensors] asus_atk0110 on a p6td deluxe

Hi,

On 07/27/2010 10:40 PM, Luca Tettamanti wrote:
> On Tue, Jul 27, 2010 at 2:45 PM, Hans de Goede<hdegoede@redhat.com>  wrote:
>> Hi,
>>
>> On 07/27/2010 01:03 PM, Luca Tettamanti wrote:
>>>
>>> On Mon, Jul 26, 2010 at 11:18 PM, Marco<jjletho67-ml@yahoo.it>    wrote:
>>>>
>>>> i'm attaching the DSDT file. If i well understood  you are able to look
>>>> inside
>>>> it...
>>>
>>> Ok, as expected the hwmon section does not contain additional entries.
>>>
>>> However, in GIT3 I see at least the following entries that are
>>> connected to the hwmon chip:
>>>
>>> "BCLK Frequency"
>>> "CPU Voltage" (another one, but for a different register)
>>> "CPU Ratio"
>>> "QPI/DRAM Core Volt"
>>> "DRAM Bus Voltage"
>>
>> Hmm, this sounds like its not hwmon, but voltage and clock
>> control!!
>
> Yes I know, but I don't plan to make them writable ;-)
>

Ok,

Note even when not writable we still need to think about
how to export them API wise as for example the voltages are
not voltage sensors, but rather voltage control, and IMHO
we should thus differentiate them from regular voltage sensors.

Regards,

Hans


> Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

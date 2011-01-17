From: Anish Patel <anish.mailing.list@gmail.com>
Date: Mon, 17 Jan 2011 22:26:36 +0000
Subject: Re: [lm-sensors] Sandy Bridge support?
Message-Id: <4D34C21C.3040206@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <0022152d6d71d9f528049a109a02@google.com>
In-Reply-To: <0022152d6d71d9f528049a109a02@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/17/11 16:54, Guenter Roeck wrote:
> On Mon, 2011-01-17 at 15:26 -0500, DarkNovaNick@gmail.com wrote:
>> I recently bought the new Intel Sandy Bridge processor, i5-2500k,
>> along with a Gigabyte GA-H67A-UD3H motherboard. I've used lm_sensors
>> in the past and am trying to get it to work with my new setup (on
>> Ubuntu 10.10 kernel 2.6.35-24). I downloaded the latest version of the
>> sensors-detect script from the website and it was not able to find any
>> sensors. Here is the output:
>>
>> ---------
>>
>> # sensors-detect revision 5901 (2011-01-14 17:11:54 +0100)
>> # System: Gigabyte Technology Co., Ltd. H67A-UD3H
>>
>> This program will help you determine which kernel modules you need
>> to load to use lm_sensors most effectively. It is generally safe
>> and recommended to accept the default answers to all questions,
>> unless you know what you're doing.
>>
>> Some south bridges, CPUs or memory controllers contain embedded
>> sensors.
>> Do you want to scan for them? This is totally safe. (YES/no):
>> Silicon Integrated Systems SIS5595... No
>> VIA VT82C686 Integrated Sensors... No
>> VIA VT8231 Integrated Sensors... No
>> AMD K8 thermal sensors... No
>> AMD Family 10h thermal sensors... No
>> AMD Family 11h thermal sensors... No
>> Intel Core family thermal sensor... No
>> Intel Atom thermal sensor... No
>> Intel AMB FB-DIMM thermal sensor... No
>> VIA C7 thermal sensor... No
>> VIA Nano thermal sensor... No
>>
>> Some Super I/O chips contain embedded sensors. We have to write to
>> standard I/O ports to probe them. This is usually safe.
>> Do you want to scan for Super I/O sensors? (YES/no):
>> Probing for Super-I/O at 0x2e/0x2f
>> Trying family `National Semiconductor'... No
>> Trying family `SMSC'... No
>> Trying family `VIA/Winbond/Nuvoton/Fintek'... No
>> Trying family `ITE'... Yes
>> Found unknown chip with ID 0x8728
>> (logical device 4 has address 0x290, could be sensors)
> The problem is more likely that the SuperIO chip used in your system is
> not supported. If so, your problem doesn't have anything to do with
> SandyBridge.
>
> Guenter
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
i think the more likely problem is that his kernel doesn't know about 
the sandy bridge thermal diode.
the coretemp module probably needs an update.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

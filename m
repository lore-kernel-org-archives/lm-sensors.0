From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 27 Sep 2010 07:08:50 +0000
Subject: Re: [lm-sensors] x86/hwmon: conditionalize coretemp's dependency on
Message-Id: <4CA05F220200007800018F81@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C8E18790200007800015AF7@vpn.id2.novell.com>
 <20100924185509.GA20155@ericsson.com>
In-Reply-To: <20100924185509.GA20155@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: r.marek@assembler.cz, fenghua.yu@intel.com, khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

>>> On 24.09.10 at 20:55, Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> On Mon, Sep 13, 2010 at 10:26:33AM -0000, Jan Beulich wrote:
>> PCI specific code is needed only when Atom CPUs are potentially
>> supported by the kernel.
>> 
>> Signed-off-by: Jan Beulich <jbeulich@novell.com>
>> Cc: Rudolf Marek <r.marek@assembler.cz>
>> 
>> ---
>> drivers/hwmon/Kconfig |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> 
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org 
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html 
>> Please read the FAQ at  http://www.tux.org/lkml/ 
>> 
>> --- linux-2.6.36-rc4/drivers/hwmon/Kconfig	2010-09-13 08:45:02.000000000 +0200
>> +++ 2.6.36-rc4-x86-coretemp-maybe-pci/drivers/hwmon/Kconfig	2010-09-10 
> 16:24:16.000000000 +0200
>> @@ -401,7 +401,8 @@ config SENSORS_GL520SM
>>  
>>  config SENSORS_CORETEMP
>>  	tristate "Intel Core/Core2/Atom temperature sensor"
>> -	depends on X86 && PCI && EXPERIMENTAL
>> +	depends on X86 && EXPERIMENTAL
>> +	depends on PCI || (!MATOM && !GENERIC_CPU && !X86_GENERIC)
>>  	help
>>  	  If you say yes here you get support for the temperature
>>  	  sensor inside your CPU. Most of the family 6 CPUs
> 
> Resending my reply to this one as well. Again, apologies if there is 
> duplication.
> 
> The coretemp code unconditionally calls pci functions, even if PCI is not 
> defined.
> I am concerned that this might cause problems. It might be better to stick 
> with
> the more generic dependency instead of trying to optimize too much.

pci.h takes care to define stub inline functions for the !CONFIG_PCI
case. It seemed largely odd for a driver like this to depend on PCI
at all, and hence I think it is more transparent to make the needs
explicit.

Jan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

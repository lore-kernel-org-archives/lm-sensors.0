From: Robert Hancock <hancockrwd@gmail.com>
Date: Fri, 29 Jun 2012 05:35:47 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <4FED3EB3.4000602@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com> <20120627171505.GB12712@roeck-us.net> <4FEB90A8.8050901@googlemail.com> <20120628014548.GA15994@srcf.ucam.org> <4FEC3CDF.7050901@googlemail.com> <20120628144035.36ac75a0@endymion.delvare> <4FEC53DD.8050403@googlemail.com> <20120628152754.2ab6697a@endymion.delvare>
In-Reply-To: <20120628152754.2ab6697a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Michael Zintakis <michael.zintakis@googlemail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org

On 06/28/2012 07:27 AM, Jean Delvare wrote:
> On Thu, 28 Jun 2012 13:53:49 +0100, Michael Zintakis wrote:
>> In the meantime, considering the specifics of my particular case and the
>> memory regions involved (again, I think they are 0x290-0x297, a total of
>> 8 bytes in length according to the driver, though if someone more
>> knowledgeable in the f71882fg driver specifics know otherwise, please
>> feel free to correct this if that assumption is wrong), would it be
>> possible to manually hack into the ACPI code and forcefully prevent it
>> from claiming those memory regions and not get involved in "managing"
>> that particular device?
>
> Not that I know of. That would rather be a question for the ACPI
> people, but I'm afraid the answer is that ACPI is supposed to be the
> best thing since sliced bread and you should just let it do its stuff
> and not ask questions :( I too would love to be able to tell ACPI to
> let my hardware monitoring chip (and/or SMBus controller) alone.

The ACPI conflict gets triggered when the BIOS AML code creates an 
operation region to access the same device that the driver is trying to 
bind to. There apparently are some BIOSes that do this and yet don't use 
it to actually access the hardware monitoring chip. In this case there 
is no true conflict and the acpi_enforce_resources=lax option is safe to 
use. Unfortunately there's really no way for the kernel to tell whether 
or not this is the case.

In this case, however, where the BIOS does in fact expose an ACPI 
thermal zone and relies on AML code to perform fan control, etc. then it 
seems quite likely that it's not safe to access the same hardware 
monitoring controller while AML code may be doing so at the same time. 
The only way I can see that you could make ACPI "leave the hardware 
monitoring chip alone" is to either have the kernel block its accesses 
(quite likely breaking all fan/temperature control) or disable ACPI 
entirely (in this case the BIOS likely either leaves the fan control in 
"run at max speed always" mode or uses SMIs to gain control where needed 
to adjust fan speeds, which causes the same concurrent access problem).

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

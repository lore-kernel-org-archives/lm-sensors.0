From: alexey.y.starikovskiy@linux.intel.com (Alexey Starikovskiy)
Date: Fri, 09 Mar 2007 17:35:09 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <45F19ACD.6030906@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070302220454.a0c66d04.khali@linux-fr.org>	<B28E9812BAF6E2498B7EC5C427F293A402021B07@orsmsx415.amr.corp.intel.com>	<20070309071855.GA5148@ucw.cz>	<20070309112420.42420cf2.khali@linux-fr.org>	<45F13965.2030709@linux.intel.com> <20070309182355.d1845962.khali@linux-fr.org>
In-Reply-To: <20070309182355.d1845962.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Jean Delvare wrote:
> Hi Alexey,
>
> On Fri, 09 Mar 2007 13:39:33 +0300, Alexey Starikovskiy wrote:
>   
>> Jean Delvare wrote:
>>     
>>> I can only second Pavel's wish here. This would be highly convenient
>>> for OS developers to at least know which resources are accessed by AML
>>> and SMM. Without this information, we can never be sure that OS-level
>>> code won't conflict with ACPI or SMM.
>>>       
>> BIOS vendors are not required to support latest and greatest ACPI spec. 
>> So even if some future spec version
>> will include this ports description, we will still have majority of 
>> hardware not exporting it...
>>     
>
> Your reasoning is amazing. So we should refrain from proposing any
> improvement which we aren't certain 100% of the systems will support
> tomorrow? Then let's all stay away from our keyboards forever, as the
> evolution of computer technology is based on exactly that -
> improvements which not all systems implement.
>
> It's friday evening, let's have some more for fun. With a similar
> logic, ten years ago we'd have come up with the following conclusions:
>
> The majority of computers have a single CPU, there is no point in
> adding SMP support to Linux.
>
> Let's not add a new instruction set in our next CPU family. The
> majority of systems will not implement it so it will be useless anyway.
>
> There's no point in supporting PnP in Linux, there are a majority of
> legacy ISA cards out there which do not support it anyway!
>
> See my point? Just because not every hardware out there supports a
> given standard doesn't make that standard necessarily useless.
>
> Just make the next version of ACPI better than the previous one (not
> necessarily a challenge) and everyone will embrace it.
>
>   
You get me wrong, I'm not against the proposal, so keep your breath.
I'm just saying that you get old waiting for BIOS vendors to export this 
info, even if it's in spec.

Regards,
Alex.


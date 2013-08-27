From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 27 Aug 2013 13:37:27 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement of __initdata
Message-Id: <521CAB97.6000303@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/27/2013 04:30 AM, Russell King - ARM Linux wrote:
> On Tue, Aug 27, 2013 at 01:14:58PM +0200, Jean Delvare wrote:
>> On Mon, 26 Aug 2013 15:48:43 -0700, Guenter Roeck wrote:
>>> On Mon, Aug 26, 2013 at 10:47:34PM +0200, Jean Delvare wrote:
>>>> On Wed,  7 Aug 2013 15:17:13 +0530, Sachin Kamat wrote:
>>>>> __initdata should be placed between the variable name and equal
>>>>> sign for the variable to be placed in the intended section.
>>>>
>>>> Really? With gcc 4.7.2 of openSUSE 12.3/x86-64, I see no difference
>>>> with and without this change. pm_dmi_table is in section .init.data in
>>>> both cases. So when/where/how does it actually matter?
>>>>
>>>> I see that there are hundreds of other occurrences of this in the
>>>> kernel tree, so I admit I have a hard time believing it is actually
>>>> wrong, and I would appreciate extra explanations.
>>>
>>> There is this:
>>>
>>> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/258149
>>>
>>> Maybe target and/or compiler version specific ?
>>
>> Russell, can you explain? Is this an old gcc misbehavior which has been
>> fixed meanwhile, or...?
>>
>> Me, I can't see how a section attribute could apply to a variable type
>> in the first place, so I'd expect gcc to either transparently apply it
>> to the variable instead (which it apparently does for me) or emit a
>> warning.
>>
>> OTOH if the problem is real then a check for it should be added to
>> checkpatch.pl because I don't think a lot of people know about it. A
>> quick grep suggests that 29% of the use cases (1260 occurrences) have
>> it wrong.
>
> If it's gcc misbehaviour, then it's documented gcc misbehaviour, because
> my description in the above link comes from the GCC info pages.  See:
>
> C Extensions -> Attribute Syntax
>
> This is because attributes can be either function attributes, variable
> attributes or type attributes.  Which kind they are depends on where
> they are placed.
>
> When they are placed immediately after 'struct', 'enum' or 'union', or
> immediately after the closing brace of such a declaration, they are a
> type attribute.  It may be possible to argue that a section-specifying
> attribute should be allowable as part of the type, but that doesn't
> appear to be the case (and it doesn't error out either.)
>
> The version online at: http://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
> looks very similar to the version I've been reading for my gcc version,
> so I assume nothing has changed in this regard.
>

If I understand the document correctly,
	static struct dmi_system_id __initdata pm_dmi_table[] = {
applies the attribute to the type used to declare the variable,
thus the variable will be of type 'struct dmi_system_id __initdata'
and be placed in initdata.

	static struct dmi_system_id pm_dmi_table[] __initdata = {
applies the attribute to the variable, with the same result.

So I wonder - is this a real problem ? The result should be the same
in either case.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

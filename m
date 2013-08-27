From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 27 Aug 2013 14:07:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement	of __initdata
Message-Id: <20130827140728.GI6617@n2100.arm.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 27, 2013 at 06:37:27AM -0700, Guenter Roeck wrote:
> On 08/27/2013 04:30 AM, Russell King - ARM Linux wrote:
>> If it's gcc misbehaviour, then it's documented gcc misbehaviour, because
>> my description in the above link comes from the GCC info pages.  See:
>>
>> C Extensions -> Attribute Syntax
>>
>> This is because attributes can be either function attributes, variable
>> attributes or type attributes.  Which kind they are depends on where
>> they are placed.
>>
>> When they are placed immediately after 'struct', 'enum' or 'union', or
>> immediately after the closing brace of such a declaration, they are a
>> type attribute.  It may be possible to argue that a section-specifying
>> attribute should be allowable as part of the type, but that doesn't
>> appear to be the case (and it doesn't error out either.)
>>
>> The version online at: http://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
>> looks very similar to the version I've been reading for my gcc version,
>> so I assume nothing has changed in this regard.
>>
>
> If I understand the document correctly,
> 	static struct dmi_system_id __initdata pm_dmi_table[] = {
> applies the attribute to the type used to declare the variable,
> thus the variable will be of type 'struct dmi_system_id __initdata'
> and be placed in initdata.
>
> 	static struct dmi_system_id pm_dmi_table[] __initdata = {
> applies the attribute to the variable, with the same result.
>
> So I wonder - is this a real problem ? The result should be the same
> in either case.

Well, there's an easy way to find out.  Try it with GCC - build it to
assembly and see what section it gets placed into.

Here's the test and results I just ran:

struct foo { unsigned blah; };
struct foo foo1[1] __attribute__((__section__(".foo"))) = { 1 };
struct foo foo_normal1 = { 1 };
struct __attribute__((__section__(".foo"))) foo foo2[1] = { 2 };
struct foo foo_normal2 = { 2 };
struct foo __attribute__((__section__(".foo"))) foo3[1] = { 3 };
struct foo foo_normal3 = { 3 };
__attribute__((__section__(".foo"))) struct foo foo4[1] = { 4 };

	.file	"tt.c"
.globl foo1
	.section	.foo,"aw",@progbits
	.align 4
	.type	foo1, @object
	.size	foo1, 4
foo1:
	.long	1
.globl foo_normal1
	.data
	.align 4
	.type	foo_normal1, @object
	.size	foo_normal1, 4
foo_normal1:
	.long	1
.globl foo2
	.align 4
	.type	foo2, @object
	.size	foo2, 4
foo2:
	.long	2
.globl foo_normal2
	.align 4
	.type	foo_normal2, @object
	.size	foo_normal2, 4
foo_normal2:
	.long	2
.globl foo3
	.section	.foo
	.align 4
	.type	foo3, @object
	.size	foo3, 4
foo3:
	.long	3
.globl foo_normal3
	.data
	.align 4
	.type	foo_normal3, @object
	.size	foo_normal3, 4
foo_normal3:
	.long	3
.globl foo4
	.section	.foo
	.align 4
	.type	foo4, @object
	.size	foo4, 4
foo4:
	.long	4
	.ident	"GCC: (GNU) 4.5.1 20100924 (Red Hat 4.5.1-4)"
	.section	.note.GNU-stack,"",@progbits

Out of those, the only ones which ends up in section ".foo" are foo1, foo3
foo4.  foo2 doesn't, which is the section specifier as a type attribute.
This is entirely inline with what the GCC docs say IMHO.

However, given the attributes are sensitive to where they're placed, isn't
it better to have one convention about their placement and use that as a
stylistic requirement, so that everyone understands where they should be
placed without having to read that murky documentation?

From what I remember of the early days of adding section attributes for
init section marking, the convention always was to add them after the
variable identifier, and that's the convension I've always used - and I've
yet to be caught out by it.  Those who place it elsewhere seem to end up
with janitorial patches moving it to the end or end up putting it after
'struct' and not realising that it doesn't have the desired effect.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

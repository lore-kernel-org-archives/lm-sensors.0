From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Aug 2013 13:57:53 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement of __initdata
Message-Id: <20130827155753.628e04ab@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter, Russell,

On Tue, 27 Aug 2013 06:37:27 -0700, Guenter Roeck wrote:
> On 08/27/2013 04:30 AM, Russell King - ARM Linux wrote:
> > On Tue, Aug 27, 2013 at 01:14:58PM +0200, Jean Delvare wrote:
> >> Russell, can you explain? Is this an old gcc misbehavior which has been
> >> fixed meanwhile, or...?
> >>
> >> Me, I can't see how a section attribute could apply to a variable type
> >> in the first place, so I'd expect gcc to either transparently apply it
> >> to the variable instead (which it apparently does for me) or emit a
> >> warning.
> >>
> >> OTOH if the problem is real then a check for it should be added to
> >> checkpatch.pl because I don't think a lot of people know about it. A
> >> quick grep suggests that 29% of the use cases (1260 occurrences) have
> >> it wrong.
> >
> > If it's gcc misbehaviour, then it's documented gcc misbehaviour, because
> > my description in the above link comes from the GCC info pages.  See:
> >
> > C Extensions -> Attribute Syntax
> >
> > This is because attributes can be either function attributes, variable
> > attributes or type attributes.  Which kind they are depends on where
> > they are placed.
> >
> > When they are placed immediately after 'struct', 'enum' or 'union', or
> > immediately after the closing brace of such a declaration, they are a
> > type attribute.  It may be possible to argue that a section-specifying
> > attribute should be allowable as part of the type, but that doesn't
> > appear to be the case (and it doesn't error out either.)
> >
> > The version online at: http://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
> > looks very similar to the version I've been reading for my gcc version,
> > so I assume nothing has changed in this regard.
> >
> 
> If I understand the document correctly,
> 	static struct dmi_system_id __initdata pm_dmi_table[] = {
> applies the attribute to the type used to declare the variable,
> thus the variable will be of type 'struct dmi_system_id __initdata'
> and be placed in initdata.
> 
> 	static struct dmi_system_id pm_dmi_table[] __initdata = {
> applies the attribute to the variable, with the same result.

Not even sure, as
http://gcc.gnu.org/onlinedocs/gcc/Type-Attributes.html#Type-Attributes
doesn't list "section" as a valid attribute for types.

> So I wonder - is this a real problem ? The result should be the same
> in either case.

I think that what applies here is this little note at the end of the
"Attribute Syntax" documentation:

"If an attribute that only applies to declarations is applied to the
type of a declaration, it will be treated as applying to that
declaration."

I believe this is exactly what I'm seeing in my tests.

Also note that the fix Sachin sent for acpi_power_meter is slightly
different from what Russell complained about originally. Russell
complained about:

struct __initdata foo bar;

While acpi_power_meter uses:

struct foo __initdata bar;

The former does indeed NOT work in my tests, so Russell was right
complaining. The good news is that there are only a few dozen
occurrences of this in the kernel tree.

The later OTOH works fine in my tests so I see no reason to change it -
unless someone can find a gcc version and platform combination where it
does not work. Hope this clarifies the whole situation...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

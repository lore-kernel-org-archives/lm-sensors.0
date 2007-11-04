From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 04 Nov 2007 13:21:50 +0000
Subject: Re: [lm-sensors] PATCH:
Message-Id: <472DC76E.2070200@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 02 Nov 2007 20:41:19 +0100, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> On Fri, 02 Nov 2007 08:35:53 +0100, Hans de Goede wrote:
>>>> Good work Jean, yes that should do the job, I stared myself blind at adding a 
>>>> clean way to store the data for later retrieval to the existing __init parser, 
>>>> your way indeed will work and is much more generic.
>>>>
>>>> I'll compile a kernel with the dmi_scan.c and dmi.h parts patched in and then 
>>>> start working on integrating this into fschmd.c
>>> Here's an updated version of my patch, with no code duplication this
>>> time. This should be easier to get this accepted upstream. To make the
>>> code even smaller, dmi_table() could be merged into dmi_present() but
>>> that's about it.
>> Looks good, I found inconsistency though, in essence the dmi_table() and 
>> dmi_walk() are the same, (except for dmi_ioremap versus ioremap ofcourse) but 
>> for one you just use the base, len and number of items stored in global 
>> variables, while for the other you pass those same global variables through 
>> parameters, for consistency sake I think you should to both the same.
> 
> That's an asymmetry rather than an inconsistency. There are two reasons
> for it, firstly I avoid using global variables when I don't have to,
> secondly this happened to make the patch smaller. It is of course
> possible to use the global variables dmi_base, dmi_len and dmi_num in
> dmi_table() rather than passing them as parameters; doing so makes the
> binary code slightly smaller. I'm attaching a version of the patch that
> does this, together with function renames to make it look better. If
> you like this one, I could send it upstream for review and comments.
> 

I like this one, you may want to wait with sending it upstream till I've 
actually tested if it solves the problem at hand though.

I'm currently rather busy at work, so this may take a week or so.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

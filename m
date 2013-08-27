From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Aug 2013 11:14:58 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement of __initdata
Message-Id: <20130827131458.4e846d4f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 Aug 2013 15:48:43 -0700, Guenter Roeck wrote:
> On Mon, Aug 26, 2013 at 10:47:34PM +0200, Jean Delvare wrote:
> > On Wed,  7 Aug 2013 15:17:13 +0530, Sachin Kamat wrote:
> > > __initdata should be placed between the variable name and equal
> > > sign for the variable to be placed in the intended section.
> > 
> > Really? With gcc 4.7.2 of openSUSE 12.3/x86-64, I see no difference
> > with and without this change. pm_dmi_table is in section .init.data in
> > both cases. So when/where/how does it actually matter?
> > 
> > I see that there are hundreds of other occurrences of this in the
> > kernel tree, so I admit I have a hard time believing it is actually
> > wrong, and I would appreciate extra explanations.
> 
> There is this:
> 
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/258149
> 
> Maybe target and/or compiler version specific ?

Russell, can you explain? Is this an old gcc misbehavior which has been
fixed meanwhile, or...?

Me, I can't see how a section attribute could apply to a variable type
in the first place, so I'd expect gcc to either transparently apply it
to the variable instead (which it apparently does for me) or emit a
warning.

OTOH if the problem is real then a check for it should be added to
checkpatch.pl because I don't think a lot of people know about it. A
quick grep suggests that 29% of the use cases (1260 occurrences) have
it wrong.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

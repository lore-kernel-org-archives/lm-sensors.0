From: "Andrew Voznytsa" <andrew.voznytsa@gmail.com>
Date: Wed, 06 Feb 2008 14:20:55 +0000
Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 (was:
Message-Id: <000d01c868cb$7e380730$0204a8c0@IT>
List-Id: <lm-sensors.vger.kernel.org>
References: <004e01c856bc$6f975c10$0204a8c0@IT>
In-Reply-To: <004e01c856bc$6f975c10$0204a8c0@IT>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> 
> Hi Andrew,
> 
> 
> On Feb 5, 2008 4:20 AM, Andrew Voznytsa <andrew.voznytsa@gmail.com> wrote:
> > Hi Juerg,
> >
> > In short - it works!
> 
> Very good, thanks for testing.
> 
> 
> > Relevant outputs are below. Just a few questions -
> > would you recommend to use this code in production system (as for me
> looked
> > like simplified version of previous driver, looks like clean and nice,
> but
> > is it stable enough)?
> 
> The dme1737 driver is fairly new so it probably hasn't gone through a
> lot of user testing. It's likely that there are bugs. However, if you
> don't do any fancy things like setting temp limits or programming the
> fan controller, the driver will *not* write to the chip but only read
> registers and export their values. If the HW is not broken (i.e., it's
> always safe to read registers) and there is no interference with other
> SW accessing the same chip (like ACPI) that could cause problems, it
> should be safe to use it.
> 
> 
> > Perhaps stupid question but is there any kind of
> > 'WHQL' for linux kernel development?
> 
> Err, no. You just did all the QA required :-) I'll submit a patch in
> the next couple of days which needs to be reviewed by a fellow driver
> author/maintainer and then it's ready for inclusion in the mainline
> kernel. That's all it takes.
> Feel free to put the driver through some stress testing and report any
> issue you find.

So ok - I'll setup some monitoring and see how driver works. Many thanks for
this feature!

Best regards,
Andrew Voznytsa


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

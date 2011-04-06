From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 07:18:37 +0000
Subject: Re: [lm-sensors]
Message-Id: <20110406071837.GA23562@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 06, 2011 at 02:52:03AM -0400, R, Durgadoss wrote:
> Hi Guenter,
> 
> Thanks for a detailed review and intuitive comments.
> 
> > > From: Durgadoss R <durgadoss.r@intel.com>
> > >
> > > Date: Thu, 3 Mar 2011 02:37:40 +0530
> > > Subject: [PATCH:hwmon:v4:Resend]Merging_pkgtemp_with_coretemp
> > >
> > > This patch merges the pkgtemp driver with the coretemp driver.
> > > This merged driver creates one hwmon device per physical CPU i.e
> > > per Physical Package. Also, the sysfs interfaces per core are created
> > > as each core comes online and removed when it goes offline.
> > >
> > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > >
> >
> > After browsing through the code, I concluded that dynamic addition and removal
> > of CPUs likely won't work.  So I did a quick test.
> >
> > echo 0 >/sys/devices/system/cpu/cpu2/online
> > sensors
> >
> > Result was as suspected:
> >
> > [   84.518158] IP: [<ffffffffa00332a1>] show_label+0x21/0x70 [coretemp]
> > [   84.525604] PGD 42b9e0067 PUD 42cc0a067 PMD 0
> > [   84.530958] Oops: 0000 [#1] SMP
> > [   84.534870] last sysfs file: /sys/devices/platform/coretemp.0/temp4_label
> > [   84.542743] CPU 4
> > ...
> >
> > Oh well. I am quite sure I mentioned it before - _please_ test your code.
> > I am not your test group (and maybe you start to understand why it takes
> > so long to review your code).
> >
> 
> I did test it on Corei5 and SNB. Anyway, next time when I submit this patch,
> I shall attach the dmesg logs.
> 
Yes, but obviously you did not try adding/removing CPU cores....

[ ... ]

> > > +       u8 crit_alarm;
> >
> > crit_alarm is only written to, thus unnecessary.
> >
> > [ question, though, is why you keep reading it. Is it expected to change ? ]
> 
> When the temp1_input goes above temp1_crit, this crit_alarm is set to 1.
> When the temp1_input falls below temp1_crit, this crit_alarm is reset to 0.

Sure, but it is still a write-only variable, so what is the point ?

> As you mentioned below, I don't need this variable. I can just read and display.
> 

Exactly.

> >
> > > +       u8 max_alarm;
> >
> > max_alarm is not used anywhere, thus unnecessary.
> 
> We need this when we add the threshold(max and max_hyst) support also.
> Hence I added.
> 
In this case, you can add the variable when you need it. No need to do it now.

[ ... ]

> > > +               if (err) {
> > > +                       dev_warn(dev,
> > > +                       "Unable to read IA32_TEMPERATURE_TARGET MSR\n");
> > > +
> > Extra blank line
> >
> > > +               } else {
> > > +                       tdata->ttarget = tdata->tjmax -
> > > +                                       (((eax >> 8) & 0xff) * 1000);
> > > +               }
> >
> > { } are unnecessary.
> 
> In one of the previous patches, I had a single statement split into two lines,
> Without Braces. And I got comment asking me to add braces to increase readability.
> With that in mind, I added braces.
> Shall remove if it is Ok to do so ;-)
> 
Just keep it. Maybe it is better since those are multi-line statements.

> >
> > If you can not read ttarget, you still create tempX_max and display 0.
> > If ttarget is not supported, the attribute should not be created in the first
> > place.
> > The old code did this; any special reason for removing it ?
> 
> Earlier when I tried the "Adding Threshold Support to Coretemp.patch",
> We discussed that temp1_max will have the Threshold1 value if ttarget is not supported.
> When we have the Threshold patch all _max things will be fixed.
> 
> But if you say that will not work or not the right way to do, I can change
> the code accordingly.
> 
At least add a comment indicating that this will be fixed in a subsequent patch.

> > need 17 entries in core_data[], but there are only 16).
> 
> I missed it..Thanks for pointing it out..
> 
> >
> > Even better would be to come up with a dynamic scheme which does not depend on
> > the number
> > of cores.
> 
> Thought through this..But the way would be to use a ** and do dynamic mem allocation.
> Again, My opinion is that it will make the code complex.
> But, if you are Ok with this approach, I can implement this way.
> 
I am fine with the static allocation. Just make sure you don't exceed the limits.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

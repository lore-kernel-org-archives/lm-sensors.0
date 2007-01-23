From: rsashok@yahoo.com (Sasha Raykhman)
Date: Tue, 23 Jan 2007 00:51:24 +0000
Subject: [lm-sensors] question about vt1211
Message-Id: <263055.36385.qm@web35408.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0701190725j2620de3dvd521e23c690e72e@mail.gmail.com>
In-Reply-To: <191fb4ca0701190725j2620de3dvd521e23c690e72e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

I need some help in explaining how to install 2.10.2 package.  

The problem I have is that I am compiling kernel on my host computer for a different target board. Installation instructions and make file presented in the package will install necessary files on the host, but not in my source tree which I need to compile for the target .  Is there a way to solve the problem?

Thanks.

-- sasha


Juerg Haefliger <juergh at gmail.com> wrote: OK, should have read the whole thread before answering :-)

Here's the deal: Starting with kernel 2.6.19, the vt1211 driver is now
part of the kernel and there is no need to use Lars Ekman's patch
anymore. The new driver is based on Lars' driver but contains some
significant changes that render previous sensors.conf files unusable.
So if you upgrade to 2.6.19 and use that driver, you also have to have
a fairly recent version of the lm-sensors package (I believe 2.10.1 or
newer). The lm-sensors package contains a sensors.conf file that has a
vt1211 section that is compatible with the new 2.6.19 vt1211 driver.
It might need tweaking for your particular motherboard since I only
had a M10000 for testing.

So I strongly suggest that you upgrade to 2.6.19. I can't provide
support for Lars Ekman's patch.

...juerg


On 1/19/07, Michelle Dupuis  wrote:
>
>
> It looks like your formulas are way off....here are mine (for a VIA PD1000
> mobo).  I adjusted all my formulas based on BIOS output.
>
> Strangely CPU temp was ok in 2.6.17 and then in 2.6.18 went way off.  Does
> anyone know if the code changed requiring a new formula? Or is this a bug
>
> ----------------------
>
>
> chip "vt1211-*" "vt8231-*"
> # set uch1-2 to temp mode, uch3-5 to voltage mode
> #
> set config 12
> ignore in0
> ignore in1
> ignore temp2
> ignore temp4
> ignore temp5
> ignore temp6
> ignore temp7
>
> label in2 "VCore"
> label in3 "+5V"
> label in4 "+12V"
> label in5 "+3.3V"
>
> label fan1 "CPU fan"
> label fan2 "Exhst fan"
>
> label temp3 "CPU Temp"
> # These values based on PD10000: BIOS vs Linux sensors output
> compute in2 ((@ * 100) - 3) / (1.01235019909759 * 95.8), (@ *
> 1.01235019909759 * 0.958) + .03
> compute in3 ((@ * 100) - 3) / (0.37571355840891 * 95.8), (@ *
> 0.37571355840891 * 0.958) + .03
> compute in4 ((@ * 100) - 3) / (0.175517199295339 * 95.8), (@ *
> 0.175517199295339 * 0.958) + .03
> compute in5 ((@ * 100) - 3) / (0.630187418108534 * 95.8), (@ *
> 0.630187418108534 * 0.958) + .03
>
> set vrm 9.1
> # Allow lower min voltage for CPU Scaling
> set in2_min vid * 0.91 / 1.275862068
> set in2_max vid * 1.03 / 1.275862068
> set in3_min 5.0 * 0.95
> set in3_max 5.0 * 1.05
> set in4_min 12.0 * 0.90
> set in4_max 12.0 * 1.10
> set in5_min 3.3 * 0.95
> set in5_max 3.3 * 1.05
> compute temp3 (@*@*0.0046)-(@*0.088)-0.748, (@*0.9686)+65
>
> set temp3_hyst 60
> set temp3_over 65
>
> set fan1_min 3000
> set fan2_min 3000
>
>
>
>  ________________________________
>  From: Sasha Raykhman [mailto:rsashok at yahoo.com]
> Sent: Friday, January 19, 2007 5:19 PM
> To: Michelle Dupuis
> Cc: 'LM Sensors'; 'Juerg Haefliger'
> Subject: RE: [lm-sensors] question about vt1211
>
>
>
> Hi Michelle,
>
> I run 2.6.17 and installed patch I found on:
>
>  http://hem.bredband.net/ekmlar/vt1211-2.6.17.patch.txt
>
> My 'sensors' command output shows
>
> vt1211-isa-ec00
> Adapter: ISA adapter
> VCore1:    +4.42 V  (min =  +4.42 V, max =  +4.42 V)   ALARM
> +5V:       +6.31 V  (min =  +6.31 V, max =  +6.31 V)   ALARM
> +12V:     +15.00 V  (min = +15.00 V, max = +15.00 V)   ALARM
> +3.3V:     +4.18 V  (min =  +4.18 V, max =  +4.18 V)   ALARM
> fan1:        0 RPM  (min =    0 RPM, div = 8)          ALARM
> fan2:        0 RPM  (min =    0 RPM, div = 8)          ALARM
> ERROR: Can't get TEMP2 data!
> Proc Temp:+196.9 C  (high =  +196 C, hyst =  +196 C)   ALARM
> ERROR: Can't get TEMP4 data!
> ERROR: Can't get TEMP5 data!
> ERROR: Can't get TEMP6 data!
> ERROR: Can't get TEMP7 data!
> vid:       +0.00 V
>
> Can't make sense out of it!  There is /etc/sensors.conf file for vt1211
> setting, should I change anything there? Could you mail me your's to diff
> them?
>
> Due to many reasons beyond my control, I can't easily switch to 2.6.19
> kernel - I need to deal with 2.6.17 for now.
>
>
> Michelle Dupuis  wrote:
> On the same topic...(this answer may address your question too)
>
> I just upgraded my kernel from from 2.6.17 to 2.6.18, and my old vt1211.c
> broke. Although it compiles and runs, my cpu temp is now stuck at 68'C
> (normally runs half that). Under 2.6.17 it showed 35'C approx.
>
> Is there a newer vt1211 I can download somewhere?
>
> Thanks,
> Michelle
>
> -----Original Message-----
> From: lm-sensors-bounces at lm-sensors.org
> [mailto:lm-sensors-bounces at lm-sensors.org] On Behalf Of
> Juerg Haefliger
> Sent: Friday, January 19, 2007 10:25 AM
> To: Sasha Raykhman
> Cc: LM Sensors
> Subject: Re: [lm-sensors] question about vt1211
>
> Hi Sasha,
>
> For future questions, please cc the lm-sensors mailing list since other
> people might be interested as well.
>
> > I compiled the driver and successfully installed the module on my
> > distribution (TimeSys 2.6.17) . I read the document I found in
> > 2.6.19, but it didn't give me the idea on how to call driver functions
> > from user level application.
>
> I'm not familiar with TimeSys but from the name I'm assuming your're running
> a 2.6.17 kernel. The official vt1211 driver is not part of this kernel, it
> got added later with 2.6.19. Are you using Lars Ekmans' driver? If so, you
> should switch to 2.6.19 or later and use the official vt1211 driver that
> comes with the kernel.
>
> Like all hwmon drivers, the vt1211 driver creates a bunch of sysfs files
> which are used to exchange data between the driver and user-space processes.
> After loading the official driver, check /sys/class/hwmon/vt1211. It
> contains a bunch of files that you can access using regular read() and
> write() file operations to retrieve data from the driver (like temps and fan
> RPMs) or write data to the driver (like thermal thresholds).
>
> Please check Documentation/hwmon/sysfs-interface and vt1211
> for an
> explanation of how to interpret the various files and their content.
>
> The standard way is to use a tool called 'sensors' which is part of the
> lm-sensors package. It reads these files, manipulates the data according to
> some rules specified in /etc/sensors.conf and displays them. Check it out...
>
>
> > VIA Web site has utility VIA_SystemHealth, but they don't provide
> > source code as a reference for developers. Could you please give me
> > some idea on how to find API to the driver.
>
> VIA's tool doesn't work with the 2.6.19 vt1211 driver, it is tailored toward
> the old unofficial driver.
>
> ...juerg
>
>
> > Thanks for the help.
> >
> > -- sasha
> >
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>
>
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070122/26680f88/attachment.html 

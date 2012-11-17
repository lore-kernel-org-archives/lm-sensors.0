From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Sat, 17 Nov 2012 16:13:36 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <201211171613.qAHGDbjJ012827@mx3.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Luca Tettamanti [mailto:kronos.it@gmail.com]
> Sent: Saturday, November 17, 2012 10:10 AM
> To: Leslie Rhorer
> Cc: Jean Delvare; LM Sensors
> Subject: Re: [lm-sensors] Getting alarms using lm-sensors
> 
> On Sat, Nov 17, 2012 at 5:01 PM, Leslie Rhorer <lrhorer@mygrande.net>
> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Luca Tettamanti [mailto:kronos.it@gmail.com]
> >> Sent: Saturday, November 17, 2012 9:51 AM
> >> To: Leslie Rhorer
> >> Cc: Jean Delvare; LM Sensors
> >> Subject: Re: [lm-sensors] Getting alarms using lm-sensors
> >>
> >> > indeed, if so, since the text inside the BIOS utility is quite
> >> different.
> >>
> >> You can try loading the module forcing the use of a different ACPI
> >> interface:
> >> rmmod asus_atk0110
> >> modprobe asus_atk0110 new_if=1
> >
> > No, that didn't work.  Loading the module with the new_if=1 parm issues
> an
> > error:
> >
> > FATAL: Error inserting asus_atk0110
> > (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/asus_atk0110.ko):
> Unknown
> > symbol in module, or unknown parameter (see dmesg)
> >
> > And from dmesg:
> >
> > [25982.929792] asus_atk0110: Unknown parameter `new_if'
> 
> What kernel are you using?
> 
> L

2.6.32-5-amd64



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 14 Mar 2012 15:57:16 +0000
Subject: Re: [lm-sensors] ERROR: could not insert 'w83627ehf': Device or resource busy
Message-Id: <1331740636.32717.33.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F60A0AA.2050107@gmail.com>
In-Reply-To: <4F60A0AA.2050107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-03-14 at 11:32 -0400, David Kremer wrote:
> On 14/03/2012 16:23, Guenter Roeck wrote:
> > On Wed, 2012-03-14 at 10:23 -0400, David Kremer wrote:
> >> On 14/03/2012 14:55, Guenter Roeck wrote:
> >>> Most likely
> >>>
> >>> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
> >>>
> >> Thank you guenter.
> >>
> >> However, there is no clear explanation of how to fix this.
> >>
> >> Indeed, I load the linux module asus_atk0110 and ran again sensors-detect.
> >>
> > Hi David,
> >
> > Question is not what happens if you ran sensors-detect again; that is
> > not the point and has nothing to do with the ability to load the module
> > or not.
> >
> > Question is what you get when running the "sensors" command after
> > loading the asus_atk0110 module.
> >
> >> The script ended up saying that the following modules was needed :
> >>
> >> Driver `w83627ehf':
> >>     * ISA bus, address 0x290
> >>       Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)
> >>
> >> Driver `coretemp':
> >>     * Chip `Intel digital thermal sensor' (confidence: 9)
> >>
> >> However, there is still no way to load w83627ehf as I read your link.
> >>
> > Did you get the acpi error message as described ?
> >
> > If so, the link does provide the answer:
> >
> > "If you want to restore the old behaviour (which might be dangerous)
> > add: "acpi_enforce_resources=lax" to the kernel cmdline when booting (or
> > add it in grub.conf to make this permanent)."
> >
> > Just remember the "which might be dangerous". You might be better off
> > with asus_atk0100 if it works for you.
> >
> > Guenter
> >
> >
> >
> I loaded the asus_atk0110 module into the kernel :
> 
> $ lsmod |grep atk
> asus_atk0110           10131  0
> 
> However the interface is still using the coretemp linux module, so the 
> pwm config says me :
> 

David,

coretemp doesn't have anything to do with w83627ehf or asus_atk0110,
except that all are hwmon drivers. You are complaining that the
headlights of your car still work even after you tried to replace the
tail break lights.

> /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
> 
> I guess the only way to have my fancontrol working properly is to 
> enforce the old way with the kernel command line.
> 
> How do you plan to fix the situation in future releases ?
> 
First question is if the asus_atk0110 module detects your board. You
would see that with the "sensors" command, not with pwmconfig (the asus
driver does not support manual fan control, so pwmconfig will not work).

Second question is if you actually _need_ manual fan control. The
automatic fan control implemented in NCT6776F is pretty good, and it
should be enabled by default. Do you have any problems with it ?

If you do have problems with automatic fan control, the only remedy I
can see would be for someone to implement manual fan control in
asus_atk0110. Not sure if that is even possible, though.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

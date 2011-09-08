From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 08 Sep 2011 20:32:22 +0000
Subject: Re: [lm-sensors] Fintek F71862FG Super IO Sensors only shows
Message-Id: <4E692656.2030601@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
In-Reply-To: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

First of all please those drop the list from the To / CC
list, if you start a discussion on the list it is sort
of list reader friendly to also finish it there.

On 09/08/2011 09:07 PM, Daniel Schenkenberger wrote:
> dmesg says:
>
> [  216.007958] f71882fg: Found f71862fg chip at 0x290, revision 18
> [  216.008806] ACPI: resource f71882fg [io  0x0290-0x0297] conflicts with ACPI r    egion IP__ [io 0x295-0x296]
> [  216.012580] f71882fg f71882fg.656: Invalid (reserved) pwm settings: 0x01
>
> i added "acpi_enforce_resources=lax" to my grub. if i boot without this the module won't load.

That is not necessarily a good idea, see:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

To quote myself from that page: "a really bad idea and can cause all sort of issues
(including things like changing CPU / RAM voltage or clock speed)."

So be warned!

Now back to the problem, which is:
[  216.012580] f71882fg f71882fg.656: Invalid (reserved) pwm settings: 0x01

Reading the data sheet, this means that the pwm settings for
fan 2 and 3 are: 00 and 00, where as fan 1 has 01. The data sheet gives
the following table for these:

00: Reserved
01: Auto fan speed control, fan speed will follow different temperature by
different duty cycle (voltage) that define in 0xB6-0xBE.
10: Reserved
11: Manual mode fan control, user can write expect duty cycle (PWM fan
type) or voltage(linear fan type) to 0xC3, and F71883FG will output this
value duty or voltage to control fan speed.

Never mind the F71883FG in there, this really if from the F71862FG datasheet
(copy paste error in the data sheet), see:
http://www.fintek.com.tw/eng/products.asp?BID=1&SID

So the driver bails because something, likely the BIOS on your board has
written an illegal value to the Fan mode Select Register.

I guess the BIOS only setups fan 1 and the *cough* brilliant *cough* BIOS
developers decided to just write 00 as value for the other fans, sigh.

There are really 2 things we can do here:
1) Overwrite the BIOS settings, tricky, could do this with a module option
2) Instead of not binding the driver at all, allow the driver initialization
to continue normally, but don't register the pwm interface. This requires
some thinking wrt modifying the code a bit though.

1 is a really bad idea IMHO, so I'll think a bit about doing 2.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

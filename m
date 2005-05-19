From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Ported driver for PC87360 for 2.6 Kernel
Message-Id: <20040912113606.3697b542.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5F0794098965D51199B700508B69580905449CB2@exchange1.chalfont.kingstoninmedia.com>
In-Reply-To: <5F0794098965D51199B700508B69580905449CB2@exchange1.chalfont.kingstoninmedia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Robert,

> A quick reply.

Please reply to the list instead of to me only. People here may help as
well.

> I can if you require arrange ssh access through a public IP address.

I have no convenient Internat access these days, so I have to decline
the offer. At any rate, you seem to have the skills to test your code
yourself, so I don't think I would be of much help.

> > Did you have a chance to test the 2.4 driver?
> 
> Yes I did, but the Tyan GS10 uses the secondary addresses 0x4e /
> 0x4f, hence the first modification to give this selection as a
> parameter.  When running sensors detect it should up, so I guess this
> could be automated.  I followed the keep it simple approach.

I don't think it's that simple. The user shouldn't have to know where
the chip is to get it to work, since we can easily detect it
automatically. Please update your code so that both 0x2e/0x2f and
0x4e/0x4f are tested and used automatically. A similar patch for the 2.4
driver would be appreciated as well.

BTW, what do you have at 0x2e/0x2f? Nothing? Or a different Super-I/O
chip?

I think it is acceptable to stop searching after we found a first
supported device (i.e. not scan 0x4e/0x4f if a PC8736x was found at
0x2e/0x2f). It means that we don't support dual-PC8736x configurations
but I wonder if we will ever see something like that. And this should
make the code easier.

> > > The ability to set the voltage
> > > multiplier, which is divided by 1000 to allow for non-integer
> > > values, and is in line with the use of mV.
> >
> > I am not sure I get you. What is this multiplier you are talking
> > about?
> 
> This is an addition I made, so that i2c/sysfs-interface gives the
> correct reading.  For example the multiplier is set to 8000 ie x8 for
> the 12V input, which measures as 1.5V with the input potential
> divider.  If no external entry is made it defaults to x1, so that it
> will be compliant with libsensors.

Like negative voltages right below, this does not belong to the driver
but to userspace.

> > > The setting of an off-set to allow for negative voltages.
> > 
> > This does not belong to the driver. The chip does not monitor negative
> > voltages. All required conversions belong to libsensors.
> 
> I wasn't sure what the best way was to handle this.  It defaults to
> 0, for compatability with libsensors.  In our particular application
> the drivers will be used with Nagios.  There is a Nagios plugin in the
> form of a shell script wrapper for the sensors program.  I quickly
> tried the sensors program, quickly pasting in the section for the
> pc87360 from the 2.4 kernel version, but it didn't work.  I didn't
> investigate it any further, as it was potentially an unnecessary
> additional layer.  We would just use a shell script to access the
> i2c/sysfs-interface directly.

The fact that it defaults to 0 and is thus "libsensors-compatible" is
not relevant. Conversions do not belong to kernel space. Your port will
not be accepted into the 2.6 kernel tree as long as it contains such
code, even if its use is optional. Please get rid of it.

If you really don't want to use libsensors, you should be able to achive
the same operations in your shell script, using the bash built-in
arithmetics capabilities, or expr. However, I wonder why you don't want
to use libsensors and sensors.

> > > The fan divisors can be set.
> >
> > Why do you need this? The driver already dynamically choose the best
> > clock divider for you.
> 
> It appeared in the original driver that the 960000 had been divided
> by 2 in a couple of the macros to give 480000, which would correspond
> to two pulses per revolution.  To allow for different number of pulses
> per revolution I have included an additional divisor to set the number
> of pulses per revolution.  For example on the Tyan, the front fans are
> 2 pulses per rev, whilst the rear is 4.

Again, you are duplicating libsensors goals. The driver assumes 2
ticks/revolution because this is the most common value. If it doesn't
work for you, you have to divide/multiply in user-space to get the
correct readings. And if you don't want to use libsensors, do the
arithmetics from your shell script.

> > What does "fanspeedcandm" stand for?
> 
> See earlier

This doesn't quite answer my question. What does "candm" stand for?

Please fix your port according to my comments and provide a new version
in the form of a patch against linux 2.6.9-rc1.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

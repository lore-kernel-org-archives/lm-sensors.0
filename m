From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 03 May 2006 21:37:01 +0000
Subject: [lm-sensors] latest findings - my older posting from ~ 11 days
Message-Id: <4459227D.8080700@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605022128.10627.dieter.jurzitza@t-online.de>
In-Reply-To: <200605022128.10627.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Dieter

> after having configured the debugging nothing bad had happened - but I readily 
> knew that could happen so I was patient.
> Today returning from home the problem had had reappeared:
> 
> Please see file attached. You will find a "SMBus collision", and, after that, 
> "sensors" is dead.

OK got it.

To me it seems as:

1) silicon bug in the AMD chipset state machine
2) design error in motherboard or some malfunctioning chip hooked on SMBus

Lets see if there is somewhere a register with the state of state machine ;)
so we know if it is #1. Jordan just contacted some chip designer so we will have 
more information later..

Now my questions:

Does it start to work after reboot? After cold boot? After power unplug?
Have you ACPI in kernel? Have you compiled/loaded/in kernel the thermal module?

If it will happen again in future you may try following:

1) obtain the smb base addr
	AMD756_smba = xxx
Should be in your debug log, you may use value from older log because it does 
not change. Alternatively you may also look into cat /proc/ioports

then you may use the isadump tool
2)
isadump -f xxx

(please replace the xxx with the base address from the log) This will allow us 
to check the status of the SMBDATA and SMBCLK lines and see if they are stuck 
low. Eventually we can try to excersise the DATA and CLK lines to see if they
are working properly.

You may also try to provoke the failure by running this:

modprobe i2c-dev
modprobe i2c-amd756
while true; do i2cdump -y 0 0x2d b > /dev/null; done

This will read from the bus again and again and I'm expecting that it will soon 
or later fail. You dont need to enable the the debugging now I guess it wont 
come with anything new.

Regards
Rudolf


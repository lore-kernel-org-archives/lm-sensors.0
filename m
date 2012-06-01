From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 01 Jun 2012 19:55:39 +0000
Subject: Re: [lm-sensors] Problems with SMSC EMC2103-2
Message-Id: <20120601215539.53c106da@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <3652e486e75012b50617cd207d9ce279.squirrel@webmail.storm-clan.de>
In-Reply-To: <3652e486e75012b50617cd207d9ce279.squirrel@webmail.storm-clan.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Again, please don't top-post, and please keep the list in Cc. This is
the last time I complain about that, next time I won't even read you.

On Fri, 01 Jun 2012 18:04:47 +0200, Sebastian Lefke wrote:
> Well it works perfectly with windows, so I don't know why it shouldn't 
> work with linux. ACPI isn't affected  and hwinfo32 monitors the values 
> and can even manipulate the fan speed. Afaik the editor of hwinfo32 just 
> unhides the sensors by changing the 'hiding'-bit.

It works with Windows. You can't say it works _perfectly_. If a race
condition exists, you may just have been lucky to not hit it yet. It
could also be that your monitoring application either skips ACPI
thermal zones when other monitoring devices are found, or serializes
the access to the various devices.

We can't do that easily in Linux, because the kernel drivers are
responsible for hardware access, and multiple applications can access
the interface exposed by these drivers. The applications are
independent, the kernel drivers too, so serializing is not possible, at
least not with the current model.

One possibility may be to use the hardware semaphore of the SMBus
controller, which I think was designed to solve this problem. However
it only works if the ACPI code itself (which comes with your BIOS)
checks the semaphore too. Last system where I checked, this wasn't the
case, so I gave up the whole idea.

If you provide a copy of your DSDT (/sys/firmware/acpi/tables/DSDT) we
may take a look at what exactly the ACPI BIOS is doing with the
EMC2103, and decide if using the hardware semaphore has a chance to
work. I wouldn't hold my breath though...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

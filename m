From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 14 May 2007 20:21:09 +0000
Subject: Re: [lm-sensors] Fintek F71882FG Driver -> Problems with non
Message-Id: <4648C4B5.2090905@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <000301c793d8$678c3790$20140a0a@EA002>
In-Reply-To: <000301c793d8$678c3790$20140a0a@EA002>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans Edgington wrote:
> Hi Jan & Hans
> 
> 
>> Do you have more details on the MSI mobo's? Type? BIOS version? And the
>> memory configuration (how many MB's / GB's)
> 
> One of the testers just sent me his the info on his mobo, he has a MSI P965
> Platinum mobo. American Megatrends bios version 1.4 with 4GB of ram
> installed. The American Megatrend setup utility(v2.61) is reporting a total
> system memory of 3328MB.
> 
>> Maybe the PAE - Physical Address Extension is messing up the memory-mapped
>> I/O on these mobo's. If that's the case, it's very likely that the only 
>> data your driver gets is rubbish data.
>> PAE could reserve certain regions for PCI/pnp addressing. But normally 
>> that only happens on 4Gb systems where the top 512Mb is reserved for 
>> PCI/pnp addressing.
> 
> How do we then test if this is the case and is there a way of dealing with
> it?
> 

Thats not the case here (I think), we are talking about memory mapped io here, 
and the fintek chip (as far as seen sofar) only has ioport based io.

>> Good to see you working on this! Can you explain the "It seems that the 
>> region is reserved for pnp", a bit more?
> 
> When checking /proc/ioports this is what you see after loading the driver
> 
> 0a00-0adf : pnp 00:0d
>   0a00-0a01 : f71882fg
> 

Ah, I think I understand now. And those addresses, 0a00-0a01 is where you're 
driver detects the hwmon part of the fintek, correct?

IOW, this printk in your driver, gets printed on those MSI boards:
printk(KERN_INFO DRVNAME ": Found F71882FG chip at %#x\n", *address);
With an address of 0x0a00, correct?

And then when creating the platform device in f71882fg_device_add, the device 
resource allocation fails, triggering this error printk:
		printk(KERN_ERR DRVNAME ": Device resource addition failed %d\n", err);

Do I have it correct, that this is the problem the MSI users are seeing?

The fix for this is to initialize the parent pointer of the resource struct 
used and make it point to the resource entry already there in /proc/ioports, 
because of the isapnp stuff. Another approach would be to actually tell the 
kernel that your driver can handle the isa plug and play ID given to the hwmon 
on those MSI boards. Unfortunately I don't know howto do either.

To be clear, the problem is that the MSI bios contains plugandplay 
identification for the hwmon part of the fintek, causing the kernel to already 
reserve those ports, even if there is no driver. By setting the parent pointer 
of the resource to this already existing reservation, we are saying that this 
is not a conflict (which the kernel thinks ATM), but that we are a legimit user 
/ driver for these ports. However I don't know how to find the resource for the 
exisiting reservation, to make the parent pointer point to it :(

Any one else reading who could be of assistance?

>> Are you talking about the IO-address used by the sensors logical device of
>> the super/io chip, or about ... ?
> 
> When the logical device is set to hwmon you can read the base address from
> the registers. Which should contain the sensors data.
> 

I know / understand, and as said above, if I understand correctly the problem 
is that when creating the platform device in f71882fg_device_add, the device 
resource allocation fails, triggering this error printk:
		printk(KERN_ERR DRVNAME ": Device resource addition failed %d\n", err); Correct?

>> Does your driver need to enable the sensors part on those MSI mobo's? Then
> 
>> maybe it also needs to search for a free io-space and program that into to
> 
>> superio config registers for the sensors logical device, before enabling 
>> it.
> 
> On some of the test systems it does need to select the correct logical
> device, but not on all. I'm not sure if it does need to enable the sensors.
> 

I would add printk's to f71882fg_init_device to see if it actually enables 
anything, and I would only do the enabling if a force module parameter was 
given, overriding the BIOS settings by default is a bad idea IMHO.

Regards,

Hans


p.s.

Hans,

We (the school) would still like to see you return the mobo + proc + mem 
someday soonish. Maybe we can make an appointment sometime soon. Then we can 
work on finishing the driver together for a couple of hours (the BIOS does have 
voltage readings, doesn't it? Then we should be able to get that to work) and 
then at the end of the day you can leave the mobo behind, so that we can show 
of your driver at the next PR occasion.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

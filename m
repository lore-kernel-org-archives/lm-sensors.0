From: "fabio.antonini@kaskonetworks.it" <fabio.antonini@kaskonetworks.it>
Date: Wed, 31 Mar 2010 08:07:56 +0000
Subject: Re: [lm-sensors] Support for W83627DHG
Message-Id: <4BB302DC.1050208@kaskonetworks.it>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000608040807090801000307"
List-Id: <lm-sensors.vger.kernel.org>
References: <4BB0BE38.2090502@kaskonetworks.it>
In-Reply-To: <4BB0BE38.2090502@kaskonetworks.it>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000608040807090801000307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean
I have realized that the BIOS doesn't set the SIO_REG_ADDR as it should. 
So I have added a new parameter (force_addr) to let the user to write 
the LPC base address to the register.
Now the modified section is

    /* initialize SIO_REG_ADDR if BIOS doesn't set it */
    if (force_addr) {
        printk(KERN_WARNING DRVNAME ": Writing SIO_REG_ADDR 0x%x.\n", 
force_addr);
        superio_outb(sioaddr, SIO_REG_ADDR, force_addr >> 8);
        superio_outb(sioaddr, SIO_REG_ADDR + 1, force_addr & 0x00FF);
        /* Activate logical device if needed */
        val = superio_inb(sioaddr, SIO_REG_ENABLE);
        if (!(val & 0x01)) {
            printk(KERN_WARNING DRVNAME ": Enabling Super-I/O.\n");
            superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
        }
    }
   
    /* We have a known chip, find the HWM I/O address */
    superio_select(sioaddr, W83627EHF_LD_HWM);
    val = (superio_inb(sioaddr, SIO_REG_ADDR) << 8)
        | superio_inb(sioaddr, SIO_REG_ADDR + 1);
    printk(KERN_ERR DRVNAME ": val = 0x%x\n", val);
    *addr = val & IOREGION_ALIGNMENT;
    if (*addr == 0) {
        printk(KERN_ERR DRVNAME ": Refusing to enable a Super-I/O "
               "device with a base I/O port 0.\n");
        superio_exit(sioaddr);
        return -ENODEV;
    }

I'm not sure that this approach is correct. In your opinion is this 
reasonable or not?

Now i can load the driver by the following command:

# modprobe w83627ehf force_addr=0x290

I have attached a text file with the sensors-detect and sensors output 
message.
Now the driver is properly loaded. The tempeature and voltage detected 
are meaningless because the board I'm working on doesn't use the 
W83627EHF for temperature and voltage monitoring.
I need to use it for its GPIOs and parallel port. Do you know if anyone 
else has already worked on the GPIO or parallel section of the 
W83627ehf. At the moment my feeling is that both are not supported in 
the current driver.

Thanks a lot
with regards
fabio
Jean Delvare ha scritto:
> Hi Fabio,
>
> On Mon, 29 Mar 2010 16:50:32 +0200, fabio.antonini@kaskonetworks.it wrote:
>   
>> Dear all
>> I'm working on a board based on a ATOM Z530. The CPU module is called 
>> MSC_Q7 US15W and the mother board is named Q7-MB-RP.
>> At the moment I have succesfully booted a Ubuntu 9.10 distribution. All 
>> drivers seem to be
>> working except the SuperIO W83627. The chip is rightly detected but it's 
>> not loaded because the
>> driver (w83627ehf) claims that (from dmesg)
>>
>> "Refusing to enable a Super-I/O device with a base I/O port 0"
>>
>> The section of the driver involved on this step is
>>
>>      /* We have a known chip, find the HWM I/O address */
>>      superio_select(sioaddr, W83627EHF_LD_HWM);
>>      val = (superio_inb(sioaddr, SIO_REG_ADDR) << 8)
>>          | superio_inb(sioaddr, SIO_REG_ADDR + 1);
>>      *addr = val & IOREGION_ALIGNMENT;
>>      if (*addr == 0) {
>>          printk(KERN_ERR DRVNAME ": Refusing to enable a Super-I/O "
>>                 "device with a base I/O port 0.\n");
>>          superio_exit(sioaddr);
>>          return -ENODEV;
>>      }
>>
>> My feeling is that the SIO_REG_ADDR contains a 0x0 instead of a real
>> address. Who should set this address? Do I need another kernel module
>> that sets this address?
>>     
>
> It is the BIOS' job. Check in the BIOS is there is any option to enable
> hardware monitoring.
>
> Also check the documentation. The W83627DHG is a Super I/O chip with
> many functions, hardware monitoring is only one of them, and it is
> possible that hardware monitoring pins are simply not wired and that's
> the reason why the address isn't set.
>
>   
>> The output of sensors-detect is
>> (...)
>> As you can see the chip has been detected but no address has been 
>> specified:
>>
>> Found `Winbond W83627DHG Super IO Sensors'
>>      (but no address specified)
>>
>> Where can I set this address?
>>     
>
> There's no easy, standard way (because it is not normally needed.)
>
>   
>> What's missing?
>>     
>
> BIOS initialization, if anything.
>
>   
>> Has this driver been tested before on this board on Ubuntu 9.10?
>>     
>
> There are so many boards and so many Linux distributions out there that
> the probability that someone on this list can answer this question is
> next to zero.
>
>   
>> Do I need to enable anything in the BIOS?
>>     
>
> This is one possibility, yes.
>
>   
>> Do I need load the driver passing any parameter?
>>     
>
> No.
>
>   
>> Any help will appreciated.
>>     
>
> If you really want to, you can set the I/O base to an arbitrary port
> (e.g. 0x290, check in /proc/ioports that 0x290-0x297 is free first) and
> see if it helps. You can do this using the "isaset" command (be careful
> with that command, don't go writing to random I/O ports, it would hurt.)
>
>   


-- 
Fabio Antonini PhD
SW Designer
Kasko Networks srl
Loc.Boschetto, zona ind.le di Pile
67100 L'Aquila


--------------000608040807090801000307
Content-Type: text/plain;
 name="sensors.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="sensors.txt"

root@ws-mythtv-9:~# sensors-detect 
# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Sorry, no supported PCI bus adapters found.

If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): 
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627DHG Super IO Sensors'                  Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): 
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x290
    Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue: 

To load everything that is needed, add this to /etc/modules:

#----cut here----
# Chip drivers
w83627ehf
#----cut here----

Do you want to add these lines automatically? (yes/NO)
root@ws-mythtv-9:~# 



root@ws-mythtv-9:/usr/src/linux-2.6.33.1# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +34.0���C  (crit = +90.0���C)                  

w83627dhg-isa-0290
Adapter: ISA adapter
VCore:       +0.10 V  (min =  +0.00 V, max =  +1.74 V)   
in1:         +0.69 V  (min = +11.40 V, max =  +0.21 V)   ALARM
AVCC:        +3.26 V  (min =  +1.25 V, max =  +0.40 V)   ALARM
3VCC:        +3.26 V  (min =  +2.75 V, max =  +2.88 V)   ALARM
in4:         +0.10 V  (min =  +0.54 V, max =  +0.24 V)   ALARM
in5:         +0.99 V  (min =  +0.89 V, max =  +0.56 V)   ALARM
in6:         +4.74 V  (min =  +0.15 V, max =  +2.41 V)   ALARM
VSB:         +3.26 V  (min =  +0.06 V, max =  +0.59 V)   ALARM
VBAT:        +3.12 V  (min =  +0.00 V, max =  +2.18 V)   ALARM
Case Fan:      0 RPM  (min = 4218 RPM, div = 16)  ALARM
CPU Fan:       0 RPM  (min = 2721 RPM, div = 16)  ALARM
Aux Fan:       0 RPM  (min = 4218 RPM, div = 16)  ALARM
fan4:          0 RPM  (min = 33750 RPM, div = 8)  ALARM
fan5:          0 RPM  (min =    0 RPM, div = 8)  ALARM
Sys Temp:   +124.0���C  (high = +30.0���C, hyst = +101.0���C)  ALARM  sensor = thermistor
CPU Temp:    -78.0���C  (high = +80.0���C, hyst = +75.0���C)  sensor = diode
AUX Temp:   +124.5���C  (high = +80.0���C, hyst = +75.0���C)  ALARM  sensor = thermistor
cpu0_vid:   +0.000 V


--------------000608040807090801000307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000608040807090801000307--

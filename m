From: danielrj@mail.dk (Daniel Rune Jensen)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: lm_sensors i2c-amd756 detection trouble
Message-Id: <20031209143722.46F5.DANIELRJ@mail.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there :)
Have some trouble with my ASUS A7M266-D and lm_sensors. It actually was
running fine until i enabled:
AMD 76x native power management (Experimental)

from dmesg
amd76x_pm: Version 20020730
amd76x_pm: Initializing northbridge Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
amd76x_pm: Initializing southbridge Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI

i was using lm_sensors 2.8.1 but when i booted no sensors was found. I
searched the net around for answers and found that the amd76x is
using the bridge where lm_sensors would like to be, and thus lm_sensors
suddenly can't find any smbus. Also it should be possible to revert back
into lm_sensors 2.7.0 which would fix problems. I have tried the cvs
version 2, as i saw there were some fixes for amd756.

from sensors-detect:

We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-amd756' for device 00:07.3: AMD-768 System Management
Probe succesfully concluded.
We will now try to load each adapter module in turn.
Load `i2c-amd756' (say NO if built into your kernel)? (YES/no): 

/lib/modules/2.4.23/kernel/drivers/i2c/busses/i2c-amd756.o: init_module:
No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.23/kernel/drivers/i2c/busses/i2c-amd756.o: insmod /lib/modules/2.4.23/kernel/drivers/i2c/busses/i2c-amd756.o failed
/lib/modules/2.4.23/kernel/drivers/i2c/busses/i2c-amd756.o: insmod i2c-amd756 failed
Loading failed... skipping.

Now to the question :)
Can this be fixed in lm_sensors, or does it need to be i the kernel tree
where the experimental apmd resides, or is it simply unfixable ?

Regards

Daniel Jensen





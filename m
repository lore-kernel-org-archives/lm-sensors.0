From: Jeff Rickman <jrickman@myamigos.us>
Date: Thu, 30 Jun 2011 00:14:51 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <4E0BBFFB.3040704@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/29/2011 12:01 PM, Phillip Susi wrote:
> On 6/29/2011 12:28 PM, DB wrote:
>> I have Fedora 14 running on my MSI 880GM-E41 board. I've run
>> sensors-detect & passed the found info to (I guess) lmsensors.
>
> Don't guess; know. Pay attention to what sensors-detect says. It tells
> you what sensors it finds, and what modules you need to load in
> /etc/modules. If it didn't find any, then you don't have any supported
> sensors.
>

More information is needed.....

Please show the output from "sensors-detect" command.

Please show the output from the "sensors" command.

Please show the contents of /etc/sysconfig/lm_sensors

Please look in /var/log/messages or run 'dmesg' after a fresh boot. The 
line(s) of interest have the word ACPI in them. You might find something 
like this in 'dmesg' output (pulled from my FC14-i386 box):

[   24.025113] f71805f: Found F71805F/FG chip at 0x290, revision 19
[   24.038969] ACPI: resource f71805f [io  0x0290-0x0297] conflicts with 
ACPI region IP__ [??? 0x00000295-0x00000296 flags 0x5f]
[   24.052702] ACPI: This conflict may cause random problems and system 
instability
[   24.066279] ACPI: If an ACPI driver is available for this device, you 
should use it instead of the native driver

If there is an issue loading the LM_Sensors service, it is possible that 
the problem will be logged here. A typical message I find is some or all 
of the IO ports to the sensor chip are already "reserved" by the BIOS 
(see my example above).

The picture of this board on www.newegg.com 
(http://www.newegg.com/Product/Product.aspx?Item=N82E16813130295) 
suggests a Fintek chip is being used but I cannot determine the model 
from that picture or from the picture on MSI's web site. This chip is 
located at the back of the board, top-side, near the back panel audio 
jacks. If you can read the complete model number on that chip; that 
information is extremely helpful.

The manual for this board suggests the BIOS screens only report 2 
temperature sensors, 2 fans (1 is 4-pin for CPU and other is 3-pin), and 
4 voltages (Vcore, 3.3V, 5V, 12V). The fan header for the CPU appears to 
be 3-pin or 4-pin selectable in the BIOS with and enable/disable toggle 
for a CPU Smart Fan feature.

BTW I also use Fedora Core 14.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

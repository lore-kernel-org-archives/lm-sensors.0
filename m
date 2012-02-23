From: Lee Burchett <zaknafien13@gmail.com>
Date: Thu, 23 Feb 2012 14:44:11 +0000
Subject: Re: [lm-sensors] Nuvoton W83677HG-I/W83676HG-I
Message-Id: <4F4650BB.4020201@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F45B3ED.7080701@gmail.com>
In-Reply-To: <4F45B3ED.7080701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter,

I downloaded and installed the driver last night. The file I picked up 
was groeck-w83627ehf-dof3594.tar.gz. It appeared to build and install 
alright. I am using Kernel 3.0.0-16-generic on a x64 Ubuntu 11.10 
distribution.

After running make-install, I ran sensors-detect again and I still got 
this message:

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `adt7475':
   * Bus `NVIDIA i2c adapter 2 at 1:00.0'
     Busdriver `nvidia', I2C address 0x2e
     Chip `Analog Devices ADT7473' (confidence: 5)

Driver `to-be-written':
   * ISA bus, address 0x290
     Chip `Nuvoton W83677HG-I (NCT6771F/NCT6772F/NCT6775F) Super IO 
Sensors' (confidence: 9)

Note: there is no driver for Nuvoton W83677HG-I 
(NCT6771F/NCT6772F/NCT6775F) Super IO Sensors yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
adt7475
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

I am using an older version of sensors-detect. I will update that as 
well, and let you know what happens. Any other thoughts on what I should do?

Lee Burchett
zaknafien13@gmail.com

On 02/22/2012 11:06 PM, Guenter Roeck wrote:
> On Wed, Feb 22, 2012 at 10:35:09PM -0500, Lee Burchett wrote:
>> I have an ASRock board that uses a newer Nuvoton W83677HG-I Super I/O
>> chip. I would like to help develop (or get help developing) a set of
>> drivers for this chip. It is similar to previous versions of Nuvoton
>> chips like the W83627 series. I found the sensor drivers from Guenter
>> Roeck (Thank You) that are intended for the W83627 series. I was hoping
>> to build on these, but I don't know enough about how kernel modules work
>> to proceed.
>>
>> The manufacturer was helpful in providing documentation for this chip,
>> the W83627UHG, and the W83627DHG-P. Comparing the devices, I noticed
>> that many of the data formats and I/O methods are the same, So I hope
>> that my new chip can be added in fairly easily.
>>
> W83677HG-I and NCT6775F are the same. Did you try the existing driver ?
>
> Thanks,
> Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: John Rippetoe <jrippetoe@comconcepts.com>
Date: Wed, 01 Aug 2012 20:12:23 +0000
Subject: Re: [lm-sensors] Output problem with adcxx  on at91
Message-Id: <50198DA7.1050204@comconcepts.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5019526C.2030802@comconcepts.com>
In-Reply-To: <5019526C.2030802@comconcepts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/01/2012 12:52 PM, Guenter Roeck wrote:
> On Wed, Aug 01, 2012 at 11:59:40AM -0400, John Rippetoe wrote:
>> I am attempting to setup lm-sensors on an embedded platform, more
>> specifically the Micromint Electrum 100.  I'm experiencing an issue
>> with the output of the sensors program where the output is obviously
>> bogus, especially given that all the values are identical.  Some
>> basic details about the system:
>>
>> - 6.04 Debian squeeze
>> - Atmel AT91SAM9G20 cpu (armv5)
>> - ADC128S052 SPI ADC
>> - atmel_spi driver built in to pre-compiled kernel
>> - hwmon, and adcxx loaded as modules later
>>
>> The adcxx kernel module successfully loads and binds to the device.
>> Reading the sysfs files it creates for each input, the same value of
>> 52799 is seen on each.  I know the device works because I have
>> tested it with some userland example code provided by the
>> manufacturer and get expected values for various inputs.
>>
>> I initially had an issue with getting the adcxx module to bind with
>> the device, but found that the problem was because of an alias
>> problem.  In ./arch/arm/mach-at91/board-electrum-100.c the ADC was
>> declared with an alias as shown in the code segment below:
>>
>> /static struct spi_board_info ek_spi_devices[] = {
>> /  .....
>> /    {    /* ADC128S052 analog inputs */
>> /        .modalias    = "adc128s052",
>> /        .chip_select    = 2,
>> /        .max_speed_hz    = 8 * 1000 * 1000,
>> /        .bus_num    = 1,
>> /    },
>> /  .....
>>
> ./arch/arm/mach-at91/board-electrum-100.c is not in mainline, so this is a bit
> difficult. Given the above, it may even be that there is a separate driver for
> the chip somewhere in your tree (ok, I think I found the patch, there isn't,
> but that means this never worked).
I could have sworn that I saw it in mainline, but now that I check I see 
it is not there.  Sorry about that! I am not sure what you mean as far 
as the driver never working and exactly what patch you are talking 
about.  Could you clarify?
> Other than that, there could be many things wrong. Chip select, bus number,
> clock speed, chip access mode. There is no example for a working instantiation
> in the upstream kernel, so I have no idea what the valid parameters might be.
> You mentioned user mode access worked - maybe you can compare it with the kernel
> settings.
As far as I can tell (and I may be wrong here, this is all still pretty 
new to me) the bus and chip select are all correct.  Clock speed could 
be an issue I suppose.  I just did the reverse math on the value that 
the driver is reporting and realized that before it is converted, the 
raw value is 2 bytes worth of 1's.  I am going to trace through the 
spi_write_then_read() function in the adcxx driver and compare its 
method to that used by the user mode program and the atmel_spi driver.  
I'm not sure how far I am going to get though.

John
> Guenter
>
>> Rather than change the alias in board-electrum-100.c and have to
>> recompile and install a new kernel, I opted to add the alias as
>> shown above to adcxx_ids[] in adcxx.c
>>
>> /static const struct spi_device_id adcxx_ids[] = {
>> /    { "adcxx1s", 1 },
>> /    { "adcxx2s", 2 },
>> /    { "adcxx4s", 4 },
>> /    { "adcxx8s", 8 },
>> /    { "adc128s052", 8},   <-- added here
>> /    { },
>> /};
>>
>> With that done, sensors starting giving me output, just not anything
>> worth reading.  At this point I'm a little baffled as to what is
>> causing this and crawling the internet has turned up nothing. Here
>> is my output for sensors:
>>
>> electrum100:~# sensors
>> adcxx8s-spi-1-2
>> Adapter: SPI adapter
>> in0:         +52.80 V
>> in1:         +52.80 V
>> in2:         +52.80 V
>> in3:         +52.80 V
>> in4:         +52.80 V
>> in5:         +52.80 V
>> in6:         +52.80 V
>> in7:         +52.80 V
>>
>>
>> Any help would be greatly appreciated.  Thank you.
>>
>>      - John
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>


-- 
Respectfully,

John Rippetoe
Communication Concepts
813-888-6611


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

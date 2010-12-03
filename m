From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Fri, 03 Dec 2010 21:16:26 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <51311.75.142.173.238.1291410986.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Hi Jeff,
>
> On Mon, 29 Nov 2010 09:51:08 -0600 (CST), Jeff Rickman wrote:
>> > On Mon, 29 Nov 2010 00:20:44 -0600 (CST), Jeff Rickman wrote:
>> >> #    label temp2 "SIO Temp"
>> >
>> > This is an internal sensor, it should always be present and correct,
>> so
>> > why would you ignore it?
>>
>> The value is high...very high. Does a flucuating value between 120 and
>> 128
>> Celsius make sense?
>
> Indeed not. Juerg, you have the datasheet (I think?), I don't, can you
> please check if temp2 is still internal on the SCH5127?
>
>> >>     label temp3 "SYS Temp"
>> >>
>> >>     compute in0 (@ * 0.8), (@ / 0.8)
>>
>> Removing this compute line shows a fairly stable in0 value of 1.78
>
> Which I admit isn't very appealing. Make me wonder if the internal
> scaling factors in the driver are correct. Again, Juerg, I have to
> defer to you.

I looked at the BIOS report for a sensor it calls "V+1.5". It is the very
first value reported (Top of the list) in the Hardware Monitoring BIOS
screen. The value shown is right on "1.5 volts" at system startup.

>> > (...)
>> > Assuming that your CPU does frequency and voltage scaling based on
>> > load, you should try to put some load on the CPU and check which
>> > voltage input raises. This would be Vcore (Vccp) and should require no
>> > scaling. If you can figure that one out, it might help sort out the
>> > rest.
>>
>> I will need to find some type of CPU stress program. Even moving 250,000
>> files (about 70+GB) between hard drives inside the chassis using Rsync
>> only placed <5% load on the CPU.
>
> I use "md5sum /dev/zero" for this.

Thank you for the info. I ran this test for about 15 minutes. The system
voltages changed slightly...no more than 5 hundredths up or down: that
looks like a very stable power supply. System temperatures did go up: it
pushed CPU temp up about 5 degrees Celsius, from ~42 to ~47, but never
reached 50 degrees Celsius.

Systemgraph shows CPU MHz ramped up to full speed: this system can use the
"userspace" governor with ~200 MHz steps starting at ~200 MHz and topping
out at ~1600 MHz.

>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

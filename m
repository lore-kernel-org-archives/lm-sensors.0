From: andreas@schutz.se (andreas@schutz.se)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: parport driver
Message-Id: <34046.83.233.14.177.1112648003.squirrel@webmail1.b-one.nu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again...
So i think i have compiled it now... i got the i2c-pport.ko file and no
errors making it.
Must confess that I am a little confused though, and the more I read the
more insecure I get. Seems like Jean boiled the paralell port drivers (5)
together some day back in 2003? Is that correct? What actually happened
with the different access modes? Exactly what modules do I need to load to
get my parallell port lines to speak i2c?

Cheers.
/Andreas


>
> On Thu, 10 Mar 2005 andreas@schutz.se wrote:
>
>> Hi again!
>>
>> WOW! Impressed, you sure gave me a fast answer!
>> My kernel is 2.6.8-24.11-default.
>> Does the possibility to use the pport driver depend on the kernel
>> version?
>> And.. sorry for my novice attitude (i'm not at native english) but what
>> do
>> you mean with the CC thing to the list?
>>
>
> Just look who is second recepient of this email :) And when replaying
> add it recepicent list too.
>
> If you want parport driver with no additional hardware and  you are
> willing to use 2.6.x kernel version you need my 2.6 port of this driver
>
> http://www.assembler.cz/download/i2cpport26.tar.gz
>
> (i2c-pport)
>
> You need your kernel sources to be installed and your kernel needs to be
> partially configured. Then you will be able to compile it on your own.
>
> Hardware: just connect three wires
>
> SDA - connect to pin 14 (Auto Linefeed)
> SCL - connect to pin 16 (Initialize Printer)
> GND - connect to one of pin 18-25
>
> You need to put your parallel port to "Standart" or "SPP" mode in bios.
> (be sure it is set to 0x378 address)
>
> About the module compilation, there is some short INSTALL file. I dont
> know how you are skilled for kernel compile. We have IRC channel on
> Freenode #linux-sensors  unfortunatelly I will be away starting from today
> until start of next next week. So I cant help you with your kernel
> compilation. You can try to ask other people there. Or wait for me to come
> back.
>
> Regards
>
> Rudolf
>


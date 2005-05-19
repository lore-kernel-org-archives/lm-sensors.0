From: andreas@schutz.se (andreas@schutz.se)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: parport driver
Message-Id: <33634.83.233.14.177.1110453393.squirrel@webmail1.b-one.nu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK!
Thanks...
I'll download the file and give it a try... I have som info. from
http://infogroep.be/ISquareC
that I think follows the same line.
Have a nice abcense... it hope it is a wacation. When you are back, I'll
report my (un)success.

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


From: williamschnell@operamail.com (William)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Missing download
Message-Id: <opr7s854e5k46x2i@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr7rnlmpsk46x2i@localhost>
In-Reply-To: <opr7rnlmpsk46x2i@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for your response.
I did as you wrote, and got the same result; no temperatures or voltages.
I'm guessing the reason is this:
[root@localhost william]# modprobe i2c-viapro
[root@localhost william]# modprobe i2c-isa
[root@localhost william]# modprobe eeprom
[root@localhost william]# modprobe w83627hf
FATAL: Module w83627hf not found.

I don't know why this module isn't found, as it shows OK in sensors-detect.
Any advice appreciated.

William


On Mon, 10 May 2004 20:57:56 +0200, Jean Delvare <khali@linux-fr.org>  
wrote:

>> I need the lm_sensors-2.8.5 for my kernel-2.6.3.9mdk and cannot find
>> it  anywhere.
>
> http://secure.netroedge.com/~lm78/archive/lm_sensors-2.8.5.tar.gz
>
>> Get no temp or volt reading.
>> I see that " Modules will not compile on 2.5/2.6 kernels." This is
>> with  later version of lm_sensors.
>
> This is because these modules are already in the Linux tree. This
> doesn't mean that lm_sensors won't work. Just do "make user && make
> user_install" and it should be just fine.
>



-- 
Using M2, Opera's revolutionary e-mail client: http://www.opera.com/m2/

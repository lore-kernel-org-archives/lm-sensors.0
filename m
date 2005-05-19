From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: pwmconfig for winbond sensors chip not working
Message-Id: <20050213154411.78522f7a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050122170453.83751.qmail@web61305.mail.yahoo.com>
In-Reply-To: <20050122170453.83751.qmail@web61305.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> i have a winbond sensors chip that gives readings
> through lmsensors, but the pwm controls do not work
> 
> i am using kernel 2.4.28
> 
> lsmod:
> w83627hf               13044   0
> i2c-isa                  784   0  (unused)
> i2c-proc                6180   0  [w83627hf]
> i2c-dev                 3424   0  (unused)
> i2c-core               14852   0  [w83627hf i2c-isa
> i2c-proc i2c-dev]
> ide-scsi                9840   0
> (...)
> Testing pwm control w83627hf-isa-0290/pwm1 ...
>   w83627hf-isa-0290/fan3 ... speed was 3708 now 3708
>     no correlation
> (...)
> Testing pwm control w83627hf-isa-0290/pwm2 ...
>   w83627hf-isa-0290/fan3 ... speed was 3708 now 3668
>     no correlation
> (...)
> manually echoing differing pwm values into the proc
> entries doesn't change the fan speeed either
> 
> is fan control supported on this chip?

It is supported on this chip, but this doesn't mean that your
motherboard is properly wired for fan control operation. Actually the
output of pwmconfig clearly means that it is not. Sorry.

-- 
Jean Delvare

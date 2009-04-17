From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Apr 2009 07:10:00 +0000
Subject: Re: [lm-sensors] i2cset troubles
Message-Id: <20090417091000.59b9d234@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49E7B1C7.7000906@gmail.com>
In-Reply-To: <49E7B1C7.7000906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chris,

On Thu, 16 Apr 2009 18:31:35 -0400, Chris Cole wrote:
> Hey all, I found the i2c-tools and lm-sensors packages today...great 
> stuff! I had a question about using i2cset properly. I'm trying to set 
> the value of a digital potentiometer (maxim 5434L) over the i2cbus, and 
> I can tell by using i2cdump that it's setting the register value 
> properly...but I keep getting "Warning - readback failed" after i use 
> i2cset. Here's the output of what I'm trying to do:
> 
> ccole@test:~$ sudo modprobe scx200_acb
> ccole@test:~$ sudo modprobe i2c-dev
> ccole@test:~$ sudo su -
> root@test:~# i2cdetect -l
> i2c-0    smbus         CS5536 ACB0                         SMBus adapter
> (...)

Wrong mailing list, please post to the linux-i2c list instead:
http://vger.kernel.org/vger-lists.html#linux-i2c

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

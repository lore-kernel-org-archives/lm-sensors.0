From: nithin_kj@yahoo.co.in (Nithin prakash)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: LM93 not getting fan nreading
Message-Id: <20041122054612.10153.qmail@web8504.mail.in.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041119122315.50064.qmail@web8506.mail.in.yahoo.com>
In-Reply-To: <20041119122315.50064.qmail@web8506.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Respected sir,
    In LM93 driver there is no such fan divisors
present.Is there any other way to solve the problem.
Shall i get fan values by using 3 pin fan.It is
specified in the data sheet that 4th pin is needed to
get the fan values while using PWM.
yours faith fully,
Nithin

 --- Jean Delvare <khali@linux-fr.org> wrote: 
> > sir im nithin k prakash . im currently working on
> > supermicro board.LM93 is used in that board for
> health
> > monitoring.i m getting all 16 voltage and
> temperature
> > values.but im not getting the fan values.i m using
> 3
> > wire fan.i ve been also worked with 4 wire fan but
> > just connected to the pins allocated for CPU2
> fan(but
> > there is no CPU2) at the same time fan1(3 wire) is
> > connected to CPU1 .Is it necessory to place the
> fan on
> > the CPU to get the fan reading while using PWM
> methods
> 
> Have you tried simply increasing the fan clock
> dividers as suggested in
> our FAQ?
>
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e1
> 
> Note: You won't get a faster answer by creating
> several identical
> tickets in our support system. Actually you could
> even get no answer at
> all just because of that. We help as time permits,
> so please be patient.
> Tickets deleted.
> 
> Thanks.
> 
> -- 
> Jean Delvare
> http://khali.linux-fr.org/
>  

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony

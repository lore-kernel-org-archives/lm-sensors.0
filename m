From: cilly <cilly@cilly.mine.nu>
Date: Wed, 25 Jul 2007 03:12:56 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <1FE4583E-FA7C-464F-844B-64631B9A233D@cilly.mine.nu>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Jul 25, 2007, at 4:29 AM, Juerg Haefliger wrote:

> No, I'm saying the fan will be adjusted by the vt1211 itself. No
> interaction from the CPU required, all done in HW. Basically you can
> set 4 temp and pwm points to control the behavior. Read
> Documentation/hwmon/vt1211 and let me know if you still have
> questions.

Okay, I connected the fan to the cpu fan plug and sensors lists it as  
a case fan.

pwmconfig refuses to work with statically compiled into kernel:

/usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed

probably, this is a bug?

Btw, I really miss a reply to header on that mailing-list. Second  
time the mail didn't go to the list.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

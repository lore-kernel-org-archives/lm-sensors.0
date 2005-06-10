From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 10 Jun 2005 17:49:11 +0000
Subject: [lm-sensors] Re: smsc47m1 FAN problem
Message-Id: <42A9B663.50501@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

I will use english so other people might profit from solution.
Please dont forget to reply  (or just CC) to the lm-sensors address.

> Ahoj!
> Obraciam sa na VAs s prosbou o pomoc. Mam motherboard MS-6797 a dopatral 
> som sa, ze FAN senzor je SMSC LPC47M15x. Problem je, ze oba FANy bezia na 
> maximalne otacky a neviem ich nijako regulovat. Do jadra 2.6.11 som napatchoval
> linux-2.6.12-rc3-i2c-smsc47m1-select-pwm-clock.diff
> a prekompiloval modul, vyzera to takto:

 For non native czech or slovaks I will translate. WHen he do PWM enable fans will stop. He uses that patch backported to 2.6.11
to have clock selection sysfs interface.

> i2c_isa                 1920  0
> smsc47m1                9996  1
> i2c_sensor              3072  1 smsc47m1
> i2c_core               18704  3 i2c_isa,smsc47m1,i2c_sensor
> 
> obraz drivera
> 
> ls -l /sys/bus/i2c/devices/0-0800/
> 
> -r--r--r--  1 root root 4096 Jun 10 14:14 alarms
> -rw-r--r--  1 root root 4096 Jun 10 14:13 detach_state
> lrwxrwxrwx  1 root root    0 Jun 10 14:13 driver ->
> ../../../../bus/i2c/drivers/smsc47m1
> -rw-r--r--  1 root root 4096 Jun 10 14:14 fan1_div
> -rw-r--r--  1 root root    0 Jun 10 14:20 fan1_input
> -rw-r--r--  1 root root 4096 Jun 10 14:14 fan1_min
> -rw-r--r--  1 root root 4096 Jun 10 14:14 fan2_div
> -r--r--r--  1 root root 4096 Jun 10 14:14 fan2_input
> -rw-r--r--  1 root root 4096 Jun 10 14:14 fan2_min
> -r--r--r--  1 root root 4096 Jun 10 14:14 name
> drwxr-xr-x  2 root root    0 Jun 10 14:13 power
> -rw-r--r--  1 root root    0 Jun 10 14:14 pwm1
> -rw-r--r--  1 root root    0 Jun 10 14:17 pwm1_clock
> -rw-r--r--  1 root root    0 Jun 10 14:21 pwm1_enable
> -rw-r--r--  1 root root    0 Jun 10 14:32 pwm2
> -rw-r--r--  1 root root    0 Jun 10 14:17 pwm2_clock
> -rw-r--r--  1 root root    0 Jun 10 14:45 pwm2_enable
> 
> 
> Utilita pwmconfig zlyha, zastavi oba FANy a neviem ich znova nahodit pomocou
pwmconfig will fail to get two fans back and this wont help:

> echo 1 > pwm1_enable
> echo 1 > pwm2_enable

> Restartujem stroj aby sa neuprazil procesor.

He will restart the machine so the procesor wont die.

> Neviete poradit kde by som sa blizsie dopatral k informaciam? Ci sa niekomu
> podarilo spravit speed regulaciu a ako merat teplotu CPU na tejto doske?
> Nateraz viem zapnut a vypnut FANy. Dakujem.

He asks about temperature and other stuff and how to regulate it with temps.

Please run sensors-detect command to see what chips you have. Your chip has also a HW monitor block but i think it is not yet supported.
And also I think nobody is working on that. If you want to fund or donate the motherboard or write the support by yourself we can discuss it in further emails.

And now I will try to write something about the solution.

Do t the same without the patch? ( I guess so)

What will happen if you do after thay are stopped:

 echo 0 > pwm1_enable
 echo 0 > pwm2_enable

Will they spin again? (I think you made a mistake in description)


Please try with the power off/boot:
What will happen when you do:

 echo 1 > pwm1_enable
 echo 1 > pwm2_enable

echo 255 > pwm1
echo 255 > pwm2

echo 0 > pwm1
echo 0 > pwm2

Will they spin again? If so your fans are polarity inverted so 0 is full speed.

If it does not help you can try:
To play with the pwm1_clock and pwm2_clock
This are valid possibilites:
 40, 60, 80, 120, 15625, 23438, 31250, 46876
You can echo them similar way as the values above.
I would suggest to pick up some higher frequency to the beginning.

I hope this will help.

Regards
Rudolf

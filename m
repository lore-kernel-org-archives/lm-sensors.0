From: "didy45@libero.it" <didy45@libero.it>
Date: Wed, 17 Mar 2010 21:38:55 +0000
Subject: [lm-sensors] R: Re: Re:  R: Re: R: Re: sensors not found INTEL i7
Message-Id: <25012458.597721268861935606.JavaMail.defaultUser@defaultHost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

RESOLVED with kernel 2.6.32generic. THANKS!!!!

but How do i set my speed-fan?
When i digit pwmconfig...

fabio@fabio-laptop:~/Scaricati/xsensors-0.70/src$ sudo pwmconfig

# pwmconfig revision 5770 (2009-09-16)
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

/usr/local/sbin/pwmconfig: There are no pwm-capable sensor modules installed

What do i do??

>----Messaggio originale----
>Da: kronos.it@gmail.com
>Data: 17/03/2010 14.13
>A: "didy45@libero.it"<didy45@libero.it>
>Cc: <lm-sensors@lm-sensors.org>
>Ogg: Re: Re: [lm-sensors] R: Re: R: Re: sensors not found INTEL i7
>
>On Tue, Mar 16, 2010 at 5:29 PM, didy45@libero.it <didy45@libero.it> wrote:
>> This my /proc/cpuinfo (only one core):
>> processor       : 0
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 30
>
>Support for Lynnfield was added in 2.6.32, you need a newer kernel.
>
>Luca
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: trxman@gmail.com (Nebojsa Trpkovic)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: pwm on IT8712F rev.6 works on Chaintech VNF4 Ultra
Message-Id: <4239E9DC.7040907@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.

/******
    my system:
    Chaintech VNF4 Ultra (NForce4 Ultra PCI-E chipset)    @default
    AMD Athlon64 3000+ (Winchester core, box cooler)   @default
    2 x 256MB Kingmax Color RAM 466MHz    @400MHz
    Asus EAX300SE PCI-E
    Maxtor DM+ 9 80GB PATA 2MB
   
    Gentoo linux amd64 multilib, powernow-k8 ondemand loaded
******/

I've posted ticket with question about pwm support on IT8712F chips and 
got this answer:

http://secure.netroedge.com/~lm78/readticket.cgi?ticket32

So, I haven't been lazy and tried suggested workaround - IT WORKS !!!

I've compiled vanilla 2.6.11 kernel patched with 2.6.11-mm4.bz2,
loaded modules manualy and added fix_pwm_polarity module parameter for 
it87 module:

    modprobe it87 fix_pwm_polarity

I've got this in my logs:

    Mar 17 20:53:22 titan it87: Found IT8712F chip at 0x290, revision 6
    Mar 17 20:53:22 titan it87 2-0290: Reconfiguring PWM to active high 
polarity

After that I've tried:

    /sys/devices/platform/i2c-2/2-0290/echo 1 > pwm1_enable
    /sys/devices/platform/i2c-2/2-0290/echo 1 > pwm2_enable
    /sys/devices/platform/i2c-2/2-0290/echo 128 > pwm1
    /sys/devices/platform/i2c-2/2-0290/echo 128 > pwm2

and later:

    /sys/devices/platform/i2c-2/2-0290/echo 0 > pwm1
    /sys/devices/platform/i2c-2/2-0290/echo 0 > pwm2

Both fans reduced speed and (after echoing zero) stoped. Ofcorse, I was 
able to spin them up - peace of cake. :)
All actions were monitored by "watch -n 1 sensors" and visualy.

The third fan I can see in my sensors does not have control logic 
integrated on the mobo. I was not able to change it's speed in window$ 
neither (by using SpeedFan). Fourth fan connector on mobo does not 
provide neither control nor fan speed information.
Two controleable fans are labeled as CPU FAN (FAN1) and CASE FAN (FAN3) 
on the mobo. Third is labeled SYSTEM FAN (FAN2) and fourth is CHIP FAN 
(FAN4).


I hope I helped a little bit.
I hope this patch will be in stable kernel tree soon, so I can use it 
with my gentoo-dev-sources 2.6.11-r1, too.
(I was not able to find this patch outside mm patch, so I couldn't patch 
my gentoo kernel to make pwm avaible.. :( )

Should I write a ticket visible for everyone about my experiments or 
this mail is enought?

(I'm not subscribed to the list, so please, reply personaly to me)

Thank you.
Regards,
Nebojsa Trpkovic




  


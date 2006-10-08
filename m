From: kress@hal.saar.de (Michael Kress)
Date: Sun, 08 Oct 2006 14:42:19 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <45290E4B.304@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> Well, is is already kept as a contrib element. But I fail to see the
> added value as it is not maintained and certainly won't work with any
> recent distribution. Yourself, you finally started from the CentOS spec
> file rather than ours.
>   
You're right - and even with that solution I'll be alone with regards to
the CentOS community as CentOS more or less strictly follows the
upstream provider. Maybe someone's interested to include it in some
extras tree there, at CentOS. But you are right, the right place is not
in lm_sensors as one software project can't take care of all the distris
out in the world.
> My "Objections anyone?" was essentially an "Is someone volunteering to
> maintain these spec files?" And if nobody shows up, the files are gone
> soon.
>   
From the above point of view - delete it.
> Nice! So it finally works :)
>   
yes, success stories are written in mailing lists. :)
> Now you can write a sensors.conf file for this board. You should be
> able to find the labels by comparing with what the BIOS is displaying.
> As for the low limit values, the choice is up to you. 712 RPM looks a
> bit too low IMHO.
>   

[root at matrix ~]# sensors
pc87427-isa-0840
Adapter: ISA adapter
case-fan1:3678 RPM  (min = 2000 RPM)
case-fan2:3391 RPM  (min = 2000 RPM)
case-fan3:3400 RPM  (min = 2000 RPM)
case-fan4:3366 RPM  (min = 2000 RPM)
not-inst:    0 RPM  (min =    0 RPM)          FAULT
CPU0-fan: 2915 RPM  (min = 2000 RPM)
not-inst:    0 RPM  (min =    0 RPM)          FAULT
CPU1-fan: 2830 RPM  (min = 2000 RPM)

[root at matrix ~]# tail -n 17 /etc/sensors.conf
chip "pc87427-*"
   label fan1 "case-fan1"
   label fan2 "case-fan2"
   label fan3 "case-fan3"
   label fan4 "case-fan4"
   label fan5 "not-inst"
   label fan6 "CPU0-fan"
   label fan7 "not-inst"
   label fan8 "CPU1-fan"
   set fan1_min 2000
   set fan2_min 2000
   set fan3_min 2000
   set fan4_min 2000
   set fan5_min 0
   set fan6_min 2000
   set fan7_min 0
   set fan8_min 2000

JFYI, if I put fan[1-4]_min on 3000, the fans start running at about
4500RPM, giving quite a cool ambiance in the chassis. :)
2000 should be enough.

Have a good time!
Michael

-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L



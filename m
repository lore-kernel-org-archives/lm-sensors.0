From: michel@bouissou.net (Michel Bouissou)
Date: Mon, 11 Jul 2005 11:19:37 +0000
Subject: [lm-sensors] Fwd: [Bug 16755] [lm_sensors] ASSIGNED: [PATCH] Bad
Message-Id: <200507111118.03565@totor.bouissou.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So they asked me to bug you ;-))

(BTW the sensors@stimpy.netroedge.com email address mentioned on the 
http://www2.lm-sensors.nu/~lm78/support.html web page bounces with "User 
unknown"...)


----------  Message transmis  ----------

Subject: [Bug 16755] [lm_sensors] ASSIGNED: [PATCH] Bad IT87 sensor 
initialization
Date: Samedi 09 Juillet 2005 10:56
From: [mdk] <bugzilla@qa.mandriva.com>
To: michel@bouissou.net

User ID: 5399, 105 bugs reported (73 fixed, 4 duplicate, 10 invalid), 333
 comments.

http://qa.mandriva.com/show_bug.cgi?id755


mdk@agat.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|UNCONFIRMED                 |ASSIGNED
     Ever Confirmed|0                           |1




------- Additional Comments From mdk@agat.net  2005-07-09 10:56 -------
ok, nice catch.
I'll use this patch if no new release of lm_sensors fixes this bug.

Bug the lm_sensors mens with your issue, it isn't normal to use "sensors -s"
twice to initialize some components.

--
Configure bugmail: http://qa.mandriva.com/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You reported the bug, or are watching the reporter.


------- Reminder: -------
assigned_to: mdk@agat.net
status: ASSIGNED
distribution: 10.2-community
creation_date:
description:
Hi there,

On a Gigabyte GA-7VAXP motherboard (Athlon XP CPU, Via KT400 chipset),
 there's an IT87 sensor, that is managed by the it87 module.

It appears than on this MB, starting the "lm_sensors" service doesn't allow
proper initialization of the IT87 : Alarm threshold values don't get set
properly unless "sensors -s" is called a 2nd time, and then, it's OK.

I propose the following simple patch to the lm_sensors script, that just
 calls "sensors -s" a 2nd time if "sensors" reports an alarm after "sensors
 -s" has been called the 1st time.

It fixes the issue plain good here, and shouldn't interfere with systems that
don't have such problems.

Here's the proposed patch:

--- lm_sensors.Original.mdk102  2005-07-08 12:09:34.000000000 +0200
+++ lm_sensors  2005-07-08 12:13:14.000000000 +0200
@@ -57,6 +59,7 @@
        echo
        # Set Alarm
        sensors -s && sleep 2
+       sensors | grep -q "ALARM" && { sensors -s && sleep 2; }
         # Start daemons.
         gprintf "Starting sensord: "
         daemon sensord -i 1m -l 30m


Besides, I don't know if this may help, but here are the proper sensors.conf
settings for the sensors modules that works with this MB (voltage factors
checked with a multimeter):

# MiB
# Modifie par Michel Bouissou le 29/09/2004
# pour CM Gigabyte GA-7VAXP
# Chipset VIA KT400 + ITE IT8705F

chip "it87-*"

    label "in0" "CPU core"
    label "in1" "DDRAM"
    label "in2" "3v3 I/O"
    label "in3" "+5V"
    label "in4" "+12V"
    label "in5" "-12V"
#    ignore "in5"
    label "in6" "-5V"
#    ignore "in6"
    label "in7" "Stdby"
    label "in8" "Vbat"
    ignore "in8"
    ignore "vid"

    label fan1  "CPU Fan"
    label fan2  "BOX Fan"
    label fan3  "PWR Fan"
    ignore fan3

    label temp1 "IT87 T??"
    label temp2 "UNUSED"
    ignore temp2
    label temp3 "UNUSED"
    ignore temp3

#   Tol??rances larges : -10% / +8%
#   Tol??rances serr??es: +/- 5% (Sp??cifications ATX)
# CPU Core
    set in0_min 1.75 * 0.95
    set in0_max 1.75 * 1.05
# DDRAM
    set in1_min 1.25 * 0.94
    set in1_max 1.25 * 1.06
# +3.3V
# Tol??rances Antec pour +3.3V: +/- 3%
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
# +5V
# Tol??rances Antec pour +5V: +/- 3%
    set in3_min 5 * 0.95
    set in3_max 5 * 1.05
# +12V
# Tol??rances Antec pour +12V: +/- 3%
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
# -12V
# Tol??rances larges pour -12V (Oscille car non charg??)
    set in5_min -12 * 0.60
    set in5_max -12 * 1.40
# -5V
# Tol??rances tr??s larges pour -5V (Oscille car non charg??)
    set in6_min -5 * 0.50
    set in6_max -5 * 2.00
# +5V StdBy
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05

#    set temp1_hyst 50
    set temp1_over 55
    set temp1_low 15

    set fan1_min 1600
    set fan1_div 4
#   set fan2_min 1500
    set fan2_min 900
    set fan2_div 8

#   +5V
#   compute "in3" ((6.8/10)+1)*@ , @/((6.8/10)+1)
#   Coeff ci-dessous r??gl?? au multim??tre
    compute "in3" ((7.2/10)+1)*@ , @/((7.2/10)+1)
#   +12V
    compute "in4" ((30/10)+1)*@ , @/((30/10)+1)
    compute "in5" -(56/10)*@ , -@/(56/10)
    compute "in6" -(36/10)*@ , -@/(36/10)
#   Coeff ci-dessous report?? d'apr??s +5V r??gl??
#   compute "in7" ((6.8/10)+1)*@ , @/((6.8/10)+1)
    compute "in7" ((7.2/10)+1)*@ , @/((7.2/10)+1)


chip "lm90-*" "adm1032-*"

   label temp1 "LM90 T??"
   label temp2 "Athlon T??"
   label tcrit1 "LM90 Crit"
   label tcrit2 "CPU Crit"

# change high and low limits to fit your needs
   set temp1_low  15
   set temp1_high 60
   set temp2_low  15
   set temp2_high 70

# change critical limits to fit your needs
# should be higher than the corresponding high limit above
   set tcrit1 70
   set tcrit2 80


-------------------------------------------------------

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E

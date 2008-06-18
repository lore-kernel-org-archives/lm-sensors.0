From: Marcello Desantis <m.desantis@storming.it>
Date: Wed, 18 Jun 2008 19:46:07 +0000
Subject: [lm-sensors] Voltage on Asus P5W DH Deluxe (w83627ehg)
Message-Id: <loom.20080618T173641-752@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm trying to monitor voltages on my Asus P5W DH Deluxe motherboard (using a
w83627ehg chip) with lm-sensors. The problem is the compute line for the -12V
voltage, all other readings are fine with the default settings for the w83627ehf
chip.

Using the w83627ehf/ehg datasheet as a starting point I defined the following:

# Set the -12V
    label in5 "-12VCC"
    compute in5 (@-2.048)*((232+10)/10)+2.048, (@-2.048)*(10/(232+10))+2.048
    set in5_min   -12.0*1.1
    set in5_max   -12.0*0.9

With this line I get:

-12VCC:           -9.57 V  (min = -13.25 V, max = -10.73 V)   ALARM

Which leads to one or more of the followings:

1) There's a mistake in my formula
2) Asus didn't follow the datasheet guidelines for -12V external resistors (232K
e 10K) or didn't connect the -12V at all.
3) My PSU is broken

The latter is a real possibility, which is the reason I want to monitor voltages.

Any hints?

Marcello


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

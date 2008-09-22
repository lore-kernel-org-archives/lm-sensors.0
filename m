From: "George Spelvin" <linux@horizon.com>
Date: Mon, 22 Sep 2008 07:57:26 +0000
Subject: [lm-sensors] MSI K9A2 Platinum (MS-7376) motherboard config...
Message-Id: <20080922075726.3522.qmail@science.horizon.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A couple of minor comments:
- Come sort of include mechanism would be very handy for
  distributions, who'd like to separate the standard
  sensors3.conf file from local customizations.
- How do I un-ignore a signal? The generic file lists
chip "f71882fg-*"
	ignore temp3

  But I want to use temp3.  I had to comment out the ignore line.
  Is there a way to leave that alone?

Anyway, here's what I'm using ATM.  The "11" and "5.7" numbers match the
BIOS exactly.  Obviously, the temperature thresholds are user-specific.

I can probe the board if anyone has any ideas about in5 or in6.

chip "f71882fg-isa-0600"

# Temperature
    label temp1 "CPU"
    ignore temp2
    label temp3 "System"

# Fans
    label fan1  "CPU"
    label fan2  "SYSFAN2"
    label fan3  "SYSFAN1"
    ignore fan4 # It's not SYSFAN3 or SYSFAN4...

# Voltage
# The BIOS only displays 0..4.
    label in0   "3.3V"
    label in1   "Vcore"
    label in2   "12V"
    label in3   "+5V"
    label in4   "5Vsb"
    label in5   "in5"   # No idea
    label in6   "in6"   # No idea
    label in7   "3Vsb"
    label in8   "Battery"

# never change the in0, in7 and in8 compute, these are hardwired in the chip!
    compute in0       (@ * 2), (@ / 2)
    compute in2       (@ * 11), (@ / 11)        # Verified against BIOS
    compute in3       (@ * 5.7), (@ / 5.7)      # Verified against BIOS
    compute in4       (@ * 5.7), (@ / 5.7)      # Verified against BIOS
    compute in5       (@ * 2), (@ / 2)          # No idea, 1.49 V
    compute in6       (@ * 2), (@ / 2)          # No idea, 1.23 V
    compute in7       (@ * 2), (@ / 2)
    compute in8       (@ * 2), (@ / 2)

    set temp1_max       55
    set temp1_max_hyst  50
    set temp1_crit      60

    set temp3_max       30
    set temp3_max_hyst  25
    set temp3_crit      40

    set in1_max 1.35

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: marcus@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Intel S845WD1-E
Message-Id: <200404291823.31523.marcus@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404280005.56044.lists@localguru.de>
In-Reply-To: <200404280005.56044.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 29 April 2004 05:15, Philip Pokorny wrote:
> The sample config entry is in doc/chips/lm85...

here is mine:

chip "lm85c-*" "adm1027-*" "adt7463-*" "lm85-*" "lm85b-*"

? ?set temp1_max 50

# Voltage inputs
? ?label in0 ? "V1.5" ? ? ?# AGP on Intel S845WD1-E
? ?label in1 ? "VCore"
? ?label in2 ? "V3.3"
? ?label in3 ? "V5"
? ?label in4 ? "V12"

# Temperature inputs
? ?label temp1 ?"CPU"
? ?label temp2 ?"Board"
? ?label temp3 ?"Remote"

# Fan inputs
? ?label fan1 ? "CPU_Fan"
# ? label fan2 ? "Fan2"
# ? label fan3 ? "Fan3"
# ? label fan4 ? "Fan4"

# PWM Outputs
? ?label pwm1 ? "CPU_PWM"
? ?label pwm2 ? "Fan2_PWM"
? ?label pwm3 ? "Fan3_PWM"

# Voltage scaling is done on-chip. ?No 'compute' directive
# ? ?should be necessary. ?If in0 has external scaling set
# ? ?it here.

# ? compute in0 ?@ * 2.5, ? @ / 2.5

# Adjust fans speeds for actual pulses per rev
## ? compute fan1 ?@ * 2, ?@ / 2 ? ?# 1 pulse per rev
# ?set fan1_ppr ?1 ? ? ? ? ? ? ? ?# ADM1027 or ADT7463
## ? compute fan2 ?@ / 2, ?@ * 2 ? ?# 4 pulse per rev
# ?set fan2_ppr ?4 ? ? ? ? ? ? ? ?# ADM1027 or ADT7463


? ?ignore fan2
? ?ignore fan3
? ?ignore fan4


# Set VRM version
? ?set vrm ?9.1 ? # Pentium 4

# Set voltage limits
? ?set in0_min ?1.5 * 0.95
? ?set in0_max ?1.5 * 1.05
? ?set in1_min ?vid * 0.95
? ?set in1_max ?vid * 1.05
? ?set in2_min ?3.3 * 0.95
? ?set in2_max ?3.3 * 1.05
? ?set in3_min ?5.0 * 0.95
? ?set in3_max ?5.0 * 1.05
? ?set in4_min ? 12 * 0.95
? ?set in4_max ? 12 * 1.05

# Set Fan limits
? ?set fan1_min 4000

# Set Temp Limits
? ?set temp1_min 10
? ?set temp1_max 50
? ?set temp2_min 10
? ?set temp2_max 35
? ?set temp3_min 10
? ?set temp3_max 35


-- 
Marcus Schopen        (0>
P.O. Box 10 25 25     //\     Deutsche Zope User Group
D-33525 Bielefeld     V_/_                www.dzug.org

                ArchLinux, what else?

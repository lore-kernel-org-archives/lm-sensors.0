From: "John Smith" <Kidfromaussie@gmx.com>
Date: Thu, 14 Jul 2011 04:11:04 +0000
Subject: Re: [lm-sensors] Config for MSI GF615M-P33 (MS-7597)
Message-Id: <20110714041105.131170@gmx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="========GMX131171310616665290150"
List-Id: <lm-sensors.vger.kernel.org>
References: <20110714035535.131170@gmx.com>
In-Reply-To: <20110714035535.131170@gmx.com>
To: lm-sensors@vger.kernel.org

--========GMX131171310616665290150
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Previous message was html
========BEGIN
# lm_sensors configuration file for the MSI GF615M-P33 rev 1.3 (MS-7597)
# 2011-07-14 ,Kid from Belgrade
# tweaked from config for MSI P35 Neo / MSI MS-7360 motherboard
# 2007-09-21, Andre Jagusch
# Comments welcome!

chip "f71889ed-*"

# Temperature
    label temp1       "CPU"
    label temp2       "System"
    ignore temp3

# Fans
    label fan1        "CPU"
    label fan2        "System"
    label fan3        "Misc"
#    label fan3        "Power"
#    label fan4        "Aux"

# sensors in2 in3    , in6    , in7 , in8  may be ignored since 
# they are not shown in BIOS for MS-7597
# in6 is allways 0.00
# Voltage
    label in0         "3.3V"
    label in1         "Vcore"
#    ignore in2
#    ignore in3
    label in2         "Vdimm"
    label in3         "Vchip"
    label in4         "+5V"
    ignore in6
    label in5         "12V"
#    ignore in7
#    ignore in8
    label in7         "3VSB"
    label in8         "Battery"

# never change the in0, in7 and in8 compute, these are hardwired in the chip!
# +5V +12V +3.3V computess looking fine for  MS-7597 ,nothing changed
    compute in0       (@ * 2), (@ / 2)
    compute in2       (@ * 2), (@ / 2)
    compute in3       (@ * 2), (@ / 2)
    compute in4       (@ * 5.25), (@ / 5.25)
    compute in5       (@ * 11), (@ / 11)
    compute in6       (@ * 6.585), (@ / 6.585)
    compute in7       (@ * 2), (@ / 2)
    compute in8       (@ * 2), (@ / 2)


# on fintek , first sensor is below or near the cpu socket (how to determine this?)
# CPU temperature is also measurable by on-dye sensor on k10 series
# now i have not find this anywhere and corection is corelated with fintek
# tweaked for Athlon II x2 250 ,may defere for others
chip "k10temp-*"

   label temp1 "CPU K10 Temp"

   compute temp1 (@ + 5.5), (@ - 5.5)
========END

--========GMX131171310616665290150
Content-Type: text/plain; charset="utf-8"; name="sensors33.conf"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="sensors33.conf"
Content-Description: Attachment: sensors33.conf

 
# lm_sensors configuration file for the MSI GF615M-P33 rev 1.3 (MS-7597)
# 2011-07-14 ,Kid from Belgrade
# tweaked from config for MSI P35 Neo / MSI MS-7360 motherboard
# 2007-09-21, Andre Jagusch
# Comments welcome!

chip "f71889ed-*"

# Temperature
    label temp1       "CPU"
    label temp2       "System"
    ignore temp3

# Fans
    label fan1        "CPU"
    label fan2        "System"
    label fan3        "Misc"
#    label fan3        "Power"
#    label fan4        "Aux"

# sensors in2 in3    , in6    , in7 , in8  may be ignored since 
# they are not shown in BIOS for MS-7597
# in6 is allways 0.00
# Voltage
    label in0         "3.3V"
    label in1         "Vcore"
#    ignore in2
#    ignore in3
    label in2         "Vdimm"
    label in3         "Vchip"
    label in4         "+5V"
    ignore in6
    label in5         "12V"
#    ignore in7
#    ignore in8
    label in7         "3VSB"
    label in8         "Battery"

# never change the in0, in7 and in8 compute, these are hardwired in the chip!
# +5V +12V +3.3V computess looking fine for  MS-7597 ,nothing changed
    compute in0       (@ * 2), (@ / 2)
    compute in2       (@ * 2), (@ / 2)
    compute in3       (@ * 2), (@ / 2)
    compute in4       (@ * 5.25), (@ / 5.25)
    compute in5       (@ * 11), (@ / 11)
    compute in6       (@ * 6.585), (@ / 6.585)
    compute in7       (@ * 2), (@ / 2)
    compute in8       (@ * 2), (@ / 2)


# on fintek , first sensor is below or near the cpu socket (how to determine this?)
# CPU temperature is also measurable by on-dye sensor on k10 series
# now i have not find this anywhere and corection is corelated with fintek
# tweaked for Athlon II x2 250 ,may defere for others
chip "k10temp-*"

   label temp1 "CPU K10 Temp"

   compute temp1 (@ + 5.5), (@ - 5.5)

--========GMX131171310616665290150
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--========GMX131171310616665290150--

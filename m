From: Mathias Gerber <mathias_g@tuxedo.ath.cx>
Date: Mon, 13 Jan 2014 20:49:13 +0000
Subject: [lm-sensors] Configuration for Gigabyte Z77-D3H
Message-Id: <52D45149.20804@tuxedo.ath.cx>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020704060602000807020706"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020704060602000807020706
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Folks

Finally I could demystify most of the sensor values for this mainboard.
My configuration file is attached to this email.

Not clear is the temp1 reading. Should be PCH temp AFAIK.
But here I read most of the time 32=B0C or sometimes 33=B0C.
- --=20
kind regards
 mathias
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLUUUMACgkQnfTEjDUZ2fME0wCcCFL+MOQtiNi4Yhj+BRlwPvYQ
X28AoLi9YyXl+bqqr0EfBasJ96A+GMc+
=3DFrNz
-----END PGP SIGNATURE-----

--------------020704060602000807020706
Content-Type: text/plain; charset="utf-8"; name="ga-z77-d3h.conf"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="ga-z77-d3h.conf"

chip "acpitz-virtual-0"
    ignore temp1 # stays always at 27.8°C
    ignore temp2 # dito

chip "it8728-*"

    label in0 "0: CPU Vtt"
    set in0_min 1.02    # I'm liberal with these, 2-3% tops
    set in0_max 1.08    # after that, cpu gets very unstable

    label in1 "1: +3.3V"
    set in1_min 3.3 * 0.95    # Some boards including GA-H67MA-UD2H
    set in1_max 3.3 * 1.05    # don't have 3.3V voltage reading
    compute in1 1.649*@,@/1.649 # multipliers provided by Martin Malik author of hwinfo

    label in2 "2: +12V"
    set in2_min 12 * 0.95
    set in2_max 12 * 1.05
    compute  in2  @ * (72/12), @ / (72/12) #mg,15.05.13

    label in3 "3: +5V"
    set in3_min 5 * 0.95
    set in3_max 5 * 1.05
    compute in3 2.5*@,@/2.5

    label in4 "4: Vaxg"	# Voltage used by the video controller embedded inside the CPU
    set in4_min 0.4
    set in4_max 1.4

    label in5 "5: Vcore"
    set in5_min 0.825 * 0.95
    set in5_max 1.425 * 1.05

    label in6 "6: Vdram"
    set in6_min 1.5 * 0.95    # adjust these, 1.35 for LVDDR3
    set in6_max 1.5 * 1.05    # 1.5V is recommended, 1.65 tops
     
    label in7 "7: 3VSB"
    set in7_min 3.00 * 0.95
    set in7_max 3.00 * 1.05

    label in8 "8: Vbat"
    set in8_min  3.0 * 0.90
    set in8_max  3.0 * 1.10

### fan

    label fan1 "CPU fan"
    set fan1_min 700

    ignore fan2 # comment if connected
    label fan2 "Sys1 fan"
    set fan2_min 0

    label fan3 "Sys2 fan"
    set fan3_min 200 

    label fan4 "Sys3 fan"
    set fan4_min 200 

    ignore fan5 # comment if connected
    label fan5 "Sys4 fan"
    set fan5_min 0 

### temperatures

    label temp1 "PCH temp??" # shows always 33°C
    set temp1_min 10
    set temp1_max 60

    ignore temp2
    label temp2 "MB temp??" # shows always 25°C
    set temp2_min 0
    set temp2_max 60

    label temp3 "CPU temp"
    set temp3_min 10
    set temp3_max 85

    ignore intrusion0 # activate if in use

--------------020704060602000807020706
Content-Type: application/octet-stream;
 name="ga-z77-d3h.conf.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ga-z77-d3h.conf.sig"

iEYEABECAAYFAlLUUUkACgkQnfTEjDUZ2fPIDQCfc3fr0xkO7J/tuCOEzOU/JU7+vHoAoLuq
oJINoLmGPCEmNLBfyggvwSx0
--------------020704060602000807020706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020704060602000807020706--

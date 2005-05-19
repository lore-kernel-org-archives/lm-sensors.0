From: jgluckca@netscape.net (John)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: Some info for your web site (ASB100)
Message-Id: <1040CDE9.62A0DF56.009D6C5C@netscape.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I just got lm_sensors 2.8.7 going with a 2.6.7 kernel and an Asusu P4PE motherboard.

I need to change the default config a for the ASB100 a wee bit because the pwr and case fans weren't being reported. Also some of the voltages were just a bit off. With the config below everything is quite close to what AsusProbe reports under windows. Note VCore 1 and 2 report the same voltage. I also noted a fair bit of jitter on the VCore so I set the over voltage alarm a bit higher.

Config follows:

#
# My config for Asus P4PE
#
chip "asb100-*"
    set vrm 9.0

    label in0 "VCore 1"
    set in0_min vid * 0.95
    set in0_max vid * 1.1

    label in1 "VCore 2"
    #ignore in1
    set in1_min vid * 0.95
    set in1_max vid * 1.1

    label in2 "+3.3V"
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05

    label in3 "+5V"
    compute in3 1.68 * @ ,  @ / 1.68
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05

    label in4 "+12V"
    compute in4 4.0 * @ , @ / 4.0
    set in4_min 12  * 0.90
    set in4_max 12  * 1.10

    label in5 "-12V (reserved)"
    ignore in5
    compute in5 -@ * 3.97 ,  -@ / 3.97
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10

    label in6 "-5V (reserved)"
    ignore in6
    compute in6 -@ * 1.666 , -@ / 1.666
    set in6_max -5  * 0.95
    set in6_min -5  * 1.05

    label temp1 "M/B Temp"
    set temp1_over 45
    set temp1_hyst 40

    label temp2 "CPU Temp (Intel)"
    #ignore temp2
    set temp2_over 60
    set temp2_hyst 50

    # PWRTMP connector on P4S333, for external sensor
    label temp3 "Power Temp"
    ignore temp3
    set temp3_over 45
    set temp3_hyst 40


    # Used for Athlon diode, ignore for P4S333
    label temp4 "CPU Temp (AMD)"
    set temp4_over 60
    set temp4_hyst 50
    ignore temp4

    label fan1 "CPU Fan"
    set fan1_div 4
    set fan1_min 2000

    label fan2 "Case Fan"
    set fan2_div 4
    set fan2_min 2000

    label fan3 "Pwr Fan"
    set fan3_div 4
    set fan3_min 2000


-- 
The past is history
The future is a mystery
Now is a gift
That's why it's called the present


__________________________________________________________________
Switch to Netscape Internet Service.
As low as $9.95 a month -- Sign up today at http://isp.netscape.com/register

Netscape. Just the Net You Need.

New! Netscape Toolbar for Internet Explorer
Search from anywhere on the Web and block those annoying pop-ups.
Download now at http://channels.netscape.com/ns/search/install.jsp

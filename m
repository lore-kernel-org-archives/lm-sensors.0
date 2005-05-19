From: james@evilpenguin.com (J. Bolt)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <200402020152.11874.james@evilpenguin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040201215112.2227131d.khali@linux-fr.org>
In-Reply-To: <20040201215112.2227131d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

james@plutonium:/usr/src$ sensors
w83l785ts-i2c-1-2e
Adapter: SMBus nForce2 adapter at 5500
temp: 49.00 (temp)
  temp_over: 110.00 (temp_over)

asb100-i2c-1-2d
Adapter: SMBus nForce2 adapter at 5500
VCore 1:   +1.76 V  (min =  +1.63 V, max =  +1.81 V)
+3.3V:     +3.17 V  (min =  +3.12 V, max =  +3.46 V)
+5V:       +4.87 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.49 V  (min = +10.76 V, max = +13.19 V)
-12V:     -12.01 V  (min =  -0.00 V, max =  -0.00 V)
-5V:       -5.04 V  (min =  -0.00 V, max =  -0.00 V)
cpu_fan:  4824 RPM  (min = 1225 RPM, div = 4)
big_fan:  2033 RPM  (min = 1896 RPM, div = 4)
psu_fan:  1722 RPM  (min = 1454 RPM, div = 4)
mb_temp:     +19?C  (high =    +0?C, hyst =    +0?C)
cpu_temp:    +44?C  (high =   +60?C, hyst =   +65?C)
vid:      +1.725 V
alarms:

Patched fine to 2.6.2, seems to work fine. Does rarely show "-1", although I'm 
sure that's the fault of the chip itself.

Many thanks, problem solved :)

J. Bolt

On Sunday 01 February 2004 8:51 pm, you wrote:
> Hi James,
>
> I have a patch for you:
> http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.2-rc3-i2c-w83l785ts-temp-s
>ysfs.diff
>
> It applies against a recent 2.6 kernel and should solve the problem you
> reported in ticket 1552.
>
> If you confirm it works for you, I'll send it to Greg KH for inclusion
> into the Linux kernel tree.
>
> Thanks.


-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.2.4 (GNU/Linux)

mQGiBD7s3PIRBAC2KWjpIG0YfRLgIHUxBrFQmTiIq0yQlaBa7vgjSkKroEtvSjBS
sk5N9NE0y92rGa7C2pfG0w1/rmEghyTLRRfUKyXAnLr/jE6QEnT4yIN+4mRodwZg
bDlSML0AQ09JUv+QBidGtd1kH01lvRdnbCvsMyMNmsp6ryS6pneRKJQ7AwCgyR5I
0rkR4s+sGE3OIfgkw2z5PIUEAKST5r8Lg07T4FSWdOE/EtwX3Xe4vWGBayZKHh0t
A2U8IbaMMLhVHk9g7c3jZ6ptIJqY3yWpp26A+kZNTk53wohnmawtLFEs1HLgFeRc
ppJMNB7TgpyVWUTTYLtZ5GCeA4A67Iq8+CaqX4Tf7Dq1X9dgyUR+b64ajJFd/igt
F/TQA/9zemvSCw1iGgjK+X3WCiAmeYpI9CT6r+XcNkjNI07EpcJyb6upsClLPgqr
Gpc5O6fv+1zmD409xwTi/1QykogkyeYoNbMVnG35ZQ2K5702HA9ZF6lWXLNU3Rho
/q8nRnqgpj8re6koAiQZfNatEAD5x0zktEfWC4N6DQDUCM9RdrQiSmFtZXMgQm9s
dCA8amFtZXNAZXZpbHBlbmd1aW4uY29tPohXBBMRAgAXBQI+7NzyBQsHCgMEAxUD
AgMWAgECF4AACgkQzRkMO5+4Zu3ljQCfVCXWrTxkP1UdtYe+Kfa/4w4h0SAAoI0o
QYXKsXvXHDDw1GgxAD4DvH+1uQENBD7s3PIQBADQkIB2Ml9tAPNOk1BhbdpSF1oM
8XYkHpzA8IviczaDqr/ArSPfbkoxyDr165T+hhqGx+zhQSpJ2re7L4tsLpZvojUW
LEH65rUZ5OJNKUt4ayAM3MFMZFLfZoUSQoqjkZOvJSZQJGCA6lKTtYnLglJdS7vv
DrqZbHjZIqDlCuHkFwADBQQAiuP4Wfmg950F/UJ4zbup5jn/ABnMasUbd3dmnK5F
nNNiWhE7l4/oEh2zgF6g+3qT9s/7m77nn/ccheuA7TTeO82uLiqWdmde8+l+RMpp
rCa4Gr4bAN5OLzr85dcd31mepYw7CmQG3iiKUCHgSxuBvlR8MXWaWnei3VQPCHeo
veqIRgQYEQIABgUCPuzc8gAKCRDNGQw7n7hm7ZQjAJ0faoGh6Eq4WSxYk1xMf4rC
6/IehwCdH/Tq0Yjis8PDCKZiIKJlqHkJfiE=r11q
-----END PGP PUBLIC KEY BLOCK-----


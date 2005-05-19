From: james@evilpenguin.com (J. Bolt)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <200402021247.10079.james@evilpenguin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040201215112.2227131d.khali@linux-fr.org>
In-Reply-To: <20040201215112.2227131d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I applied the patch to 2.6.2-rc3 and wrote a simple perl script to test the 
output of sensors:

Executing 50 tests of diode output
 (Checking every 3 seconds)
[50] +48?C
[49] +51?C
[48] +54?C
[47] +50?C
[46] +51?C
[45] +51?C
[44] +52?C
[43] +49?C
[42] +51?C
[41] +52?C
[40] +50?C
[39] +54?C
[38] +51?C
[37] +56?C
[36] +56?C
[35] +58?C
[34] +56?C
[33] +61?C
[32] +59?C
[31] +58?C
[30] +52?C
[29] +50?C
[28] +51?C
[27] +51?C
[26] +50?C
[25] +51?C
[24] +52?C
[23] +51?C
[22] +50?C
[21] +52?C
[20] +54?C
[19] +51?C
[18] +51?C
[17] +53?C
[16] +54?C
[15] +51?C
[14] +52?C
[13] +52?C
[12] +51?C
[11] +51?C
[10] +51?C
[9] +52?C
[8] +58?C
[7] +58?C
[6] +51?C
[5] +52?C
[4] +51?C
[3] +52?C
[2] +52?C
[1] +50?C

Executing 20 tests of diode output
 (Checking every 1 seconds)
[20] +49?C
[19] +49?C
[18] +48?C
[17] +48?C
[16] +51?C
[15] +51?C
[14] +52?C
[13] +52?C
[12] +51?C
[11] +51?C
[10] +49?C
[9] +49?C
[8] +51?C
[7] +51?C
[6] +49?C
[5] +49?C
[4] +51?C
[3] +51?C
[2] +50?C
[1] +50?C

Hope that's off some use, haven't had any "-1" values,

J. Bolt

On Monday 02 February 2004 10:06 am, you wrote:
> [Please CC: the mailing-list on reply.]
>
> Quoting myself:
> > We usually ignore read errors in chip drivers because they are rare,
> > but since it happens so frequently with that specific chip, we will
> > have to do it here. I will try to implement the solutions listed
> > above, if you want to help me test them.
>
> Here is a patch, tested to apply and compile on Linux 2.6.2-rc3. Could
> you please give it a try? It should solve the rare "-1" readings
> problem, as well as possible misdetection issues.
>
> If the driver is really unable to read a register value, it will
> silently return the previously known value (or 0 if it doesn't have one
> yet). Maybe we could log the incident, although I'm fairly certain it
> will never happen, providing the number of max retries is high enough
> (I set it to 5 for now).
>
> Thanks.

=== diode-test.pl ==
#!/usr/bin/perl -w

$LOOP = 20;
$SLEEP = 1;

sub read_sensor()
{
    $SENSOR = `sensors w83l785ts-i2c-1-2e | grep 'temp:'`;
    $SENSOR =~ /[\^\:]+[\s]+([^\s]+)/;
    return $1;
}

print "Executing " . $LOOP . " tests of diode output\n";
print " (Checking every ".$SLEEP." seconds)\n";

while ($LOOP) {
    print "\[".$LOOP."\] " . read_sensor() . "\n";
    sleep($SLEEP);
    $LOOP--
}

=========

-- 
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


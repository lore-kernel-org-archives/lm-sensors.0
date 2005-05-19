From: james@evilpenguin.com (J. Bolt)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <200402021717.01304.james@evilpenguin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040201215112.2227131d.khali@linux-fr.org>
In-Reply-To: <20040201215112.2227131d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Monday 02 February 2004 1:12 pm, you wrote:
> Quoting "J. Bolt" <james@evilpenguin.com>:
> > I applied the patch to 2.6.2-rc3 and wrote a simple perl script to
> > test the  output of sensors:
> >
> > Executing 50 tests of diode output
> >  (Checking every 3 seconds)
> > [50] +48?C
> > [49] +51?C
> > [48] +54?C
> > [47] +50?C
> > [46] +51?C
> > [45] +51?C
> > [44] +52?C
> > [43] +49?C
> > [42] +51?C
> > [41] +52?C
> > (...)
>
> Looks good. The rather fast variations are expected since the thermal
> diode is inside the CPU itself.
>
> > Executing 20 tests of diode output
> >  (Checking every 1 seconds)
>
> Note that the driver caches the data for 2 seconds anyway, so you can't
> see changes faster than that. This explains why you see pairs of
>

That was the idea :)

> identical values in the following list:
> > [20] +49?C
> > [19] +49?C
> > [18] +48?C
> > [17] +48?C
> > [16] +51?C
> > [15] +51?C
> > [14] +52?C
> > [13] +52?C
> > [12] +51?C
> > [11] +51?C
> > (...)
> >
> > Hope that's off some use, haven't had any "-1" values,
>
> Thanks for testing. Since the new driver hides the errors as it
> "corrects" them, there's no easy way to know how useful the improved
> (or should I call it insisting) read method is. I really think we
> should make it more verbose.
>
> Could you please apply the attached patch (on top of the previous one)
> and recompile the w83l785ts driver with DEBUG enabled? No need to
> recompile the whole kernel, just updating the w83l785ts module should
> do it. Running your test script should then trigger the debug log (and
> possibly the error log but I doubt it). I wonder how frequently the
> retry will be necessary, and wether you'll sometimes need more than one
> retry.

Ok, I've patched the module again and adapted the script a bit - adding 
timestamps & debug log retrieval.

I have uploaded the first output with 2 seconds between execution to:
      http://james.evilpenguin.com/sensors/

I thought 1000 executions would be sufficient unless you think I need to run 
it longer or for a specified period of time?

>
> I would appreciate it much if you could let your script run long enough
> to have some solid statistics about the phenomenon.
>
> Thanks.

I think the log files it produces are pretty self explanatory, it'll highlight 
an error w/ (ERROR) etc.

Will upload the rest as it finishes executing them,


James Bolt

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


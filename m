From: james@evilpenguin.com (J. Bolt)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: [PATCH 2.6] Handle read errors in w83l785ts
Message-Id: <200402031740.09409.james@evilpenguin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040202225211.40740d70.khali@linux-fr.org>
In-Reply-To: <20040202225211.40740d70.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've uploaded some execution logs to:

  http://james.evilpenguin.com/sensors/i2cdelay_test/

I've started testing using sleep values of 3 & 5 seconds

There seems to be a noticable decrease in the number of errors by eliminating 
the read delay (45 compared to 191 with i2c_delay(3*i))  using a 3 second 
sleep value. However, as you said, this could be completely random. It might 
be advisable to run some more tests with the same parameters to confirm a 
decrease in the number of retry errors. Note that those figures also don't 
include multiple errors that occur in succession.

Filenames and directory structure of i2cdelay_test should again be pretty self 
explanatory.

It's not really much of burden, it doesn't require many system resources and 
most of it can be automated and run in the background.

> The driver seems to work pretty well the way it is now,
> so you are invited to decline unless you are looking for new ways to
> waste your time or are yourself interested by the experiment.

Well it doesn't really waste much of my time, so why not? :P  No harm in 
seeing if it can't be a little more efficient.

Will upload the rest of the logs as it churns them out. 

JB

On Tuesday 03 February 2004 10:16 am, you wrote:
> Hi James,
>
> Your great perl script gave me an idea. Maybe it would be interesting
> to alter the delays between reads when errors occur. For now I used a
> short incremental delay (i, where i is the retry count). Other choices
> are possible though:
> * no delay at all (remove i2c_delay())
> * incremental, bigger delay (say i2c_delay(4*i))
> * constant delay (say i2c_delay(5))
>
> If you have some spare time and can do some additional experiments with
> some of these settings, it would be great. My goals are to lower the
> probablity of 2 or more retries needed, and, if possible, to also lower
> the probability of a first retry being needed.
>
> My only fear is that the randomness could be too high for us to
> conclude.
>
> Anyway, my request is mostly the expression of the scientific mind
> sleeping in me. The driver seems to work pretty well the way it is now,
> so you are invited to decline unless you are looking for new ways to
> waste your time or are yourself interested by the experiment.
>
> Thanks.

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

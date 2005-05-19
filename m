From: james@evilpenguin.com (J. Bolt)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <200402022123.45714.james@evilpenguin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040201215112.2227131d.khali@linux-fr.org>
In-Reply-To: <20040201215112.2227131d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Monday 02 February 2004 8:40 pm, Jean Delvare wrote:
> > Ok, I've patched the module again and adapted the script a bit -
> > adding timestamps & debug log retrieval.
>
> You're quite good at Perl, aren't you? :)
>

Wish I could be good at C++ :P

> > I have uploaded the first output with 2 seconds between execution to:
> >       http://james.evilpenguin.com/sensors/
> >
> > I thought 1000 executions would be sufficient unless you think I need
> > to run it longer or for a specified period of time?
>
> No, it's perfect.
>
> Strange that the number of errors varies so much between the three runs,
> with no obvious logic.
>

A result that goes hand in hand with the unpredictable nature of the 
motherboard itself :/

> Here are the stats:
> Immediate success: 85.5%
> Success after 1 retry: 10.4%
> Success after 2 retries: 0.9%
> Success after 3 retries: 0.03%
>
> The high ratio of non-immediate successes clearly shows that the new
> read method is welcome. The fact 3 retries were necessary only once out
> of 3000 reads shows that setting max_retries to 5 isn't a bad choice. I
> think we can leave it this way.
>
> I'm pretty happy with the results and think of sending the patch to Greg
> KH for inclusion into Linux 2.6, if it's OK for you too. I also plan to
> backport the changes to our CVS (Linux 2.4 compatible) driver.
>

Excellent.

> Thanks a lot for the great testing of my code. You'll got credits.

No problem, relieved some boredom. I'm sure many other A7N8X users out there 
will be pleased to see it supported, regardless of how accurate/useful it 
actually is. 

Thanks for the patches.

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

From: james@evilpenguin.com (J. Bolt)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH 2.6] Handle read errors in w83l785ts
Message-Id: <200402102218.07974.james@evilpenguin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040202225211.40740d70.khali@linux-fr.org>
In-Reply-To: <20040202225211.40740d70.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Sorry for the delay - have been preparing for holiday and sorting out 
university places.

Anyway...

On Saturday 07 February 2004 14:59, Jean Delvare wrote:
> > I've uploaded some execution logs to:
> >
> >   http://james.evilpenguin.com/sensors/i2cdelay_test/
> >
> > I've started testing using sleep values of 3 & 5 seconds
>
> I downloaded them and tried to make some stats. I could hardly come to a
> conclusion so far. See below.
>
> > There seems to be a noticable decrease in the number of errors by
> > eliminating the read delay (45 compared to 191 with i2c_delay(3*i))
> > using a 3 second sleep value.
>
> I think you mean i2c_delay(i). No test was run with 3*i AFAIK.
>

Indeed I did, probably got confused w/ the sleep time.

> The no_delay version may have less errors, but the retries breakdown
> doesn't please me much:
> 1 retry:   46
> 2 retries:  8
> 3 retries:  5
> 4 retries:  3
> 5 retries:  2
>
> No other test needed more than 3 retries. If you count the total
> additional delay, the no_delay version has slightly more (128 for 1000
> runs, 124 for i2c_delay(i)). Not significant.
>
> > However, as you said, this could be completely random. It might be
> > advisable to run some more tests with the same parameters to confirm
> > a decrease in the number of retry errors.
>
> I saw you did it. Looks like the results differ much between two series
> with the same settings. This means that our tests aren't realy reliable.
>
> > Note that those figures also don't include multiple errors that occur
> > in succession.
>
> Correct. Not only that, but I have noticed another strange thing. Maybe
> you'll be able to explain it to me. When no message is logged, you seem
> to assume that it means that syslogd is not repeating the previous
> message. I would then expect a "Repeated N times" message with N being
> equal to the number of messageless runs + 1. This isn't always the case.
> Also, I'd expect at least "Updating w83l785ts data." each time. Why is
> it that when errors occur, this message doesn't show?
>
> Isn't it possible to temporary configure syslogd so that it logs all
> messages without trying to limit the amount of messages written?
>

It is, yes. I really should have thought about reconfiguring it. At the time I 
guess I thought it wasn't necessary because I was just looking for errors 
(restricting its output shouldn't make an impact on errors recorded, should 
it?) and not for success.

> BTW, why do you check the log after each command, instead of parsing it
> after all the runs?
>

That might have been more sensible, especially if I'd filtered the log to 
eliminate all messages bar those related to sensors. Or perhaps I could have 
just generated a large array of execution timestamps to retrieve 
afterwards... Regardless, it was considerably easier to automate it this way 
at the time, and I couldn't see any major disadvantages provided I 
accomodated for read/write delays properly - even if it was a bit of a dirty 
hack.

> One strange thing is that the number of times where one retry is needed
> varies so much. I'd understand that our delay policy changes how many
> retries are needed. I can't get how it would change the number of
> "first" errors.
>
> To me, this means that these stats don't help much. There are too many
> things we don't control or don't understand, generating too much noise,
> so we can't conclude :( For one thing, we don't know how frequently the
> BIOS (if that is it) accesses the chip, nor if this frequency depends on
> something (the temperature, for example).
>
> So I think I'll leave things the way they are now, since my original
> policy doesn't seem to be any worse than the others.
>
> If you want to play more with it, do as you wish, but frankly I don't
> think it's worth it.
>

Well I think I'll have to agree with you, although to be honest I'd have a 
hard job disagreeing really. I think the benefits of trying to tweak the 
driver are nullified by Asus' unwillingness to tell us anything about it.

That said, maybe I will do some extra tweaking in a few weeks just to get some 
more refined data. 

Although, I'd be lying if I said it wasn't a little monotonous...

> Thanks a lot for the tests anyway. I realized that I forgot to mention
> your name in the driver. Sorry for that, I'll send a patch to Greg KH in
> a while to fix that.

No problem, I see the patch has made it into 2.6.3-rc2 :)

It was nice to have made some kind of contribution,

JB


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

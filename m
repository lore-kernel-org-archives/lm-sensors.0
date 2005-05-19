From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: [PATCH 2.6] Handle read errors in w83l785ts
Message-Id: <20040207155926.3b34fdc0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040202225211.40740d70.khali@linux-fr.org>
In-Reply-To: <20040202225211.40740d70.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've uploaded some execution logs to:
> 
>   http://james.evilpenguin.com/sensors/i2cdelay_test/
> 
> I've started testing using sleep values of 3 & 5 seconds

I downloaded them and tried to make some stats. I could hardly come to a
conclusion so far. See below.

> There seems to be a noticable decrease in the number of errors by
> eliminating the read delay (45 compared to 191 with i2c_delay(3*i)) 
> using a 3 second sleep value.

I think you mean i2c_delay(i). No test was run with 3*i AFAIK.

The no_delay version may have less errors, but the retries breakdown
doesn't please me much:
1 retry:   46
2 retries:  8
3 retries:  5
4 retries:  3
5 retries:  2

No other test needed more than 3 retries. If you count the total
additional delay, the no_delay version has slightly more (128 for 1000
runs, 124 for i2c_delay(i)). Not significant.

> However, as you said, this could be completely random. It might be
> advisable to run some more tests with the same parameters to confirm
> a decrease in the number of retry errors.

I saw you did it. Looks like the results differ much between two series
with the same settings. This means that our tests aren't realy reliable.

> Note that those figures also don't include multiple errors that occur
> in succession.

Correct. Not only that, but I have noticed another strange thing. Maybe
you'll be able to explain it to me. When no message is logged, you seem
to assume that it means that syslogd is not repeating the previous
message. I would then expect a "Repeated N times" message with N being
equal to the number of messageless runs + 1. This isn't always the case.
Also, I'd expect at least "Updating w83l785ts data." each time. Why is
it that when errors occur, this message doesn't show?

Isn't it possible to temporary configure syslogd so that it logs all
messages without trying to limit the amount of messages written?

BTW, why do you check the log after each command, instead of parsing it
after all the runs?

One strange thing is that the number of times where one retry is needed
varies so much. I'd understand that our delay policy changes how many
retries are needed. I can't get how it would change the number of
"first" errors.

To me, this means that these stats don't help much. There are too many
things we don't control or don't understand, generating too much noise,
so we can't conclude :( For one thing, we don't know how frequently the
BIOS (if that is it) accesses the chip, nor if this frequency depends on
something (the temperature, for example).

So I think I'll leave things the way they are now, since my original
policy doesn't seem to be any worse than the others.

If you want to play more with it, do as you wish, but frankly I don't
think it's worth it.

Thanks a lot for the tests anyway. I realized that I forgot to mention
your name in the driver. Sorry for that, I'll send a patch to Greg KH in
a while to fix that.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

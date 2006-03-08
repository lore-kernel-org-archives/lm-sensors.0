From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 08 Mar 2006 13:13:30 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <2x0f2iyN.1141823610.7958370.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

On 2006-03-07, Rudolf Marek wrote:
> This patch adds the voltage alarms support into W83627EHF.

Only voltages? I'd prefer a patch adding all alarms support, it
wouldn't be much larger, and would make things easier for me and the
users.

Also, I see that you adopted my proposal for standard alarms
representation. As much as I enjoy it, merging it right now wouldn't be
very fair to Hans de Goede, whose proposal is still being discussed.

For these two reasons, I won't accept your patch right now. If you want
to help Hans and me solve the standard alarms interface problem, you
could prepare two patches implementing alarms, one following my proposal
(basically the patch you just posted, plus temperatures and fans) and
one following Hans' proposal. We could then compare them on a technical
basis, and you could also give us your opinion as a driver author.

As far as I am concerned, I have finished an experimental patch
implementing my proposed alarms and beeps interface for the w83627hf
driver (this adds to the f71805f, lm63 and lm90 I had done earlier) and
have gathered some numbers about the four drivers.

The only data I am missing now is the memory used by each additional
sysfs file we create. We need to know, as Hans objected that too many
sysfs files could have a negative impact on memory consumption. I dug
down the sysfs code yeterday evening to find out, but didn't find what
I was looking for yet. I hope to get the answer this evening.

Thanks,
--
Jean Delvare


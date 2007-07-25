From: "Jean Delvare" <khali@linux-fr.org>
Date: Wed, 25 Jul 2007 09:51:42 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-lm78-detect-isa-with-chipid-0x20.patch
Message-Id: <nSazR1k9.1185357102.8260940.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A670C0.2020403@hhs.nl>
In-Reply-To: <46A670C0.2020403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 7/24/2007, "Hans de Goede" <j.w.r.degoede@hhs.nl> wrote:
>Here is a small but important bugfix to the lm78 driver. I found out about
>this problem because a Fedora user filed a bug that the lm78 driver no
>longer worked on his system:
>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id$9428
>
>The problem is that sometime ago the isa lm78 detection was made more
>stringent and this new code now checks the chip-id, but does not accept
>a chip-id of 20h, however a chip-id of 20h is valid, and is excepted in
>the main probe function of the driver, see line 551. This fixed also
>makes the isa detection code accept the chip-id of 0x20 fixing this
>issue.
>
>Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Acked-by: Jean Delvare <khali@linux-fr.org>

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

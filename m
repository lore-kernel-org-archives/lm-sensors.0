From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: New chip driver development plan to Lm_sensors
Message-Id: <ytlSfcC9.1100767259.3782120.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
In-Reply-To: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Quoting Mark D. Studebaker:

> If the 792 is a Super I/O chip, I strongly recommend that you start from
> our w83627hf.c driver rather than the w83781d.c driver. If it is i2c/isa,
> the w83781d.c driver is the best place to start.

From previous reports from users, I suspect that the W83792D is not a
Super-I/O chip (the location it appears at on the Winbond website seems
to confirm that) but more likely an SMBus device, like the W83791D is.
In fact the 792D seems to be an evolution of the 791D. Of course a
datasheet for the 792D would help much. I guess that Huang can confirm
that, or tell me if I got it wrong?

As a side note, I noticed that the w83781d driver in Linux 2.6 doesn't
support the W83791D chip. Thus I would propose that Huang starts a new
driver for the W83792D, even if it is based of the w83781d.c code, and,
if the 791D and 792D are mostly compatible as I suspect, include support
for the 791D to the new driver, so that we can remove it from the
w83781d driver. This has two advantages:
1* Better symmetry between 2.4 and 2.6.
2* The new driver would be I2C only so cleaner and smaller.

Huang:

We never received your original post. It could have been caught by the
spam filter we run to protect the mailing-list. The best thing you can
do to ensure it won't happen with later posts is to avoid sending HTML
mails to the list. Plain test mails are way less likely to be mistaken
as spam.

Don't bother with a driver ID, they are more or less deprecated and
never used anyway. You can simply omit the .id field in the driver
structure.

Keep us informed of the evolution of your work, and let us know if you
have questions we can help with!

Thanks,
--
Jean

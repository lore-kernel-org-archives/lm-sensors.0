From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 19 Oct 2005 22:46:48 +0000
Subject: [lm-sensors] feedback request: i2c bus and v4l driver for
Message-Id: <20051019224642.7f798690.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <opsik3vcn0bj4yoq@mailhost.ics.ele.tue.nl>
In-Reply-To: <opsik3vcn0bj4yoq@mailhost.ics.ele.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Szymon,

> Is this what you meant ?
> http://www.ics.ele.tue.nl/~sbiegans/spase.diff

Yes, this is. Even better would be to post it to the list directly
(preferably inline, if your mail client doesn't break the layout).
Bonus points if you include a diffstat output.

A quick look at the patch reveals that you are not respecting the
kernel coding style (indentations must be made using tabs, not spaces),
so you'll want to fix this before posting to the list.

-- 
Jean Delvare

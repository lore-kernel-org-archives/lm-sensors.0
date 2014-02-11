From: Laszlo Papp <lpapp@kde.org>
Date: Tue, 11 Feb 2014 03:13:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Rename the device ids to contain the hwmon suffix
Message-Id: <CAOMwXhPTkrUUaUL-H_0fvZBO9_kt4jqKXs5BJYthDfu0_1c3xg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392045953-26596-1-git-send-email-lpapp@kde.org>
	<20140210160842.GB26997@lee--X1>
	<20140210173811.04ba5964@endymion.delvare>
In-Reply-To: <20140210173811.04ba5964@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: Lee Jones <lee.jones@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org

On Mon, Feb 10, 2014 at 4:38 PM, Jean Delvare <jdelvare@suse.de> wrote:
> Additionally, dashes are explicitly forbidden in hwmon
> device names.

Also, where is that documented?

I do not think you can make such a decision, and you will realize that
once you begin to think a bit out of the box and look around. See how
other children are managed for MFD devices. "driver-subsystem" is a
pretty common a schema. I do not really see any point in forbidding
dashes currently. Please do elaborate about the reasons, and the fact
that why it is undocuemented.

Also, I currently do not understand what you are suggesting: just
leave this technically unreasonable situation as is for compatibility
reasons? There is no better support in place for appending further
alternative names?

In any case, at the very least, I hope the lesson is learnt for the
future from this past mistake. If a chip is MFD'ish, a subdevice
driver should not ever be added with such an id.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

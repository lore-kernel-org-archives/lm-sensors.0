From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Date: Thu, 03 Oct 2013 15:52:54 +0000
Subject: [lm-sensors] jc42: rfc - alert support
Message-Id: <2300ADBB-ED1D-4538-9523-3E76A9E4E8C4@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi guys,

I'm considering adding support for the alert callback in the jc42.c driver. My
current application involves SE98 chips which support window and critical
checking with interrupt/smbalert.

I would like to use the smb alert. I see that jc42.c goes as far as programming
the min, max and crit values in the chip, but the chip's comparator is never
enabled nor is there an alert callback installed when the driver is registered
with i2c core.

I would have expected this functionality to be already implemented and am weary
as to why it's not.

Is there any context or fore-notion I should know about before diving into an
implementation? Am I just being paranoid or is there greater forces at play
here?

Thanks for the help!


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

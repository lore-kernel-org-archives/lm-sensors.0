From: matejken@gmail.com (Matej Kenda)
Date: Wed, 28 Feb 2007 15:57:33 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <df4ec9600702280757k46608a35g4db2eef1f6ca1b23@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2007/2/28, Hans-J?rgen Koch <hjk at linutronix.de>:
> I added these changes. If you modprobe max6650 without any parameters, the
> driver makes no changes to the chip's configuration. With one or more
> parameter, you can change whatever you like. I think this is a good solution
> because it doesn't assume there's a BIOS that does what you want.
>
> Please test, review, comment...

Well done, Hans!

This version of the driver works well on my ARM-based system.

Regards,

Matej

-- 
Matej Kenda, Senior Software Engineer
HERMES SoftLab d.d. (www.hermes-softlab.com), Slovenia

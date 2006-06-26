From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 26 Jun 2006 20:39:07 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <20060626223907.f315fc30.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brian,

> I've been working on a driver for the chip, but I can't get it to
> interface with sensors. I have it reading from the registers correctly,
> and I used a printk statement to make sure that the driver was reading,
> and storing the values correctly, but when I run sensors it doesn't
> print out anything. I based the code off of your lm63 driver. The driver
> does initialize, and detect. Would you like to look at it, and how woule
> you like me to send it? I have a couple things to fix with temperature
> calculation, hyst, and min, and max, but I first want to get it to talk
> to userland software.

If you want "sensors" to display anything for your chip, you must add
support for it to libsensors, and to sensors itself. You must also make
sure that you register your driver with the hwmon class.

You are welcome to post your code on this list, as a -p1 patch against
either Linus' or Andrew's tree. You can post the patch either inline
(if your mailer can do this properly) or as an attchement (type
text/plain) so that we can comment on it and help you.

-- 
Jean Delvare


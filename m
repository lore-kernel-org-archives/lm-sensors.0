From: anything@daanwillems.nl (Daan Willems)
Date: Mon, 03 Jul 2006 12:20:58 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS
Message-Id: <44A90BAA.4040300@daanwillems.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A87466.9020002@winbond.com>
In-Reply-To: <44A87466.9020002@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Juan,

> For "sensors" to display the voltages, Daan will need the SVN version
> of lm_sensors. 2.10.0 didn't have support for them.
> 
> The easiest way to verify if the patch itself worked, is to check
> manually in /sys/class/hwmon/hwmon0/device/. If you have the in* files,
> it's OK.

Thanks for the remark! That indeed seems the case, as I do have the in* 
files there ;) I am using 2.10.0-7 lm-sensors, as currently provided in 
Debian etch/testing. Thanks a lot for the support!
Daan


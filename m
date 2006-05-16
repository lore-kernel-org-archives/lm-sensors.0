From: millerlf@telus.net (lloyd)
Date: Tue, 16 May 2006 06:06:55 +0000
Subject: [lm-sensors] user prog sensors seg faults
Message-Id: <44696BFF.2080305@telus.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <445F4C46.8000800@telus.net>
In-Reply-To: <445F4C46.8000800@telus.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali at linux-fr.org> wrote:

| Does "sensors -c /dev/null" crash too? If it does, it means that the
| configuration file is not reponsible.

yes it does.

|
| Which hardware monitoring drivers are used?
|
| Output of:
| /sbin/lsmod | grep hwmon
| cat /sys/class/hwmon/hwmon*/device/name

lloyd at wsiopt64:~> sensors -c /dev/null
Segmentation fault
lloyd at wsiopt64:~> /sbin/lsmod | grep hwmon
hwmon                  19848  1 smsc47b397
lloyd at wsiopt64:~> cat /sys/class/hwmon/hwmon*/device/name
smsc47b397
lloyd at wsiopt64:~> 

I havnt seen any docs mentioning this chip, Is it even supported at all?

|
| If there are more than one driver, please try each driver individually
| to see if the crash is related a given driver.


Just the one.




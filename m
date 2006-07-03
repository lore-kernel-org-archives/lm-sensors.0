From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 03 Jul 2006 22:03:08 +0000
Subject: [lm-sensors] AMD K8 digital temperature sensor
Message-Id: <44A9941C.4020106@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

After new specs was released. I discovered that even older AMD K8 have digital
temperature sensor.

http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
(page 177)

I created a device driver for that
http://assembler.cz/download/amd_digital_temp.tar.gz

You need to have AMD K8, up to four different temps can be monitored
two in one core...

The driver will create new hwmon device. No userspace support yet.
If someone with dual core would test it - I'm interested in results.
cat /sys/class/hwmon/hwmon1/device/temp*
ls /sys/class/hwmon/hwmon1/device/temp*
cat /proc/cpuinfo

(replace 1 with correct number please)

"Many thanks" goes to Jean, helping me a lot hunting nasty bugs ;)

Regards
Rudolf


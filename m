From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 06 Jul 2006 00:55:33 +0000
Subject: [lm-sensors] AMD K8 digital temperature sensor
Message-Id: <44AC5F85.50705@jellyfish.highlyscyld.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A9941C.4020106@sh.cvut.cz>
In-Reply-To: <44A9941C.4020106@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Very cool.

My initial tests on Red Hat failed because they don't have HWMON in the 
kernel yet. So I tried a beta of SLES 10 and it compiled and loaded just 
fine. I found the temperature files under:

> /sys/class/hwmon/hwmon?/device/temp?_input


This system has single core CPU's but there were two hwmon devices 
(hwmon0, hwmon1) each with a temp1_input. (Perhaps that's because I 
didn't apply the kernel patch?)

This system also has IPMI (rather than lm_sensors.. :( ) so I plotted 
the new readings against the IPMI readings. For one CPU the digital 
sensor is higher, for the other it's lower...

http://www.mindspring.com/~ppokorny/temps-k8.png

Do the data sheets mention if these values are on the "Tcontrol" scale 
or are they supposed to be accurate measurements? Do they need to be 
adjusted by the CPU Tcontrol offsets?

Awesome,
:v)

-- 
Philip Pokorny, Director of Engineering, RHCE
Tel: 415-370-0835   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com


Rudolf Marek wrote:

>Hello all,
>
>After new specs was released. I discovered that even older AMD K8 have digital
>temperature sensor.
>
>http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
>(page 177)
>
>I created a device driver for that
>http://assembler.cz/download/amd_digital_temp.tar.gz
>
>You need to have AMD K8, up to four different temps can be monitored
>two in one core...
>
>The driver will create new hwmon device. No userspace support yet.
>If someone with dual core would test it - I'm interested in results.
>cat /sys/class/hwmon/hwmon1/device/temp*
>ls /sys/class/hwmon/hwmon1/device/temp*
>cat /proc/cpuinfo
>
>(replace 1 with correct number please)
>
>"Many thanks" goes to Jean, helping me a lot hunting nasty bugs ;)
>
>Regards
>Rudolf
>
>_______________________________________________
>lm-sensors mailing list
>lm-sensors at lm-sensors.org
>http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>  
>




From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 07 Jul 2006 15:59:45 +0000
Subject: [lm-sensors] AMD K8 digital temperature sensor
Message-Id: <4dfa50520607070859u5f0593d2n386439d4a9405561@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A9941C.4020106@sh.cvut.cz>
In-Reply-To: <44A9941C.4020106@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> After new specs was released. I discovered that even older AMD K8 have digital
> temperature sensor.
>
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
> (page 177)
>
> I created a device driver for that
> http://assembler.cz/download/amd_digital_temp.tar.gz
>
> You need to have AMD K8, up to four different temps can be monitored
> two in one core...
>
> The driver will create new hwmon device. No userspace support yet.
> If someone with dual core would test it - I'm interested in results.
> cat /sys/class/hwmon/hwmon1/device/temp*
> ls /sys/class/hwmon/hwmon1/device/temp*
> cat /proc/cpuinfo


I'll attempt to apply this to my kernel tonight. I have an Athlon 64
X2, so I can give you dual-core results. The temperatures reported by
the W83627EHF have puzzled me, because I thought I was getting two
readings from the CPU. Why is that?

>
> (replace 1 with correct number please)
>
> "Many thanks" goes to Jean, helping me a lot hunting nasty bugs ;)

David


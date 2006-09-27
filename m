From: r.marek@assembler.cz (Rudolf Marek)
Date: Wed, 27 Sep 2006 06:20:51 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <451A1843.6090509@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Thanks for the test. It is cool but it does not work ;)

> Doesn't seem to work here with a Core2 Duo 6400 and kernel 2.6.18:
> 
>   cat /sys/class/hwmon/hwmon1/device/temp1_input
> 0

Ehm.


Please add this two printk to this code:

              data->therm_status = eax;
              printk("EAX from  MSR %x\n", eax);

                 /* update only if data has been valid */
                 if (eax & 0x80000000) {
			printk("in temp condition\n");

Run it again, to see the 0 but check the log...

Thanks,

regards
Rudolf


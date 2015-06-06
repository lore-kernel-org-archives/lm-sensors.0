From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Jun 2015 15:01:53 +0000
Subject: Re: [lm-sensors] Parallella board temperature sensing
Message-Id: <55730B61.2030207@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJ3iQcr8cSEB_vYYR2_0H-Am0wYstQvtfzHJcVgMsdcWzFn=VA@mail.gmail.com>
In-Reply-To: <CAJ3iQcr8cSEB_vYYR2_0H-Am0wYstQvtfzHJcVgMsdcWzFn=VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/06/2015 07:51 AM, Gergely Imreh wrote:
> Hi,
>
> I was checking out what would it take to support lm-sensors on the
> Parallella board[1]. It's an interesting little board with a dual core
> Xilinx ARM Cortex-A9, an FPGA, and a 16-core Epiphany co-processor.
> It's Xilinx XADC sensor used for temperature/voltage sensing does not
> seem to be anywhere on the lm-sensors supported device list. Currently
> users seem to monitor it through reading the device data directly from
> the /sys entries and doing the necessary scaling and conversion (as it
> was discussed on the Parallella forums, bash script included[2])
>
> In a nutshell, the data is accessible through
> /sys/bus/iio/devices/iio:device0/in_temp0_{raw,offset,scale} files.
> There are also 8 voltage readings there that could be extracted.
>

If it is supported through iio, it should be possible use the iio->hwmon
bridge.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: atis@mikrotik.com (Atis Elsts)
Date: Mon, 20 Jun 2005 08:50:16 +0000
Subject: [lm-sensors] Ticket 2005
Message-Id: <200506200952.21964.atis@mikrotik.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506161659.57761.atis@mikrotik.com>
In-Reply-To: <200506161659.57761.atis@mikrotik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 16 June 2005 17:42, Jean Delvare wrote:
> Hi Atis,
>
> On 2005-06-16, Atis Elsts wrote:
> > Nevermind about that support ticket. "modprobe lm85
> > force_emc6d102=1,0x2e" did the trick. Perhaps the lm85 driver did not
> > detect my chip correctly.
>
> Can you please send the output of:
>
> i2cdump 1 0x2e b
Uhm. I'm confused here, because i2cdump and i2cdetect says:
"Error: Could not open file `/dev/i2c-1': No such device"

I did run mkdev.sh script and created those files before:
# ls -l /dev/i2c-*
crw-------    1 0        0         89,   0 Jun 20 09:45 /dev/i2c-0
crw-------    1 0        0         89,   1 Jun 20 09:45 /dev/i2c-1
crw-------    1 0        0         89,   2 Jun 20 09:45 /dev/i2c-2
crw-------    1 0        0         89,   3 Jun 20 09:45 /dev/i2c-3
crw-------    1 0        0         89,   4 Jun 20 09:45 /dev/i2c-4

>
> If possible, try to physically identify the chip for confirmation.
>
It's EMC6D103-CK.
In lm85.c there is, however, driver only for emc6d102. I choose it as closest 
match to the name :)

> Thanks,
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 24 Feb 2015 13:21:53 +0000
Subject: Re: [lm-sensors] Test with Chip IT8620E on a Gigabyte GA-H97M-HD3 version 2
Message-Id: <20150224142153.13fcf158@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU436-SMTP1351904A8E5B1CC00D893290240@phx.gbl>
In-Reply-To: <BLU436-SMTP1351904A8E5B1CC00D893290240@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Cedric,

On Wed, 11 Feb 2015 01:25:34 +0100, cedric wrote:
> Thank for your works.
> 
> modeprobe it87 option force_id=0x8728
> 
> On a Gigabyte GA-H97M-HD3 with chip IT8620E

Thanks for the report. Just a few comments:

> chip "coretemp-isa-0000"
> 
> # ark.intel.com
> # maxi 72 degrees C
> 
> label temp1 "CPU Temp"
> compute temp1  @ + 10, @ / @ - 10
> compute temp2  @ + 10, @ / @ - 10
> compute temp3  @ + 10, @ / @ - 10

Which CPU model is this? If the coretemp driver doesn't get TjMax
right, it should be fixed.

> # FAN
> 
> label fan1 "CPU Fan"
> set fan1_min 700
> compute fan1 1.17 * @, @ / 1.17

Most certainly wrong (scaling is never needed for fan speed) unless the
IT8620E uses a different clock frequency than all other chips. Rather
unlikely if you ask me. So I think your fan has some form of automatic
speed control, either integrated or done by the chipset, and it spins
faster in the BIOS simply because the CPU is busier in the BIOS. If I am
correct then just put some load on the CPU under Linux and you'll get
the same fan speed as in the BIOS without the compute statement above.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

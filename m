From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Dec 2009 09:50:16 +0000
Subject: Re: [lm-sensors] Temperature for AMD Phenum ll X4 955 with
Message-Id: <20091214105016.0cacb13d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <e37498430912050507t7324549du284eaf9c046a58d@mail.gmail.com>
In-Reply-To: <e37498430912050507t7324549du284eaf9c046a58d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nima,

On Sat, 5 Dec 2009 16:37:35 +0330, nima chavooshi wrote:
> First of all thanks for your efforts on lm-sensor
> I recently bought and AMD Phenum ll X4 955 with motherboard MSI 790FX-GD70.
> I have some widget on KDE that show temperature for GPU and CPU, but these
> widgets can not display for CPU.
> What module should I install for get information about temperature of my CPU
> ? Of course I have run sensor-detects script and have got this result :
> *Driver `to-be-written':
>   * Chip `AMD K10 thermal sensors' (confidence: 9)
>   * ISA bus, address 0x600
>     Chip `Fintek F71889FG Super IO Sensors' (confidence: 9)
> 
> Note: there is no driver for AMD K10 thermal sensors yet.*
> 
> May any one guide me for address this problem ?

There will be a new driver in kernel 2.6.33 for this CPU family. Until
it gets merged, the patch is there:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-k10temp-new-driver.patch

Support for the F71889FG was merged last week:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;hv69896f499e1bce5cfb38f2685ff583ecdb24dd

So you'll need kernel 2.6.33 for this system, once it is released (in
~3 months.) If you have the possibility to test the drivers before that
and to report, that would be great.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

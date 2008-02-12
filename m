From: MillTek <mill.tek@verizon.net>
Date: Tue, 12 Feb 2008 16:13:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1026) Properly terminate sysfs
Message-Id: <47B1C5C0.4010902@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <86802c440802092355l7393fe07gfbd021e9cef66181@mail.gmail.com>
 <20080210171004.GB25353@kroah.com>	<20080210190115.2ebd4124@hyperion.delvare>
 <86802c440802111539w7eeb84dcu97103733364f7a7b@mail.gmail.com>
 <20080212092722.32c30eac@hyperion.delvare>	<20080212152715.GB19441@kroah.com>
 <20080212163733.461a8684@hyperion.delvare>
In-Reply-To: <20080212163733.461a8684@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,
Kernel 2.6.24 for my distro (Arch Linux) came out in the last few days. 
My board has a Fintek F1882g chip. It means that I can finally get 
voltage and fan speeds for the board, so thanks for that.  I am 
wondering how I correctly calculate the correct offset and factors for 
the voltage numbers? This is what GKrellm says;

Vcor1  1.66  factor 1 offset 0
Vcor2  1.24  factor 1 offset 0
+3.3v   2.83  factor 3  offset 0
+5v      4.82  factor 4.98 offset 0
+12v    3.84 factor 4.0  offset 0
-12v    -4.35  factor -4.0 offset 0
-5v      -1.51  factor -1.667 offset 0
in7      1.66    factor 1  offset 0
in8       1.54   factor 1 offset 0

If there's a website that I should visit can anyone supply a link??


Jim

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 29 Jul 2015 08:52:44 +0000
Subject: Re: [lm-sensors] external binary tool or lib / Smart Embedded Management Agent - ADLINK Technology
Message-Id: <20150729105244.62cb1720@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAVZOXu=83X+iEG7QMZg_f_f=JKJvNZM3t9H8TPSuzv21OY1Sw@mail.gmail.com>
In-Reply-To: <CAAVZOXu=83X+iEG7QMZg_f_f=JKJvNZM3t9H8TPSuzv21OY1Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 29 Jul 2015 09:35:57 +0200, Thomas Roos wrote:
> Hello,
> i use a Bay Trail E3825 ETX module. Problem is that the 5V is not
> connected to the Winbond w83627dhg chip. It's only available via SEMA
> (Smart Embedded Management Agent - ADLINK Technology link:
> http://www.adlinktech.com/PD/web/PD_detail.php?pid42# ). A binary
> tool or library.
> But I want to use the 5V measurement value in lm-sensors environment
> (alarming, range).
> Can you give me any advice how to solve this?
> I was thinking of writing a kernel module, but I think it's a bit oversized.
> Is there any possibility to get values from tools or libs without a
> bus, chip into lm-sensors?

No, libsensors only reads from sysfs and "sensors" only gets the
information from libsensors. We currently do not support reading from
other sources.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

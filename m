From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 Jan 2014 08:21:00 +0000
Subject: Re: [lm-sensors] sensors
Message-Id: <20140123092100.6fbee0d5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0207072332570.12801-100000@ond.vein.hu>
In-Reply-To: <Pine.LNX.4.21.0207072332570.12801-100000@ond.vein.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 23 Jan 2014 02:57:37 -0500, Ryan wrote:
> hello jean,
> 
> I don't see anything unusable when I run lspci.
> 
> $ lspci
> (...)
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Park [Mobility Radeon HD 5430/5450/5470]
> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI
> Audio [Radeon HD 5400/6300 Series]

Looks good indeed. Maybe a bug in lshw then - if this is reproducible.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

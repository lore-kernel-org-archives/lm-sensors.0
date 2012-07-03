From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 Jul 2012 13:37:27 +0000
Subject: Re: [lm-sensors] Cannot monitor fan
Message-Id: <20120703153727.69c778d7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMcsHH1FV2K9mpe4yNybo7jOf1r0pVVhNFrjvZTaLOijwwQqhA@mail.gmail.com>
In-Reply-To: <CAMcsHH1FV2K9mpe4yNybo7jOf1r0pVVhNFrjvZTaLOijwwQqhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 3 Jul 2012 09:13:47 -0400, Vahid Keykhaey wrote:
> Dear Reader,
> I have an Asus P8Z77-V motherboard with an Intel Core i7 2600 Processor,
> and I am working on my M.Sc. thesis. In order to Implementing my project, I
> need to monitor CPU temperature, and that is why I need to use LM-Sensors,
> but I do not know why my installed LM-Sensors does not monitor fan speed,
> and it only gets me the temperatures.
> I am using Ubuntu 12.04 with kernel version of 3.2.0.23.

Most likely because ACPI gets in the way:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

But it's hard to tell for sure given that you did not provide any
technical information. We don't know what you tried, and we don't know
what the result was. Did you run sensors-detect? What did it find? Any
error in the kernel log when loading the recommended drivers?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

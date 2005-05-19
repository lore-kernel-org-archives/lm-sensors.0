From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: interface changes in linux 2.6, lm_sensors 2.8.8
Message-Id: <20040921213949.4109e67f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040916123814.M40115@linux-fr.org>
In-Reply-To: <20040916123814.M40115@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > The FSC Hermes doesn't have PWM capabilities as far as I know. I
> > wonder what made you think it could have.
> 
> Are you sure?  Try 'grep pwm kernel/chips/fscher.c' in 2.4/CVS and
> same in 2.6.9.  Actually, the 2.4/CVS and 2.6.9 drivers don't look
> similar at all.

I admit it is strange. It seems to mix the concepts of min and pwm. The
SUMMARY and fscher doc files don't mention PWM at all.

Attached is the datasheet for the FSC Hermes if you want to take a look.
I'm really too busy these days to go through it, sorry.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: FSC-Hermes-1.00.pdf
Type: application/x-pdf
Size: 116859 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040921/14f33d2e/FSC-Hermes-1.00.bin

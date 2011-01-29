From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 Jan 2011 20:31:04 +0000
Subject: Re: [lm-sensors] Fluctuating min/max/div causing alarms
Message-Id: <20110129213104.0dec3de8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik+SWY4Ka8oCH+rcApNsd6DufNriKR2f6hFYCkJ@mail.gmail.com>
In-Reply-To: <AANLkTik+SWY4Ka8oCH+rcApNsd6DufNriKR2f6hFYCkJ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 29 Jan 2011 12:18:31 -0800, Dylan wrote:
> On Sat, Jan 29, 2011 at 12:11 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > Never use native hwmon drivers together with IPMI. They access the same
> > device in a non-synchronized manner, resulting in reads from / write to
> > the wrong register. The problem your describe is most certainly caused
> > by this. If your system uses IPMI, don't load native hwmon drivers.
> 
> Thanks for your quick response. Your idea of conflicting reads/writes sounds
> very plausible.
> So, with UNRAID I am no explicitly loading any hwmon drives or IPMI drivers.

You certainly do, as the w83627ehf driver (native hwmon driver) does
not load automatically. Most likely, you ran sensors-detect, and it
detected the chip and created a configuration file for you. As I am not
familiar with UNRAID, you'll have to figure out by yourself which
configuration file mentions the w83627ehf driver, and remove it. It's
certainly somewhere under /etc, so a brutal:
# grep -r w83627ehf /etc
might answer the question.

> Can you give me a pointer as to how I might resolve this conflict?

As you are apparently using IPMI on this machine, the best solution is
to not load the w83627ehf driver. Which unfortunately means no
integration with libsensors-based monitoring applications, but IPMI
support comes at this price for the time being.

> Is this an issue as how I've modified sensors3.conf or something more
> fundamental with kernel modules?

This is related to kernel modules, yes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

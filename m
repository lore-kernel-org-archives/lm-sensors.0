From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 Jan 2011 20:11:20 +0000
Subject: Re: [lm-sensors] Fluctuating min/max/div causing alarms
Message-Id: <20110129211120.0c690898@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik+SWY4Ka8oCH+rcApNsd6DufNriKR2f6hFYCkJ@mail.gmail.com>
In-Reply-To: <AANLkTik+SWY4Ka8oCH+rcApNsd6DufNriKR2f6hFYCkJ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dylan,

On Sat, 29 Jan 2011 11:54:47 -0800, Dylan wrote:
> Hello all.
> 
> I've done my best so far to solve my problems with information available but
> I've hit a rut and I'm hoping I can get help here.
> 
> I have a SuperMicro X8SIL-F motherboard with a WinBond W8367DHG sensor chip.
> The CPU is an Intel Xeon X3440 running stock at 2.53GHz.
> I am running UNRAID v4.7 which is based on Slackware kernel 2.6.32
> This came with sensors v3.0.3 and libsensors v3.0.3.
> 
> I have tweaked my sensors3.conf based on comparable systems as well as the
> thresholds specified via the boards IPMI interface.
> 
> PROBLEM: Upon booting the sensors readout displays reasonable values and all
> the min/max values are as I set them. No ALARMs visible.
> Within hours (minutes?) various min/max values change causing the reasonable
> voltage/rpm/temp to now be out of range... resulting in ALARMs being raised.
> 
> QUESTION: What is causing, say, the VBAT min value to suddenly change from
> my setting of +2.82V to 0V? Or the min RPM for HD FAN 2 to change from
> 400RPM to 0RPM?
> 
> Simply executing "sensors -s" again changes the values back and clears the
> ALARMs, but this is not feasible to do this multiple times per day after
> confirming the ALARMs are false.

Never use native hwmon drivers together with IPMI. They access the same
device in a non-synchronized manner, resulting in reads from / write to
the wrong register. The problem your describe is most certainly caused
by this. If your system uses IPMI, don't load native hwmon drivers.

> On a slight aside, I am unable to set the div values on my fans and the
> associated /sys/class/hwmon4/device/fanX_div files are read-only.

This is by driver design, the w83627ehf driver tries to be smart and to
pick the best clock divider value for you automatically.

> As these values change causing ALARMs to be thrown in the sensors output,
> there is no related events in the IPMI sensor logs.
> 
> Any help appreciated!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

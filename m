From: prakash@punnoor.de (Prakash Punnoor)
Date: Sun, 27 Aug 2006 14:31:05 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <200608271631.05532.prakash@punnoor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Sonntag 27 August 2006 14:47 schrieb Jean Delvare:
> Hi Prakash,
>
> > > Well, the question is, do the voltage values reported by "sensors"
> > > increase again if you stop underpowering your system? If they do,
> > > obviously that's your business and I couldn't care less ;)
> >
> > No they dont. eg:
> > VCore:     +1.23 V  (min =  +0.00 V, max =  +4.08 V)
> >
> > Bios shows 1.35V, so clearly the voltages are off.
>
> We now have evidences that the BIOS adds arbitrary constants to the
> measured voltages (150 mV for Vcore.) This explains the differences.
> What we don't know is, why the BIOS does this. At any rate the driver
> is correct and doesn't need to be fixed. You can add offsets in
> sensors.conf to match the BIOS readings if you want.

Yes, I did it now:
    compute in0  @+0.15, @-0.15
    compute in1  @+0.1, @-0.1
    compute in3  ((6.8/10)+1)*@+0.2 , (@-0.2)/((6.8/10)+1)
    compute in4  ((30/10)+1)*@+0.4  , (@-0.4)/((30/10)+1)

Now the values match BIOS values. The only problem is I needed to adjust 
gkrellm by hand, as well...but at least now everything looks reasonable. :-)

> > > I generated a new version of my it87 patch, which should report fan
> > > speeds properly:
> >
> > Yes, looks better now. Maybe you want to lower the fan limits, as well?
> >
> > fan1:      830 RPM  (min = 3245 RPM)                   ALARM
> > fan2:        0 RPM  (min = 3245 RPM)                   ALARM
> > fan3:      782 RPM  (min =    0 RPM)
>
> Aha, maybe _you_ want to lower the fan limits ;) Adjust the values in
> sensors.conf and run "sensors -s" to apply the changes.

Ok, I did it now. :-)

Thanks again,
-- 
(?=                 =?)
//\ Prakash Punnoor /\\
V_/                 \_V
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060827/dae1fb2b/attachment.bin 

From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 07 Apr 2006 11:47:04 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add w83791d support
Message-Id: <20060407134704.10ab52ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
In-Reply-To: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

> Thanks for taking the time to look this over. I long ago learned the
> value of code reviews and got another reminder on this one  :)

I'm doing my best with the little time I have now... I know there are
several drivers waiting for me to review them, but I just can't do
everything at once.

> > In a more general way, you may want to take a look at the recent
> > changes which were made to the w83792d driver, and see if they could
> > apply to your code too.
>
> I'll grab an older kernel tree and compare this file with a recent git
> tree. Are there more changes that are not yet in git20 that I should
> be aware of? Should I be comparing against a different tree (like the
> -mm tree) or is there a special lmsensor archive/tree?

Well you can use the web interface to git to get the history of the
w83792d driver:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/hwmon/w83792d.c

As for the pending patches, there's only one I am aware of, and I
already pointed you to it if I remember correctly:
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/i2c/hwmon-w83792d-quiet-on-misdetection.patch

> > +       for (i = 0; i < 2; i++) {
> > +               device_create_file(dev, &sda_beep_ctrl[i].dev_attr);
> > +       }
> >
> > You could use ARRAY_SIZE(sda_beep_ctrl) instead of hardcoding 2. This
> > is easier to understand for the reader, and more robust to future
> > changes too. I'm not sure if this array really adds anything though.
>
> It seemed like the array structure "grouped" things a bit and provided
> some consistency given all the other "groups" were now arrays
> (voltage, fan, temp). I can go either way on this if you have a
> preference.

No strong preference, do it the way you want.

> > > +     temp2_cfg = w83791d_read(client, W83791D_REG_TEMP2_CONFIG);
> > > +     temp3_cfg = w83791d_read(client, W83791D_REG_TEMP3_CONFIG);
> > > +     w83791d_write(client, W83791D_REG_TEMP2_CONFIG, temp2_cfg & 0xe6);
> > > +     w83791d_write(client, W83791D_REG_TEMP3_CONFIG, temp3_cfg & 0xe6);
> >
> > What are these doing? This needs a comment. Also note that you could do
> > with a single temporary variable (or even without one.)
>
> It is making sure the two temp sensors are enabled while preserving
> the reserved bits (the w83792 driver is doing this also). If you reset
> the chip the HW takes care of this. Guess I can remove the code and
> assume the BIOS is doing the right thing when reset=0...

See my other post (answering to Yuan) for this.

> > * sensors-detect needs to be updated, as for now it points the W83791D
> > owners to the w83781d driver regardless of the kernel version. Patch
> > anyone?
>
> Yes, it detects the w83791d correctly and tells you to load the w83781d driver:
> 
> Driver `w83781d' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at 0540'
>     Busdriver `i2c-i801', I2C address 0x2c (and 0x48 0x49)
>     Chip `Winbond W83791D' (confidence: 7)
> 
> I haven't looked at that code/scripts, but I can update depending on
> how you want to handle it (check for 2.4 vs. 2.6 and output as
> appropriate?)

I haven't look in deep either, but I remember that we have a similar
case for one SiS SMBus driver: it's named i2c-sis645 on Linux 2.4 and
i2c-sis96x on Linux 2.6, and we have some code to pick the right driver
depending on the kernel version. So let's do it the same way for the
W83791D case and it should be fine.

Thanks,
-- 
Jean Delvare


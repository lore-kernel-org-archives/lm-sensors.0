From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 10 Jun 2013 07:18:35 +0000
Subject: Re: [lm-sensors] lsensors3.conf for ASRock K7VT2
Message-Id: <20130610091835.5cf357df@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201306071429.42740.marcus@localhost>
In-Reply-To: <201306071429.42740.marcus@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcus,

Please keep the list in Cc.

On Sun, 9 Jun 2013 22:32:42 +0200, Marcus Roeckrath wrote:
> Hi Jean,
> 
> Am Sonntag, 9. Juni 2013 21:04 schrieb Jean Delvare:
> 
> Because I do not have an wiki account I added a new version of the 
> conf-file to this mail.
> 
> > > # Sample configuration for ASRock K7VT2
> > >
> > > chip "w83697hf-*"
> > > set beep_enable 0
> >
> > Why? We normally don't touch beep_enable in the configuration files we
> > put in the wiki.
> 
> Removed.
> 
> > > #compute in5 (5.14 * @) - 14.91 , (@ + 14.91) / 5.14
> > > #compute in5 (3.14 * @) - 7.71 , (@ + 7.71) / 3.14
> 
> Typo should be in6.

Indeed.

> > > compute in5 -((28/10)+1)*@ , -@/((28/10)+1)
> >
> > If you are sure the last in5 formula is right, you should remove the
> > other two.
> 
> I added these line because they are the original compute lines for the 
> w83697hf Chip from the sensors.conf.eg sample file in the 
> lm-sensor-source-archive.
> 
> But they did not work on my K7VT2 board; Using these lines for the negative 
> Voltages they are displayed around +1V. resp. +2 V.
> 
> Therefor I took the compute lines for the positive voltages for the 
> negative voltages also to get plausible values.

Yes, the sample configuration file uses the formula from the Winbond
W83697HF datasheet, but some board makers prefer to use inverters rather
than reference voltages. This could be the case on the K7VT2.

However the old MBM init file I have here has slightly different
scaling factors: 3.78 (instead of 3.8) for -12V, and 1.575 (instead of
1.68) for -5V. You may want to try these and see if you get values
closer from what the BIOS displays.

> > > compute in6 -((6.8/10)+1)*@ , -@/((6.8/10)+1)
> 
> I think a user of the K7VT2 sample configuration should be told that there 
> is a difference in the negative compute lines between the standard of the 
> w83697hf chip and its implementation on this board.
> 
> I have added a comment to the sample configuration to explain this.
> 
> > > compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)
> >
> > How did you find / validate the compute formulas ?
> 
> in7 is from the sample configuration for the w83697hf.
> 
> For in6 see my comments above.
>
> > > set in0_min 1.5 * 0.95
> > > set in0_max 1.65 * 1.05
> > > set in2_min 3.3 * 0.9
> > > set in2_max 3.3 * 1.1
> > > set in3_min 5 * 0.95
> > > set in3_max 5 * 1.05
> > > set in4_min 12 * 0.9
> > > set in4_max 12 * 1.1
> >
> > The ATX specification says the positive voltage inputs should be within
> > a +/- 5% margin, not 10% as you used for +3.3V and +12V
> 
> Corrected.

in4_min was still wrong, I fixed it.

> > > ignore fan2
> >
> > Does the board have a System Fan header? If it does then we don't want
> > this ignore statement in the configuration file that will go on the
> > wiki, we want a label statement instead.
> 
> Corrected; the board has an chassis fan connector which isn't connected on 
> my system.

OK, thanks for checking. I've lowered fan2_min because it is frequent
to have low speed chassis fans.

> Thanks for publishing in the wiki.

Done, thanks for your contribution.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

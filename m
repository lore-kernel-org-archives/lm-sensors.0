From: Ymu@Winbond.com.tw (Ymu@Winbond.com.tw)
Date: Fri, 07 Apr 2006 08:25:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add w83791d support
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE0100EBC1@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
In-Reply-To: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

Thanks for your hardwork first:)
 i have one question about your mail.
 
> > > +     temp2_cfg = w83791d_read(client, W83791D_REG_TEMP2_CONFIG);
> > > +     temp3_cfg = w83791d_read(client, W83791D_REG_TEMP3_CONFIG);
> > > +     w83791d_write(client, W83791D_REG_TEMP2_CONFIG, 
> temp2_cfg & 0xe6);
> > > +     w83791d_write(client, W83791D_REG_TEMP3_CONFIG, 
> temp3_cfg & 0xe6);
> >
> > What are these doing? This needs a comment. Also note that 
> you could do
> > with a single temporary variable (or even without one.)
> >
> It is making sure the two temp sensors are enabled while preserving
> the reserved bits (the w83792 driver is doing this also). If you reset
> the chip the HW takes care of this. Guess I can remove the code and
> assume the BIOS is doing the right thing when reset=0...
> 

I dont like this "reset" or "init", i would like to drop this parameter
and do nothing about temp2,temp3 configuration.
because we may lose MB specific configuration if we reset the chip,
What's your opinion?

Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.


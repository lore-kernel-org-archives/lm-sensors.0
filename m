From: bezaur@gmail.com (Charles Spirakis)
Date: Thu, 24 Aug 2006 17:21:59 +0000
Subject: [lm-sensors] [PATCH] Update lm_sensors to handle more of the
Message-Id: <5bfe43f80608241021s3f22c13ge514c78a11b7453c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
In-Reply-To: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Beeping on "enable bit" means that the enable bit position in the document
turned on the beep noise vs. "alarm bit" which tries using the alarm bit
position. So it sounds like you are confirming the documentation is correct.

Thanks!

-- charles


On 8/24/06, Sven Anders <anders at anduras.de> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Charles Spirakis schrieb:
> > I wrote an ugly little python script to cause each alarm to trigger
> > one at a time (I can provide it if anyone is interested). Based on the
> > script, what I found was that the documentation was completely correct
> > for the values I tested (in0-9, temp1-3, fan1-5). My board doesn't
> > have the pwm stuff and the driver doesn't have that support, so I
> > didn't validate the tart1-3 alarms/enables, but since everything else
> > was correct, it seems likely those are as well.
> >
> > Sven - Can you confirm this result?
>
> Hello Charles!
>
> I can confirm in1 and temp3, but for in7/in8 the beeps comes on the first
> "enabling beep"...
>
> Hope this helps.
>
> Regards
> Sven
>
> - --8X-------------------------------------------------------------------
>
> me-fw-int-01:/root # ./check_beep.py
>
>        in0_input: alarm: 0x000001 enable: 0x000001
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>        in1_input: alarm: 0x000002 enable: 0x002000 <= mismatch
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
> due to misatch, enabling beep via alarm bit for 10 seconds
> disabling beep via alarm bit
>        in2_input: alarm: 0x000004 enable: 0x000004
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>        in3_input: alarm: 0x000008 enable: 0x000008
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>        in4_input: alarm: 0x000100 enable: 0x000100
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>        in5_input: alarm: 0x000200 enable: 0x000200
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>        in6_input: alarm: 0x000400 enable: 0x000400
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>        in7_input: alarm: 0x080000 enable: 0x010000 <= mismatch
> enabling beep via enable bit for 10 seconds   ** <= here it beeps!
> disabling beep via enable bit
> due to misatch, enabling beep via alarm bit for 10 seconds
> disabling beep via alarm bit
>        in8_input: alarm: 0x100000 enable: 0x020000 <= mismatch
> enabling beep via enable bit for 10 seconds   ** <== here it beeps!
> disabling beep via enable bit
> due to misatch, enabling beep via alarm bit for 10 seconds
> disabling beep via alarm bit
>        in9_input: alarm: 0x004000 enable: 0x004000
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>      temp1_input: alarm: 0x000010 enable: 0x000010
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>      temp2_input: alarm: 0x000020 enable: 0x000020
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>      temp3_input: alarm: 0x002000 enable: 0x000002 <= mismatch
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
> due to misatch, enabling beep via alarm bit for 10 seconds
> disabling beep via alarm bit
>       fan1_input: alarm: 0x000040 enable: 0x000040
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>       fan1_input: alarm: 0x000040 enable: 0x000040
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>       fan2_input: alarm: 0x000080 enable: 0x000080
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>       fan3_input: alarm: 0x000800 enable: 0x000800
> enabling beep via enable bit for 10 seconds
> disabling beep via enable bit
>       fan4_input: alarm: 0x200000 enable: 0x200000
> enabling beep via enable bit for 10 seconds  ?? <== Strange beep here!
> disabling beep via enable bit
>       fan5_input: alarm: 0x400000 enable: 0x400000
> enabling beep via enable bit for 10 seconds
> skipping tart1_input, enable bit is 18 (262144 = 0x040000)
> skipping tart2_input, enable bit is 19 (524288 = 0x080000)
> skipping tart3_input, enable bit is 20 (1048576 = 0x100000)
> skipping case_open, enable bit is 12 (4096 = 0x001000)
> skipping user_enable, enable bit is 23 (8388608 = 0x800000)
>
>
> - --
> Sven Anders <anders at anduras.de>                 () Ascii Ribbon Campaign
>                                                  /\ Support plain text
> e-mail
> ANDURAS service solutions AG
> Innstra?e 71 - 94036 Passau - Germany
> Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90
> 50-55
>
> Rechtsform: Aktiengesellschaft - Sitz: Passau - Amtsgericht Passau HRB
> 6032
> Mitglieder des Vorstands: Sven Anders, Marcus Junker, Michael Sch?n
> Vorsitzender des Aufsichtsrats: Dipl. Kfm. Thomas Tr?ger
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2.1 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQFE7bLG5lKZ7Feg4EcRApgwAJ9/SdxWJi3ebaMXaTlkiJWPNTtIDwCeOnwD
> GtCbEfQGpGUy2FGc40nSdJs> =La5G
> -----END PGP SIGNATURE-----
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060824/6c4713b1/attachment-0001.html 

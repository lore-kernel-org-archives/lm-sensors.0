From: Matt Roberds <mattroberds@cox.net>
Date: Thu, 14 Aug 2008 16:03:49 +0000
Subject: Re: [lm-sensors] Problems with a MSI K8T Neo2 v2.0 (wrong voltages
Message-Id: <Pine.LNX.4.64.0808141049310.22323@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <7641eb8f0808081145q3ad0208ftaa94915e52e0043@mail.gmail.com>
In-Reply-To: <7641eb8f0808081145q3ad0208ftaa94915e52e0043@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 Aug 2008, Beth wrote:
> Well guys, more news, in my noisy desesperation I installed WinXP to
> see if SpeedFan would control the fan speed, and no luck, it also
> fails doing it.

I don't know if this is exactly the motherboard you have, but other
people seem to claim that SpeedFan can adjust the fans on an MSI
"MS6702E (K8T Neo2-FIR)", per
http://www.almico.com/foruminfo.php?idH79216 .

If MSI provides a Windows utility to monitor or control the fan speed,
you might try that.  If their own utility can't do it, then either it
can't be done, or you will probably have to get the fix from MSI.

You might also want to see if MSI has any BIOS updates for your
motherboard.  If they provide multiple versions of the BIOS, and if you
are running the latest one, you might consider going back to a slightly
older version.  This may affect other things, but at least you may be
able to tell if the fans can be controlled at all.

Do you have a different fan you can try?  You shouldn't remove the CPU
fan, but you can temporarily replace the case/system fan with another
one - even one that won't actually fit in your case - just to see if its
speed can be controlled.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

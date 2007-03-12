From: matejken@gmail.com (Matej Kenda)
Date: Mon, 12 Mar 2007 13:22:56 +0000
Subject: [lm-sensors] Patch to fix attaching HWMON devices on I2C-PXA
Message-Id: <df4ec9600703120622t16dfcfces8b7370ee3cdcddeb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <df4ec9600703120109j6cb1c848q54cc7c286b3dfaeb@mail.gmail.com>
In-Reply-To: <df4ec9600703120109j6cb1c848q54cc7c286b3dfaeb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

2007/3/12, Jean Delvare <khali at linux-fr.org>:
> >
> > I have fixed the problem and posted the patch to ARM Linux patch database.
> >
> > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idB46/1
>
> Thanks for the heads up. Your patch looks OK. Note though that I cannot
> push this patch to mainline myself, as it touches arm-specific
> structures and as such might need to be synchronized with other
> arm-specific patches. So your patch will have to go through the arm
> tree.

Thanks for feedback. I have sent the e-mail to lm-sensors mailing list
to be aware of the bug and patch that fixes it.

I have exchanged a few e-mails with Russell King on ARM Linux mailing
list to make the fix properly. I have also modified the patch to be
ready for 2.6.21.

I guess it is up to Russel's patch processing schedule to get it included.

Regards,

Matej

-- 
Matej Kenda, Senior Software Engineer
HERMES SoftLab d.d. (www.hermes-softlab.com), Slovenia


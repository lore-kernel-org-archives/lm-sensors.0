From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 21 Sep 2006 18:22:17 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <4dfa50520609211122u46b1cd5drf0b595db3e3e0f32@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Was: Re: P5B mobo

Hi Mr. Green,

Be sure to include lm-sensors at lm-sensors.org in the email conversation.

> Hi David,
>
> I am having issues with my Asus P5B mobo sensors, understand you have a
> patch that may work
>
> What output, information  etc .. do you need ? I would like to help out...

The patch is here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-September/017625.html

It won't apply to a stock kernel, because it depends on patches in the
-mm kernel. But look at the bottom of the page:
http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/b139bc4d/attachment-0001.obj

Download the link to linux/drivers/hwmon/w83627ehf.c, and it has the
patch applied to it. Michael Nelson has compiled it and it worked for
him. I'd be interested to know if it works for you.

> I have same issue with my mobo but I use a patched
> 2.6.18-rc6 at the moment so have dvd drive working

Remember that the w83627ehf.c above has not been accepted into the -mm
kernel source. I am working on Super-I/O locks and should have an
updated patch ready soon. So although the file will provide useful
information, and should work on your mobo, it is broken in several
ways. (One is that it doesn't correctly support early revs of the EHF
chip.) When support for your motherboard and the w83627dhg chip is
ready in the mainline kernel, discard the w83627ehf.c file from here.

HTH,
David


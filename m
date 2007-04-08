From: =?iso-8859-15?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Sun, 08 Apr 2007 09:26:02 +0000
Subject: Re: [lm-sensors] What about i2c_smbus_read_block_data() ?
Message-Id: <200704081126.02563.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704042149.21264.hjk@linutronix.de>
In-Reply-To: <200704042149.21264.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Am Sonntag 08 April 2007 10:58 schrieb Jean Delvare:

>
> I have a different variant of this patch in my local tree, which takes
> the i2c-core changes that happened in the meantime into account. I'm
> attaching it to this post if someone want to take a look and/or
> comment.=20

Looks allright to me.

> In fact I think I'll schedule this patch for merge into 2.6.22=20
> regardless of the state of the lm93 driver patch.=20

Good idea. I will submit a first version of the LM93 patch next Thursday
or Friday. It's ready, but I cannot test it until then.

> I'm a bit tired to=20
> have to maintain that patch off-tree and to see people waste their time
> wondering where that function has gone, searching the mailing list for
> explanations, finding the patch and resubmitting it. We all have better
> things to do.

I second that.

>
> Anyway, the key point for Hans-J=FCrgen is: you can assume that function
> i2c_smbus_read_block_data() will be available to you when your lm93
> driver patch is merged upstream.

Fine.

Thanks,
Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 13 Dec 2006 17:49:01 +0000
Subject: [lm-sensors] W83627DHG
Message-Id: <4dfa50520612130949p68ff4249k535f0696081ccc54@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520611191948n5e7d40e3gac33afcfeb5dd640@mail.gmail.com>
In-Reply-To: <4dfa50520611191948n5e7d40e3gac33afcfeb5dd640@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dezheng,

Yes! That is a great idea. I can accept the motherboard + processor,
and I do have DDR2 RAM. So this is a good way to verify the 627DHG
driver, especially as we are working on several features including
SuperIO locking. You will also be pleased to know that I have
submitted a final patch for review, so the 627DHG driver will be
released very soon now. (Once the patch is approved by Jean Delvare, I
will be announcing it to all those who have expressed an interest in
testing the new driver, and I will CC you on that announcement.)

I like in the United States, for shipping purposes.

Thanks for your support!
David

P.S. There is a request on lm-sensors to backport the driver to the 2.4 kernel:

>   As to the backports to PREVIOUS kernels like Red Hat Advanced server
> (Linux 2.4 kernel), it is OUR (Winbond) responsibility, not yours. Your
> job is to look forward to NEWER Linux releases and WE (Winbond) will
> take care of the backport.

I will be sure to coordinate with you (Winbond) when we start
backporting the driver.

On 12/13/06, DZShen at winbond.com <DZShen at winbond.com> wrote:
> Hi David:
>   Good news to lm-sensors!
>
>   Just ended one conversation on the phone and the engineer planned to
> work on 627DHG is moved to another tight-schedule project so that my
> boss is willing to donate one ASUS 627 DHG motherboard with Intel Duo 2
> processor to sponsor your work on 627DHG.
>
>   Are you willing to take this offer?
>
>   ASUS P5B motherboard + Intel Duo 2 processor, this motherboard comes
> with DDR2 RAM so that you need DDR2 RAM to make this motherboard work.
> If you don't have DDR2 RAM, please let me know immediately so that I can
> talk to my boss again.
>
>   If you accept this offer, I would like to ask you to do us a favor.
>   Once there is a NEW Linux kernel release, could you help verify
> lm-sensors 627DHG driver on this motherboard we donate? There is no
> tight schedule on when you have to verify lm-sensors 627DHG once a NEW
> Linux kernel is released but it would be great if you can do the
> verification work when you get a change.
>
>   As to the backports to PREVIOUS kernels like Red Hat Advanced server
> (Linux 2.4 kernel), it is OUR (Winbond) responsibility, not yours. Your
> job is to look forward to NEWER Linux releases and WE (Winbond) will
> take care of the backport.
>
>   I am a bridge between Winbond and lm-sensors group so that I will
> think carefully about who to do what and to be fair to both sides. If
> you find anything which is unfair to you, please let me know.
>
>   The 2006 budget year is coming to an end so that you have to response
> me quickly in order to meet our Winbond internal budget schedule because
> I persuaded my boss to use the R&D budget left in 2006 to donate ASUS
> motherboard and Intel Duo 2 processor.
>
> Thank you for your work on lm-sensors 627DHG driver
>
> dz


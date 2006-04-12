From: bezaur@gmail.com (Charles Spirakis)
Date: Wed, 12 Apr 2006 17:30:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add w83791d support
Message-Id: <5bfe43f80604121030q2d3a62dex929ac7c628dec694@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
In-Reply-To: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Will do.

I'll start work on the user-mode patch for detection and the per-file
alarm patches now that this is done.

Thanks for your eyes and your time!

-- charles


On 4/11/06, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Charles,
>
> > Add support for the w83791d sensor chip. The w83791d hardware is
> > somewhere between the w83781d and the w83792d and this driver code
> > is derived from the code that supports those chips.
>
> Applied, thanks. Good work!
>
> Any future changes to the driver should be sent as incremental patches.
>
> --
> Jean Delvare
>


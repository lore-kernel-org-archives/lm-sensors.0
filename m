From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Dec 2012 15:17:55 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.8
Message-Id: <CA+55aFwvVPV2amFN=oDfBgp_CZCFTifgf3J_Wh9vEPHtQ2Mv2Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121219223353.7b671d1f@endymion.delvare>
In-Reply-To: <20121219223353.7b671d1f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 20, 2012 at 1:26 AM, Jean Delvare <khali@linux-fr.org> wrote:
>
> At first I thought that this was caused by me using diff option -d when
> generating the patch originally. However dropping it did change the
> output but still did not lead to what I get when pulling from git.
>
> So I can only suspect that the differences were somehow reformatted by
> the git instance on kernel.org.

All diffing is done at run-time, so it's always the local version that matters.

And it does look like this is one of the fairly rare cases where the
git version matters (probably because the XDL_NEED_MINIMAL flag got
dropped due to some excessive CPU use in extreme cases). I notice that
"git diff --patience" gives something much closer to your local
result.

           Linus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

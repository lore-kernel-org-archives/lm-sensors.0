From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sat, 28 May 2005 11:57:50 +0000
Subject: [lm-sensors] PATCH libsensors: ds1780 fix
Message-Id: <82fg91lkkhcs3h0k3evll898c42dtpnf0p@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ebf911gp0e3p9u82e78a758o7v4o623hr@4ax.com>
In-Reply-To: <2ebf911gp0e3p9u82e78a758o7v4o623hr@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sat, 28 May 2005 11:38:42 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>> This patch removes separate ds1780 defines and links them instead 
>> to adm9240 as is done for LM81 register compatible.  Compile tested
>
>Looks sane, applied, thanks. You forgot to remove all the defines in
>chips.h, I did it. I also edited the comments, the library really
>doesn't care that the chips are register compatible. What matters here
>is that the chips expose the same feature set.

Thank you, that's great.  I look again tomorrow at sensord issue...

On bright side, user base for driver just doubled :)

--Grant.


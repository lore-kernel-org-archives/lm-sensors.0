From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sat, 28 May 2005 01:46:59 +0000
Subject: [lm-sensors] PATCH libsensors: ds1780 fix
Message-Id: <p6cf91576g6s8810lmkbme769hb83r644t@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ebf911gp0e3p9u82e78a758o7v4o623hr@4ax.com>
In-Reply-To: <2ebf911gp0e3p9u82e78a758o7v4o623hr@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

More info,
On Sat, 28 May 2005 09:35:55 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:
>
>This patch removes separate ds1780 defines and links them instead 
>to adm92450 as is done for LM81 register compatible.  Compile tested

Sent patch to user for confirmation as it applies cleanly to 2.9.1, 
will advise user response.

--Grant.

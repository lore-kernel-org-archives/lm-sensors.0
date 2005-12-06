From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Tue, 06 Dec 2005 08:19:56 +0000
Subject: [lm-sensors] [PATCH 2/3] w1 : move master and slave code into
Message-Id: <20051206081956.GA27786@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512051011q2dc21d45l8998f40d3cae1803@mail.gmail.com>
In-Reply-To: <808c8e9d0512051011q2dc21d45l8998f40d3cae1803@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 05, 2005 at 12:11:32PM -0600, Ben Gardner (gardner.ben at gmail.com) wrote:
> Move w1 bus master code into 'w1/masters' and move w1 slave code into
> 'w1/slaves'.
> 
> Signed-off-by: Ben Gardner <bgardner at wabtec.com>

>  drivers/w1/Kconfig                |   60 --
>  drivers/w1/Makefile               |   10 
>  drivers/w1/ds_w1_bridge.c         |  174 --------
>  drivers/w1/dscore.c               |  795 --------------------------------------
>  drivers/w1/dscore.h               |  166 -------
>  drivers/w1/masters/Kconfig        |   38 +
>  drivers/w1/masters/Makefile       |   11 
>  drivers/w1/masters/ds_w1_bridge.c |  174 ++++++++
>  drivers/w1/masters/dscore.c       |  795 ++++++++++++++++++++++++++++++++++++++
>  drivers/w1/masters/dscore.h       |  166 +++++++
>  drivers/w1/masters/matrox_w1.c    |  247 +++++++++++
>  drivers/w1/matrox_w1.c            |  247 -----------
>  drivers/w1/slaves/Kconfig         |   38 +
>  drivers/w1/slaves/Makefile        |   12 
>  drivers/w1/slaves/w1_ds2433.c     |  329 +++++++++++++++
>  drivers/w1/slaves/w1_smem.c       |   71 +++
>  drivers/w1/slaves/w1_therm.c      |  268 ++++++++++++
>  drivers/w1/w1_ds2433.c            |  329 ---------------
>  drivers/w1/w1_smem.c              |   71 ---
>  drivers/w1/w1_therm.c             |  268 ------------
>  20 files changed, 2152 insertions(+), 2117 deletions(-)

I failed to apply this one:
...
patching file drivers/w1/matrox_w1.c
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file
drivers/w1/matrox_w1.c.rej
...
patching file drivers/w1/dscore.c
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file
drivers/w1/dscore.c.rej
...
patching file drivers/w1/w1_ds2433.c
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file
drivers/w1/w1_ds2433.c.rej

Everything except this seems OK, so I will clean this moving up and push
it upstream.

Thank you.

-- 
	Evgeniy Polyakov


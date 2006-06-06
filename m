From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 06 Jun 2006 21:02:17 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <4dfa50520606061402t67abf0a4j83ace567887b21e1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Okay, I will test this and get back to you tomorrow.

Thanks,
David

On 6/6/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> Hello
>
> This patch adds long-awaited suport for automatic fan modes. Based on the work
> of Yuan Mu from Winbond, I finished the support with the great help of David
> Hubbard. The documenation update will follow.
>
> Signed-Off-By: Yuan Mu <Ymu at Winbond.com.tw>
> Signed-Off-By: Rudolf Marek <r.marek at sh.cvut.cz>
> Signed-Off-By: David Hubbard <david.c.hubbard at gmail.com>
>
> Some notes: The patch should be OK. It was checked/tested many times by me and
> David. This patch is based on ehf_patch_rc1 and ehf_patch_fix_fan45. More than
> 80 columns were fixed and on 4 places mutex lock/unlock was placed.
>
> David, please can you check/test this final patch before Jean takes it?
> Please have a look to store_pwm_enable which has non-trivial locking. I belive
> it is OK and I tested briefly, but better to be sure.
>
> Thanks,
> regards
> Rudolf


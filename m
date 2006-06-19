From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 19 Jun 2006 15:53:20 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <4dfa50520606190853k799afbf1n11288fe4a9cfb9c4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On 6/16/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> Hi all,
>
> Here comes the updated patch
>
> This patch adds long-awaited suport for automatic fan modes. Based on the work
> of Yuan Mu from Winbond, I finished the support with the great help of David
> Hubbard. The documenation update will follow.
>
> Signed-Off-By: Yuan Mu <Ymu at Winbond.com.tw>
> Signed-Off-By: Rudolf Marek <r.marek at sh.cvut.cz>
> Signed-Off-By: David Hubbard <david.c.hubbard at gmail.com>
>
> David, I fix the comment you had, thanks! Also I ripped out two more register
> exports (sf3 fan_max and fan_step). This will be neccessary to put back next round.
>
> Regards
> Rudolf

Just signing off. It looks fine to me.

David


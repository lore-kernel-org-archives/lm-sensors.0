From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 14 Sep 2005 05:39:40 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: adm9240 updates
Message-Id: <n96fi1hcbi02s0nkthr1iiu62i0l22odbc@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cslei1dpij6dbpghepu0na965d9rtfig63@4ax.com>
In-Reply-To: <cslei1dpij6dbpghepu0na965d9rtfig63@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 13 Sep 2005 22:40:38 -0400, "Mark M. Hoffman" <mhoffman@lightlink.com> wrote:
>
>Just for reference, here's the whole original function:
>
>orig > static inline int SCALE(long val, int mul, int div)
>orig > {
>orig >         if (val < 0)
>orig >                 return (val * mul - div / 2) / div;
>orig >         else
>orig >                 return (val * mul + div / 2) / div;
>orig > }
>
>So... exactly what value of div would require this fix?

Seein' things, half a div on div = zero, I'll fix it ([with] Jean's 
comments, thanks ;)

Grant.


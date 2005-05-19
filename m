From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Ticket # 1263
Message-Id: <3EE549F4.6010609@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE3B050.37FBA117@godden.net>
In-Reply-To: <3EE3B050.37FBA117@godden.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

791D support just checked into w83781d.c and sensors-detect in CVS, give it a try.

Wim Godden wrote:
> The Character C errors are gone, but the chip still isn't detected,
> although it should be supported now.
> It's a Winbond 83791, but I see :
> 
> Probing for `Winbond W83781D'
>   Trying address 0x0290... Failed!
> 
> Any suggestions welcome...
> 
> 

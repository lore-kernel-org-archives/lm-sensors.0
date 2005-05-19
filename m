From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Dev-fs
Message-Id: <3D07E362.897A4A1E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D0740F8.3090405@home.se>
In-Reply-To: <3D0740F8.3090405@home.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dick Svensson wrote:
> 
> Hi, i where just wondering if the dev-fs problem is solved?
> 
> I saw it on: http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticketQ6
> 
> have you changed it in the detect??

yes, as it says in the ticket, it was fixed,
so all the tools should look for i2c0, i2c-0, and i2c/0.

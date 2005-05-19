From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: driver initialization of chips
Message-Id: <3FB5ADC8.A055A6E5@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'd like to modify all the drivers to not initialize the chips unless
there's an init=1 argument (i.e. init=0 is the default).
I know there's been some who favor this change...
comments?

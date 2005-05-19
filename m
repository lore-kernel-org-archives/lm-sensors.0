From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: pc87360 driver
Message-Id: <20040703174537.566084b6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040508135438.42438f26.khali@linux-fr.org>
In-Reply-To: <20040508135438.42438f26.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

FYI, I just updated the pc87360 driver with a slightly altered init
procedure. As usual, you need to pass init=2 for it to take effect. The
changes were inspired by the "env4801" tool by Poul-Henning Kamp.

Let me know if it helps or not!

-- 
Jean Delvare
http://khali.linux-fr.org/

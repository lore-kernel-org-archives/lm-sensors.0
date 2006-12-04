From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Mon, 04 Dec 2006 08:14:53 +0000
Subject: [lm-sensors] testing w83627hf treiber?
Message-Id: <4573D8FD.5000504@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061204090602.07b8d41b.khali@linux-fr.org>
In-Reply-To: <20061204090602.07b8d41b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> See, this is exactly the reason why we don't reset the chip by default:
> to preserve BIOS settings.

In that case Thomas really has a problem:

Either his fans won't work or the temperature will be off.
(in my situation it looks like it is just the fans)

So how can we fix this?

Udo






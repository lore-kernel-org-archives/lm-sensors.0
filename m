From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: lm77 on national sc1100
Message-Id: <1089056486.32259.114.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 2004-07-05 at 21:30, Andras BALI wrote:

> Say, the register value for hysteresis is 2 degrees, T_crit=80,
> T_high`. So the driver should show T_crit_hystx, T_high_hystX. Now
> if the user changes T_crit to 90, T_crit_hyst should be still 78, so the
> hysteresis register should hold 12 now. However that would mean that
> T_high_hyst will show 68 now.

Eh, 48 (60-12), not 68, sorry.


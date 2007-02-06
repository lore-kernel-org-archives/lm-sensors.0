From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Feb 2007 14:49:02 +0000
Subject: [lm-sensors] sensors-detect hangs while scaning PIIX4
Message-Id: <20070206154902.ed449504.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <60685.85.231.160.112.1169927353.squirrel@webmail1.b-one.net>
In-Reply-To: <60685.85.231.160.112.1169927353.squirrel@webmail1.b-one.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

On Tue, 6 Feb 2007 14:08:20 +0100 (CET), Peter Welzien wrote:
> I've noticed that the computer also hangs if I try SpeedFan 4.31 on
> Windows XP with the same motherboard. It hangs when scanning the SMBus. If
> I disable SMBus scanning the computer doesn't hang (but don't show any
> info).

Sorry, it really looks like a hardware problem so I don't think there's
anything I can do to help you. As I suggested before, try upgrading the
BIOS to the latest version available. If it doesn't help, your best
chance is to report the problem to the board manufacturer, but as this
is an old board, odds are they won't give it a damn.

-- 
Jean Delvare


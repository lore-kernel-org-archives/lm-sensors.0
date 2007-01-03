From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 03 Jan 2007 14:31:11 +0000
Subject: [lm-sensors] w83627ehf informations
Message-Id: <20070103153111.f387b24f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163284779.5555.34.camel@armageddon>
In-Reply-To: <1163284779.5555.34.camel@armageddon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Torsten,

On Mon, 01 Jan 2007 12:03:50 +0100, slompf wrote:
> the patch does work. Though, the script still finds no correlations on 
> my board.

Well, maybe your board is actually not wired for fan speed control, or
you need to change the base PWM frequency - but the driver doesn't
support this yet. Do you have any reason to believe that your board
supports fan speed control (documentation, BIOS options, works under a
different OS)?

-- 
Jean Delvare


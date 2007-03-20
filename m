From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 20 Mar 2007 10:05:29 +0000
Subject: [lm-sensors] w83627hf and PWM base clock frequency
Message-Id: <20070320110529.166bd89d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Carlos,

On Tue, 20 Mar 2007 10:33:48 +0100 (CET), Carlos Olalla Mart?nez wrote:
> I am going to take a look to it again and will repost the patch soon.
> In order to not to make the same errors, could you please point me to a
> lm-sensors driver with pwm
> clock interface which follows the standard?

The f71805f, it87 and vt1211 drivers follow the standard.

-- 
Jean Delvare


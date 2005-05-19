From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: Controll CPU Cooler on MSI-NEO 2 Board
Message-Id: <fr2h71thit5p04ji87f4snf93tsfik3no3@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42772B44.8090204@jonasstein.de>
In-Reply-To: <42772B44.8090204@jonasstein.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 04 May 2005 09:30:11 +0200, Rudolf Marek <r.marek@sh.cvut.cz> wrote:

>This reminds me have you tried to change FAN divisors?
>
>(Just edit   w83627thf section of config file and add:
>
>set fan1_div 4
>set fan2_div 4
> set fan3_div 4
>

Time for me to throw auto fan_div into other drivers yet?
Test results, info here: http://scatter.mine.nu/hwmon/auto-fan-div/

One problem solved :o)

--Grant.

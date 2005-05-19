From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: PATCH I2C new adm9240 driver port
Message-Id: <fekt51d0vbad6lv8uupj0i3jj0imrm2tnv@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <867r515o7v3okgftkugu2ffhaaqr1efvql@4ax.com>
In-Reply-To: <867r515o7v3okgftkugu2ffhaaqr1efvql@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Khali, 

On Thu, 14 Apr 2005 08:38:13 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:

>Greetings,
>
>Completing port of adm9240 Michiel Rool started.  Much testing 
>of automatic fan clock divider operation, fan_div no longer 
>writable from user-space.  fan_div read accessor left in for 
>now so it does not break libsensors tools.
>
>Development on 2.6.11.7 with Intel SE440BX-2 mainboard.
>
>Compile test on 2.6.12-rc2-mm3.

It is yet another test version, please don't take this one :)

Cheers,
Grant.

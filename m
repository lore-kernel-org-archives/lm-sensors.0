From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: lm_sensors 2.8.1 test - more
Message-Id: <20031007221154.4d287bc8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310071329.23556.lamar@synque.com>
In-Reply-To: <200310071329.23556.lamar@synque.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> lm_sensors 2.8.1 also reported a tie for my Winbond W83627HF
> chip:
> 
> Driver `w83781d' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627HF' (confidence: 8)
> 
> Driver `w83627hf' (may not be inserted):
>   Misdetects:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627HF Super IO Sensors' (confidence: 8)
> 
> But w83781d does not show my fans, w83627hf does.

Thanks for reporting that. As you can see, both chips had the same
confidence, so I guess that sensors-detect could have suggested to use
w83627hf directly. That's something we should fix IHMO.

MDS, could you please take a look? Maybe we should raise the confidence
value of "Winbond W83627HF Super IO Sensors" to 9 so that it gets
chosen?

Lamar, does the w83627hf driver show any temperature?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

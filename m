From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Sun, 15 Nov 2009 16:01:34 +0000
Subject: Re: [lm-sensors] [PATCH v2 00/10] LIS3: Feature updates and
Message-Id: <4B0025DE.8050402@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, daniel@caiaq.de, pavel@ucw.cz, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Op 10-11-09 13:41, Samu Onkalo schreef:
> This patch set has earlier been sent to lm-sensors list (thus patch v2).
> No changes after that except to patch 0006 to make it applicable to
> 2.6.32-rc6 (no functional changes).
:
> 
> I have possibility to test these changes only with 8 bit version (lis302d).
> Since part of the changes are specific to 12 bit device, I would appreciate
> if someone could try these on 12 bit device.
I've just tested them on a 12-bit device and it seems to go fine
(excepted the rate setting in patch 8).

Andrew, maybe you could already queue the first 5 patches, as they all
look fine and are fixing bugs. So we are sure they are there for 2.6.33
:-) The rest of the patch series is useful but just "new feature" and
some need more work.

Thanks,
Eric


> 
> 0001:
> Sync event is sent after each measurement. This helps user space
> applications to detect which 3 reported values belongs to
> one atomic measurement.
> 
> 0002:
> polled input device was not totally released in module unload.
> This corrects memory leak. 
> 
> 0003:
> This patch is originally from Eric Piel. 
> Updates documentation and chip ID handling
> 
> 0004:
> This patch is originally from Eric Piel.
> Correction to sampling rate handling for 8 bit devices
> 
> 0005:
> Chip power on sequence was not waiting for chip to be ready.
> This caused incorrect values right after the power on.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

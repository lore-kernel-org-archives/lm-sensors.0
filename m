From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 09 Dec 2006 21:21:40 +0000
Subject: [lm-sensors] Working on a driver for the Andigilog aSC7621
Message-Id: <457B28E4.9010205@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

George T. Joseph (development) wrote:
> The sensors-detect patch has a little bug:  You're using $mid to test
> for the chip id instead of $cid.   

Ah. I commited fixed version into SVN. Please try that out.

> Thanks,
> Regards
> Rudolf


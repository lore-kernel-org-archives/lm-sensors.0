From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Tue, 22 Feb 2011 20:18:59 +0000
Subject: Re: [lm-sensors] Add support for LM75A.
Message-Id: <20110222201859.GI343@caffeine.csclub.uwaterloo.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219115159.2da19dfe@endymion.delvare>
In-Reply-To: <20110219115159.2da19dfe@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 22, 2011 at 08:56:30PM +0100, Jean Delvare wrote:
> And it was never meant to. As said before, the detection of the LM75
> proper is there only because the chip was once popular on PC
> mainboards. None of the other chips supported by the lm75 driver was as
> far as I know.

Actually one of the products we will have the LM75A in is an x86
industrial PC, so I guess that counts as being in a PC.  Up until now
they were LM75Cs (the old ones), so autodetection was handy.

-- 
Len Sorensen

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

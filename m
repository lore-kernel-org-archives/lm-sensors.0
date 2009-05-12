From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 May 2009 16:30:53 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/7] sensord: Refactoring of parseChips()
Message-Id: <20090512183053.372de49b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090511160401.GE17530@ubuntu>
In-Reply-To: <20090511160401.GE17530@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 11 May 2009 18:04:01 +0200, Andre Prendel wrote:
> Did some refactoring in parseChips(). This fixes some deep indentation
> levels.
> 
> Changes in v2:
> 
> Make condition (are there chips arguments?) easier to read.
> Removed withspace (coding style).

Looks good, please commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

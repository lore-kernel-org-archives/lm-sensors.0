From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 14 Feb 2007 19:33:22 +0000
Subject: [lm-sensors] Abit AT8 (non-32X) / Winbond 83627EHF
Message-Id: <20070214203322.3a671339.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D0A4B2.6030002@vt.edu>
In-Reply-To: <45D0A4B2.6030002@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David, Rick,

Could you please stop top-posting? It's very hard to follow what's
going on here.

On Wed, 14 Feb 2007 12:12:37 -0700, David Hubbard wrote:
> Next week I'm going to be out of town. I'm the one who should be
> figuring this out, but I'm going to pass the buck (at least until the
> 26th). To Jean and Rudolf: what's the next step in debugging this one?

Given that the W83627EHF chip doesn't appear to provide temperatures
either, my guess is that there is a second hardware monitoring chip
taking care of the fans and temperatures. I suggest that Rick provides
the output of a recent version of sensors-detect.

Rick, please also report what hardware monitoring values are presented
in the BIOS setup screen.

-- 
Jean Delvare


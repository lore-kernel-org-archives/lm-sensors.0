From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Tyan S4882 support complete
Message-Id: <xFPNrw7q.1100604711.1376100.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041115231910.2bd44311.khali@linux-fr.org>
In-Reply-To: <20041115231910.2bd44311.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Quoting Brandon Hammersley:
> The S2850 is definitely possible. However, it may not work for what Jean
> needs to do. The S2850 is AMI BIOS & the S4882 is Phoenix based. There may
> be differences in the location of the DMI data. I need to check the SMBIOS
> spec to verify this.

As long as dmidecode [1] finds the DMI table, the board should be
suitable for the immediate job of adding DMI support to linux-x86_64
2.6. The exact location of the DMI table can change according to the
SMBIOS specs and both dmidecode and linux-i386 are fine with that, and
whatever I do for x86_64 will handle it as well.

Quoting Maurice Hilarius:
> OK, well, other ideas are welcomed..
> Let me know..

I may add that the S2875S (or S2875 with a single CPU, for that matter)
would probably be a more viable solution for me. The S2850 is strongly
server-oriented with a weak GFX chip on-board and no AGP slot. I could
only use it as a test system. On the other hand, I could use an S2875(S)
as my main workstation by simply adding a decent AGP graphics card to
it. This would ensure a much better testing in the long-run.

Don't get me wrong though. The primary goal is obviously to setup a test
machine and an S2850-based would do IMHO. The possibility for me to use
it on a regular basis would be valuable but isn't a requirement.

Thanks,
Jean

[1] http://www.nongnu.org/dmidecode/

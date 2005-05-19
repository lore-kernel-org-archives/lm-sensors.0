From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: lm-sensors bug report filed??
Message-Id: <3C3D90C8.9B06988@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <15420.60548.41937.165100@khufu.rjmx.net>
In-Reply-To: <15420.60548.41937.165100@khufu.rjmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't recall seeing your ticket but email is fine too.
you are saying that sensors-detect finds the 686 but modprobe
(i2c-viapro or via686a?) 
doesn't work. Check dmesg / syslog for clues.
If you need more help send us the dmesg/syslog info, also 'lspci -n'.
mds

Ron Murray wrote:
> 
> Hi.
> 
>    I filed a bug report on your website a couple of weeks ago, but
> haven't heard anything yet. Did I post it successfully, or should I
> try again?
> 
>    To recap, the problem occurs on my Compaq 7000US machine with 1.2G AMDAthlon
> processor. lm-sensors doesn't load; system claims there's a "VIA
> Technologies VT82C686 Apollo ACPI" on board, but the module fails to
> load, claiming that there's no such device.
> 
>    Let me know if I need to re-file the report.
> 
> Thanks for your work!
> 
>  .....Ron
> 
> --
> Ron Murray   (rjmx@rjmx.net)
> https://www.rjmx.net/~ron
> GPG Public Key Fingerprint: F2C1 FC47 5EF7 0317 133C  D66B 8ADA A3C4 D86C 74DE

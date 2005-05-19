From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: bug report?!
Message-Id: <n2Mj0gJI.1091796136.5931870.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1Bt0wR-0002TF-00@intern.SerNet.DE>
In-Reply-To: <E1Bt0wR-0002TF-00@intern.SerNet.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>The other problem i spotted is that your tar.gz archive of i2c-2.8.7 is not
>a gzip archive.
>
>dhcp230:~ # file i2c-2.8.7.tar.gz
>i2c-2.8.7.tar.gz: POSIX tar archive
>
>A not that much confidant user could be very confused if he is downloading a
>tar.gz from you website which is a tar.

I just checked, the file is really a tar.gz file, sent by the HTTP server
with type application/x-tar. This seems to be reasonably standard
(Savannah does the same for example).

So I suspect that your web browser gunzip'ed the file on the fly. You
most probably can configure it not to do so. Else you can still use an
external download tool such as wget.

At any rate, a web browser gunzip'ing files on the fly without removing
the .gz suffix is obviously not doing the right thing and needs fixing.

Thanks for reporting.
Jean Delvare

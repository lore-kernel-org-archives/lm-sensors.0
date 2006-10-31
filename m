From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 31 Oct 2006 15:26:27 +0000
Subject: [lm-sensors] grafting lm-sensors 2.10.1 onto red hat kernel
Message-Id: <LI5et0kD.1162308387.5741660.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Steven,

On 10/31/2006, Steven Timm wrote:
> Is the w83792d chip one of those supported in the newer 2.6 kernels?
> that's the main one I need that the current redhat distro kernel doesn't
> have.

Yes it is. The w83792d driver was added in Linux 2.6.14, according to:
http://www.lm-sensors.org/wiki/Devices
Note that there's a link to a version of the driver for older kernels,
which might come in handy in this case. That version might lack the
latest fixes though.

> Also, which version of the Linus' 2.6 kernel tree should I point them at
> to get the current production code level?

Latest stable kernel, of course (i.e. at the moment: 2.6.18.1).

--
Jean Delvare


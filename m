From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sun, 04 Dec 2005 19:29:51 +0000
Subject: [lm-sensors] Re: PC87431 on SUSE 10.0 2.6.13-15
Message-Id: <253818670512041029g7a27b218h20ed9f2e870465b1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <008201c5f8fd$0db50a70$fe78a8c0@doppelhertz>
In-Reply-To: <008201c5f8fd$0db50a70$fe78a8c0@doppelhertz>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

On 12/4/05, Sch?fer Raumgestaltung <mail@schaefer-raumgestaltung.de> wrote:
>
> do you have any idea where to find patches for Kernel 2.6.13-15
> dealing with HWMON / SYSFS to get access to
> my BMC PC87431 via BMCSENSORS

Sorry >=3D2.6.13 is unsupported at the moment, I'm trying to push
through a patch for IPMI sysfs support (see
http://sourceforge.net/mailarchive/forum.php?thread_id=9131673&forum_id=140=
82),
and I'm most of the way towards rewriting the driver. See
http://bmcsensors-26.sourceforge.net/ for updates.

Thanks,
Yani

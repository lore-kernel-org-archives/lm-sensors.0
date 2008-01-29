From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Tue, 29 Jan 2008 09:59:46 +0000
Subject: Re: [lm-sensors] [PATCH] HARDWARE MONITORING: Remove redundant
Message-Id: <alpine.LFD.1.00.0801290459350.27313@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LFD.1.00.0801281327470.22776@localhost.localdomain>
In-Reply-To: <alpine.LFD.1.00.0801281327470.22776@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 29 Jan 2008, Jean Delvare wrote:

> Hi Robert,
>
> On Mon, 28 Jan 2008 13:30:22 -0500 (EST), Robert P. J. Day wrote:
> >
> > Since this source file already includes <log2.h>, there's no reason
> > for it to redefine a power of 2 check.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> This patch is already in Mark's hwmon-testing tree:
> http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dcommit=
;h=89eab87c21ffed88fe990876a7f754a4ddb34a83
>
> All you have to do is wait for him to send a pull request to Linus
> (which should happen within a week, I guess.)

ok, thanks.

rday
--
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

Home page:                                         http://crashcourse.ca
Fedora Cookbook:    http://crashcourse.ca/wiki/index.php/Fedora_Cookbook
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

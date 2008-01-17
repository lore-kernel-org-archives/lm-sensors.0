From: Mike Houston <mikeserv@bmts.com>
Date: Thu, 17 Jan 2008 22:00:03 +0000
Subject: Re: [lm-sensors] [Bug 9514] it87 probe failure in 2.6.24-rc -- what
Message-Id: <20080117170003.7297ce39.mikeserv@bmts.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200801171339.00887.bjorn.helgaas@hp.com>
In-Reply-To: <200801171339.00887.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jean Delvare <khali@linux-fr.org>, bugme-daemon@bugzilla.kernel.org, Shaohua Li <shaohua.li@intel.com>, Mike Houston <mikeserv@bmts.com>, Adrian Bunk <bunk@stusta.de>, Elvis Pranskevichus <el@prans.net>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Adam Belay <ambx1@neo.rr.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

On Thu, 17 Jan 2008 13:38:57 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Where are we with this problem?
> (http://bugzilla.kernel.org/show_bug.cgi?id=9514)

> The second option I see is to use my patch
> (http://bugzilla.kernel.org/attachment.cgi?id=14267&action=3Dview)
> to make it87 request only the ports it uses.

> Whatever we do, it'd be nice to have a fix in 2.6.24, and I think my
> patch is the least evil for now.

From my perspective it sure seems to be the least evil, because it
only touches what needs to be touched for my situation. I of course
can't say how it would affect others.

I'm still using your patch (on 2.6.24-rc8 now) but I'll test whatever
other solutions you folks may come up with.

Mike Houston

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

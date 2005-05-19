From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [mas@ssl.co.uk: [ltp] Incorporating Thinkpad Detection into Lm_sensors]
Message-Id: <20020722095819.B16805@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


More good info from the linux-thinkpad mailing list.

----- Forwarded message from Michael Selway <mas@ssl.co.uk> -----

Delivered-To: linux-thinkpad-outgoing@www.bm-soft.com
Delivered-To: linux-thinkpad@www.bm-soft.com
From: Michael Selway <mas@ssl.co.uk>
Date: Mon, 22 Jul 2002 09:18:21 +0100
To: linux-thinkpad@www.bm-soft.com
Subject: [ltp] Incorporating Thinkpad Detection into Lm_sensors
In-Reply-To: <20020720160329.K1076@Stimpy.netroedge.com>
X-Mailer: VM 7.04 under Emacs 21.2.1
Precedence: bulk
Reply-To: linux-thinkpad@www.bm-soft.com
X-SpamBouncer: 1.6 beta (6/22/02)
X-SBNote: FROM_DAEMON/Listserv
X-SBClass: Bulk

phil@netroedge.com writes:
 > So, I need your help!  How can we detect a Thinkpad?

There's some code in arch/i386/kernel/dmi_scan.c whose intention
is to change an APM setting for all IBM laptops.  The relevant
table entry looks like this in 2.4.18:

{ set_apm_ints, "IBM", {	/* Allow interrupts during suspend on IBM laptops */
		MATCH(DMI_SYS_VENDOR, "IBM"),
		NO_MATCH, NO_MATCH, NO_MATCH
		} },


HTH,
Michael.

----- The Linux ThinkPad mailing list -----
The linux-thinkpad mailing list home page is at:
http://www.bm-soft.com/~bm/tp_mailing.html

----- End forwarded message -----

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
